from .queries import get_all_movies, get_movies_with_stores, get_all_stores, get_top_checked_out_movies, get_top_rated_movies, get_customer_rentals, get_all_customer_rentals, get_all_movies_with_availability
from sqlalchemy import text
from flask import Blueprint, request, render_template, url_for, redirect, flash, session
from . import db

main = Blueprint('main', __name__)


################# HOME PAGE #################
@main.route('/')
def index():
    return render_template('index.html')


################# CUSTOMER SIGNUP #################
@main.route("/customer-signup", methods=["GET", "POST"])
def customer_signup():
    error_message = None  
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        name = request.form.get("name")
        email = request.form.get("email")
        phone_number = request.form.get("phone_number")

        # generates next customer_id
        sql_get_max_id = text("SELECT MAX(customer_id) FROM Customer")
        max_id_result = db.session.execute(sql_get_max_id).scalar()
        next_customer_id = (max_id_result or 0) + 1

        # checks for duplicates
        sql_check_duplicates = text("""
            SELECT * FROM Customer
            WHERE username = :username OR email = :email
        """)
        duplicate = db.session.execute(sql_check_duplicates, {"username": username, "email": email}).fetchone()

        # ERROR message for duplicates
        if duplicate:
            error_message = "Username or email already in use. Please use a unique username and email."
            return render_template("customer_signup.html", error_message=error_message)

        # insert customer data attached to new customer ID
        # inputs are parameterized
        sql_insert = text("""
            INSERT INTO Customer (customer_id, username, password, name, email, phone_number)
            VALUES (:customer_id, :username, :password, :name, :email, :phone_number)
        """)

        try:
            db.session.execute(sql_insert, {
                "customer_id": next_customer_id,
                "username": username,
                # not hashed
                "password": password, 
                "name": name,
                "email": email,
                "phone_number": phone_number
            })
            db.session.commit()

            # session established
            session['customer_id'] = next_customer_id
            return redirect(url_for("main.customer_dashboard"))  
        
        # error message if not successful
        except Exception as e:
            db.session.rollback()
            error_message = f"Sign up failed due to an error"
            return render_template("customer_signup.html", error_message=error_message)

    #returns to sign up if not successful
    return render_template("customer_signup.html", error_message=error_message)


################# EMPLOYEE LOGIN #################
@main.route("/employee-login", methods=["GET", "POST"])
def employee_login():
    error_message = None  
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        # sql query that checks input against database
        query = text("SELECT * FROM employee WHERE username = :username AND password = :password")
        result = db.session.execute(query, {"username": username, "password": password}).fetchone()

        if result:
            # successful, go to main dash
            return redirect(url_for("main.employee_dashboard"))
        else:
            # invalid presents with error messages
            error_message = "Username or password incorrect."

    # returns error message on login screen
    return render_template("employee_login.html", error_message=error_message)


################# CUSTOMER DASHBOARD #################
@main.route("/customer-dashboard", methods=["GET", "POST"])
def customer_dashboard():
    return render_template("customer_dash.html")


################# GET ALL OF THE MOVIES #################
@main.route("/all-movies", methods=["GET"])
def all_movies():
    movies = get_all_movies() 
    return render_template("all_movies.html", movies=movies)


################# BROWSE BY STORE #################
@main.route("/browse-by-store", methods=["GET", "POST"])
def browse_by_store():
    store_id = None
    movies = []
    stores = get_all_stores()  

    # fetch movies by store
    if request.method == "POST":
        store_id = request.form.get("store_id") 
        if store_id:
            movies = get_movies_with_stores(store_id)  

    return render_template(
        "browse_by_store.html",
        movies=movies,
        stores=stores,
        store_id=store_id
    )


################# BROWSE TOP MOVIES #################
@main.route("/browse-top-movies", endpoint="browse-top-movies", methods=["GET", "POST"])
def browse_top_movies():

    # fetch top 5 movies by rentals and IMDB rating
    top_checked_out_movies = get_top_checked_out_movies()
    top_rated_movies = get_top_rated_movies()

    return render_template(
        "browse_top_movies.html",
        top_checked_out_movies=top_checked_out_movies,
        top_rated_movies=top_rated_movies
    )


################# SEARCH #################
@main.route("/search", methods=["GET", "POST"])
def search_movies():
    search_term = None
    movies = []

    if request.method == "POST":
        search_term = request.form.get("search") 
        from .queries import search_movies 
        movies = search_movies(search_term)  

    return render_template("search_movies.html", movies=movies, search_term=search_term)


################# RENT MOVIE #################
@main.route('/rent-movie', methods=['POST'])
def rent_movie():
    # make sure user is logged in
    if 'customer_id' not in session:
        flash("Please log in to rent a movie.", "error")
        return redirect(url_for("main.customer_signup"))

    # Get ids from session and form
    customer_id = session['customer_id']
    movie_id = request.form.get('movie_id')
    store_id = request.form.get('store_id')

    if not store_id:
        flash("Please select a store.", "error")
        return redirect(url_for("main.all_movies"))

    # check if store has copies
    available_copies = db.session.execute(
        text("SELECT available_copies FROM Inventory WHERE movie_id = :movie_id AND store_id = :store_id"),
        {"movie_id": movie_id, "store_id": store_id}
    ).scalar()

    # if not display error
    if not available_copies or available_copies <= 0:
        flash("Selected store does not have available copies.", "error")
        return redirect(url_for("main.all_movies"))

    # deduct one copy from the inventory
    db.session.execute(
        text("UPDATE Inventory SET available_copies = available_copies - 1 WHERE movie_id = :movie_id AND store_id = :store_id"),
        {"movie_id": movie_id, "store_id": store_id}
    )

    # add a new rental record
    db.session.execute(
        text("""
            INSERT INTO Rental (customer_id, movie_id, store_id, rental_date, return_date)
            VALUES (:customer_id, :movie_id, :store_id, CURDATE(), NULL)
        """),
        {"customer_id": customer_id, "movie_id": movie_id, "store_id": store_id}
    )

    # commitchanges
    db.session.commit()

    # fetch movie title and store name for confirmation
    movie_title = db.session.execute(
        text("SELECT title FROM Movie WHERE movie_id = :movie_id"),
        {"movie_id": movie_id}
    ).scalar()
    store_name = db.session.execute(
        text("SELECT store_name FROM Store WHERE store_id = :store_id"),
        {"store_id": store_id}
    ).scalar()

    return render_template(
        'rent_confirmation.html',
        movie_title=movie_title,
        store_name=store_name
    )


################# RENT MOVIE #################
@main.route("/my-rentals")
def my_rentals():
    # make sure user logged in
    if 'customer_id' not in session:
        flash("Please log in to view your rentals.", "error")
        return redirect(url_for("main.customer_signup"))

    # get customer_id from session and get their rentals
    customer_id = session['customer_id']
    rentals = get_customer_rentals(customer_id)
    return render_template("my_rentals.html", rentals=rentals)


################# EMPLOYEE DASH #################
@main.route('/employee-dashboard')
def employee_dashboard():
    return render_template('employee_dash.html')


################# EDIT MOVIE LIST #################
@main.route("/edit-movie-list", methods=["GET"])
def edit_movie_list():
    movies = get_all_movies_with_availability() 
    return render_template("edit_movie_list.html", movies=movies)


################# EDIT MOVIE INDIVIDUAL #################
@main.route("/edit-movie/<int:movie_id>", methods=["GET", "POST"])
def edit_movie(movie_id):
    if request.method == "POST":
        # update available copies for each store
        store_ids = request.form.getlist("store_id")
        available_copies = request.form.getlist("available_copies")

        for store_id, copies in zip(store_ids, available_copies):
            db.session.execute(
                text("""
                    UPDATE Inventory
                    SET available_copies = :available_copies
                    WHERE movie_id = :movie_id AND store_id = :store_id
                """),
                {"available_copies": copies, "movie_id": movie_id, "store_id": store_id}
            )
        db.session.commit()
        flash("Movie availability updated successfully!", "success")
        return redirect(url_for("main.edit_movie_list"))

    # fetch movie details
    movie = db.session.execute(
        text("SELECT * FROM Movie WHERE movie_id = :movie_id"),
        {"movie_id": movie_id}
    ).mappings().first()

    if not movie:
        flash("Movie not found.", "error")
        return redirect(url_for("main.edit_movie_list"))

    # fetch store availability
    stores = db.session.execute(
        text("""
            SELECT 
                s.store_id, s.store_name, i.available_copies
            FROM 
                Inventory i
            JOIN 
                Store s ON i.store_id = s.store_id
            WHERE 
                i.movie_id = :movie_id
        """),
        {"movie_id": movie_id}
    ).mappings().all()

    return render_template("edit_movie.html", movie=movie, stores=stores)


################# ADD MOVIE #################
@main.route("/add-movie", methods=["GET", "POST"])
def add_movie():
    if request.method == "POST":
        # Fetch movie details from the form
        title = request.form.get("title")
        genre = request.form.get("genre")
        actor = request.form.get("actor") or None  
        actress = request.form.get("actress") or None
        director = request.form.get("director")
        maturity_rating = request.form.get("maturity_rating")
        release_year = request.form.get("release_year")
        length_of_movie = request.form.get("length_of_movie")
        country_of_origin = request.form.get("country_of_origin")
        imbd_rating = request.form.get("imbd_rating")
        store_id = request.form.get("store_id")
        available_copies = request.form.get("available_copies")

        # generate the next movie_id manually
        max_movie_id = db.session.execute(
            text("SELECT MAX(movie_id) FROM Movie")
        ).scalar()
        new_movie_id = (max_movie_id or 0) + 1

        # insert the new movie into the Movie table
        db.session.execute(
            text("""
                INSERT INTO Movie (
                    movie_id, title, genre, actor, actress, director,
                    maturity_rating, release_year, length_of_movie,
                    country_of_origin, imbd_rating
                ) VALUES (
                    :movie_id, :title, :genre, :actor, :actress, :director,
                    :maturity_rating, :release_year, :length_of_movie,
                    :country_of_origin, :imbd_rating
                )
            """),
            {
                "movie_id": new_movie_id,
                "title": title,
                "genre": genre,
                "actor": actor,
                "actress": actress,
                "director": director,
                "maturity_rating": maturity_rating,
                "release_year": release_year,
                "length_of_movie": length_of_movie,
                "country_of_origin": country_of_origin,
                "imbd_rating": imbd_rating,
            }
        )

        # insert into inventory
        db.session.execute(
            text("""
                INSERT INTO Inventory (movie_id, store_id, available_copies)
                VALUES (:movie_id, :store_id, :available_copies)
            """),
            {
                "movie_id": new_movie_id,
                "store_id": store_id,
                "available_copies": available_copies,
            }
        )
        db.session.commit()

        flash("Movie added successfully!", "success")
        return redirect(url_for("main.edit_movie_list"))

    # fetch all stores for the dropdown
    stores = db.session.execute(
        text("SELECT store_id, store_name FROM Store")
    ).mappings().all()

    return render_template("add_movie.html", stores=stores)

################# SEE RENTALS #################
@main.route("/see-rentals")
def see_rentals():
    rentals = get_all_customer_rentals()  # Fetch all rentals
    return render_template("see_rentals.html", rentals=rentals)


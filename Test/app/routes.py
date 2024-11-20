from .queries import get_all_movies, get_movies_by_store, get_all_stores, search_movies
from sqlalchemy import text
from flask import Blueprint, request, render_template
from . import db

main = Blueprint('main', __name__)

@main.route('/')
def index():
    sql = text("SELECT * FROM movie")
    result = db.session.execute(sql)
    movies = result.mappings().all()  # Use .mappings().all() for dictionary-like results
    return render_template('index.html', movies=movies)

@main.route("/customer-signup", methods=["GET", "POST"])
def customer_signup():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        name = request.form.get("name")
        email = request.form.get("email")
        phone_number = request.form.get("phone_number")

        # Generate the next customer_id manually
        sql_get_max_id = text("SELECT MAX(customer_id) FROM Customer")
        max_id_result = db.session.execute(sql_get_max_id).scalar()
        next_customer_id = (max_id_result or 0) + 1

        # Insert the customer data with manually generated ID
        sql_insert = text("""
            INSERT INTO Customer (customer_id, username, password, name, email, phone_number)
            VALUES (:customer_id, :username, :password, :name, :email, :phone_number)
        """)

        try:
            db.session.execute(sql_insert, {
                "customer_id": next_customer_id,
                "username": username,
                "password": password,  # In a real app, hash the password
                "name": name,
                "email": email,
                "phone_number": phone_number
            })
            db.session.commit()
            return f"Sign up successful! Welcome, {name}"
        except Exception as e:
            db.session.rollback()
            return f"Sign up failed: {e}", 400

    return render_template("customer_signup.html")


@main.route("/employee-login", methods=["GET", "POST"])
def employee_login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        # Execute raw SQL query
        query = text("SELECT * FROM employee WHERE username = :username AND password = :password")
        result = db.session.execute(query, {"username": username, "password": password})
        employee = result.fetchone()

        if employee:
            return f"Welcome, {employee[1]}!"  # Assuming the second column is 'username'
        else:
            return "Invalid username or password!", 401

    # Render the login page for GET requests
    return render_template("employee_login.html")

@main.route("/customer-dashboard", methods=["GET", "POST"])
def customer_dashboard():
    store_id = None
    store_name = None
    movies = []
    stores = get_all_stores()  # Fetch all stores for the dropdown
    search_term = None
    
    if request.method == "POST":
        store_id = request.form.get("store_id")
        if store_id:
            movies = get_movies_by_store(store_id)
        elif "search" in request.form:  # Search for movies
            search_term = request.form.get("search")
            if search_term:
                movies = search_movies(search_term)

    return render_template("customer_dash.html", movies=movies, stores=stores, store_id=store_id,search_term=search_term)


@main.route('/employee-dashboard')
def employee_dashboard():
    return render_template('employee_dash.html')


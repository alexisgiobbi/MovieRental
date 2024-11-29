from sqlalchemy.sql import text
from . import db

# get employee credentials, converts to dictionary for display
def get_employee_by_credentials(username, password):
    sql = text("SELECT * FROM employee WHERE username = :username AND password = :password")
    result = db.session.execute(sql, {"username": username, "password": password})
    return result.mappings().first()

# for browse by store, makes sure there are available copies, gets customer reviews where they exist
def get_movies_with_stores(store_id=None):
    sql = """
        SELECT 
            m.movie_id AS movie_id,
            m.title AS title,
            m.genre AS genre,
            m.actor AS actor,
            m.actress AS actress,
            m.director AS director,
            m.maturity_rating AS maturity_rating,
            m.release_year AS release_year,
            m.length_of_movie AS length_of_movie,
            m.country_of_origin AS country_of_origin,
            m.imbd_rating AS imbd_rating,
            i.available_copies AS available_copies,
            s.store_name AS store_name,
            cr.customer_review_id AS customer_review_id,
            cr.customer_id AS customer_id,
            cr.rating AS rating,
            cr.written_review AS written_review,
            cr.review_date AS review_date
        FROM 
            Inventory i
        JOIN 
            Movie m ON i.movie_id = m.movie_id
        JOIN 
            Store s ON i.store_id = s.store_id
        LEFT JOIN 
            Customer_Review cr ON m.movie_id = cr.movie_id
        WHERE 
            i.available_copies > 0
    """
    if store_id:
        sql += " AND i.store_id = :store_id"

    sql += " ORDER BY m.movie_id, cr.review_date"

    result = db.session.execute(
        text(sql),
        {"store_id": store_id} if store_id else {}
    )
    return result.mappings().all()


def get_all_stores():
    sql = text("SELECT store_id, store_name FROM Store")
    result = db.session.execute(sql)
    return result.mappings().all()


# search movies
def search_movies(query):
    sql = text("""
        SELECT 
            m.movie_id AS movie_id,
            m.title AS title,
            m.genre AS genre,
            m.actor AS actor,
            m.actress AS actress,
            m.director AS director,
            m.maturity_rating AS maturity_rating,
            m.release_year AS release_year,
            m.length_of_movie AS length_of_movie,
            m.country_of_origin AS country_of_origin,
            m.imbd_rating AS imbd_rating,
            GROUP_CONCAT(DISTINCT CONCAT(s.store_id, ':', s.store_name) SEPARATOR ';') AS store_data,
            cr.customer_review_id AS customer_review_id,
            cr.customer_id AS customer_id,
            cr.rating AS rating,
            cr.written_review AS written_review,
            cr.review_date AS review_date
        FROM 
            Inventory i
        JOIN 
            Movie m ON i.movie_id = m.movie_id
        JOIN 
            Store s ON i.store_id = s.store_id
        LEFT JOIN 
            Customer_Review cr ON m.movie_id = cr.movie_id
        WHERE 
            (m.title LIKE :query OR 
            m.actor LIKE :query OR 
            m.actress LIKE :query OR 
            m.genre LIKE :query OR 
            m.director LIKE :query) AND
            i.available_copies > 0
        GROUP BY 
            m.movie_id, cr.customer_review_id
    """)
    results = db.session.execute(sql, {"query": f"%{query}%"}).mappings().all()

    # Process store data
    movies = []
    for result in results:
        movie = dict(result)
        movie['stores'] = []

        if movie.get('store_data'):
            stores = movie['store_data'].split(';')
            for store in stores:
                store_id, store_name = store.split(':')
                movie['stores'].append({'store_id': int(store_id), 'store_name': store_name})

        movies.append(movie)
    return movies

# for edit movie list, needs to display availability
def get_all_movies_with_availability():
    sql = text("""
        SELECT 
            m.movie_id,
            m.title,
            m.genre,
            m.actor,
            m.actress,
            m.director,
            m.maturity_rating,
            m.release_year,
            m.length_of_movie,
            m.country_of_origin,
            m.imbd_rating,
            GROUP_CONCAT(CONCAT(i.available_copies, ' copies at ', s.store_name) SEPARATOR ', ') AS availability
        FROM 
            Movie m
        LEFT JOIN 
            Inventory i ON m.movie_id = i.movie_id
        LEFT JOIN 
            Store s ON i.store_id = s.store_id
        GROUP BY 
            m.movie_id
    """)

    results = db.session.execute(sql).mappings().all()
    return results

def get_all_movies():
    sql = """
        SELECT 
            m.movie_id AS movie_id,
            m.title AS title,
            m.genre AS genre,
            m.actor AS actor,
            m.actress AS actress,
            m.director AS director,
            m.maturity_rating AS maturity_rating,
            m.release_year AS release_year,
            m.length_of_movie AS length_of_movie,
            m.country_of_origin AS country_of_origin,
            m.imbd_rating AS imbd_rating,
            GROUP_CONCAT(DISTINCT CONCAT(s.store_id, ':', s.store_name) SEPARATOR ';') AS store_data,
            cr.customer_review_id AS customer_review_id,
            cr.customer_id AS customer_id,
            cr.rating AS rating,
            cr.written_review AS written_review,
            cr.review_date AS review_date
        FROM 
            Movie m
        LEFT JOIN 
            Inventory i ON m.movie_id = i.movie_id
        LEFT JOIN 
            Store s ON i.store_id = s.store_id
        LEFT JOIN 
            Customer_Review cr ON m.movie_id = cr.movie_id
        WHERE 
            i.available_copies > 0
        GROUP BY 
            m.movie_id, cr.customer_review_id
    """
    results = db.session.execute(text(sql)).mappings().all()

    # process results to include stores and reviews
    movies = []
    for result in results:
        movie = dict(result) 

        movie['stores'] = []
        if movie.get('store_data'):
            stores = movie['store_data'].split(';')
            for store in stores:
                store_id, store_name = store.split(':')
                movie['stores'].append({'store_id': int(store_id), 'store_name': store_name})

        movies.append(movie)

    return movies

def get_top_checked_out_movies():
    sql = text("""
        SELECT 
            m.movie_id,
            m.title,
            GROUP_CONCAT(DISTINCT CONCAT(s.store_id, ':', s.store_name) SEPARATOR ';') AS store_data,
            COUNT(r.rental_id) AS rental_count,
            m.genre, m.actor, m.actress, m.director, m.maturity_rating, m.release_year,
            m.length_of_movie, m.country_of_origin, m.imbd_rating
        FROM 
            Rental r
        JOIN 
            Movie m ON r.movie_id = m.movie_id
        LEFT JOIN 
            Inventory i ON m.movie_id = i.movie_id
        LEFT JOIN 
            Store s ON i.store_id = s.store_id
        WHERE 
            i.available_copies > 0
        GROUP BY 
            m.movie_id
        ORDER BY 
            rental_count DESC
        LIMIT 5
    """)
    results = db.session.execute(sql).mappings().all()

    # convert results to dictionaries and process store data
    movies = []
    for result in results:
        movie = dict(result)
        movie['stores'] = []

        if movie.get('store_data'):
            stores = movie['store_data'].split(';')
            for store in stores:
                store_id, store_name = store.split(':')
                movie['stores'].append({'store_id': int(store_id), 'store_name': store_name})

        movies.append(movie)

    return movies


def get_top_rated_movies():
    sql = text("""
        SELECT 
            m.movie_id,
            m.title,
            GROUP_CONCAT(DISTINCT CONCAT(s.store_id, ':', s.store_name) SEPARATOR ';') AS store_data,
            m.genre, m.actor, m.actress, m.director, m.maturity_rating, m.release_year,
            m.length_of_movie, m.country_of_origin, m.imbd_rating
        FROM 
            Movie m
        LEFT JOIN 
            Inventory i ON m.movie_id = i.movie_id
        LEFT JOIN 
            Store s ON i.store_id = s.store_id
        WHERE 
            i.available_copies > 0
        GROUP BY 
            m.movie_id
        ORDER BY 
            m.imbd_rating DESC
        LIMIT 5
    """)
    results = db.session.execute(sql).mappings().all()

    movies = []
    for result in results:
        movie = dict(result) 
        movie['stores'] = []

        if movie.get('store_data'):
            stores = movie['store_data'].split(';')
            for store in stores:
                store_id, store_name = store.split(':')
                movie['stores'].append({'store_id': int(store_id), 'store_name': store_name})

        movies.append(movie)

    return movies


def get_customer_rentals(customer_id):
    sql = text("""
        SELECT 
            r.rental_id,
            m.title AS movie_title,
            r.rental_date,
            r.return_date,
            s.store_name,
            c.username AS customer_username,
            c.email AS customer_email
        FROM 
            Rental r
        JOIN 
            Movie m ON r.movie_id = m.movie_id
        JOIN 
            Store s ON r.store_id = s.store_id
        JOIN 
            Customer c ON r.customer_id = c.customer_id
        WHERE 
            r.customer_id = :customer_id
        ORDER BY 
            r.rental_date DESC
    """)
    result = db.session.execute(sql, {"customer_id": customer_id})
    return result.mappings().all()


def get_all_customer_rentals():
    sql = text("""
        SELECT 
            r.rental_id,
            m.title AS movie_title,
            r.rental_date,
            r.return_date,
            s.store_name,
            c.username AS customer_username,
            c.email AS customer_email
        FROM 
            Rental r
        JOIN 
            Movie m ON r.movie_id = m.movie_id
        JOIN 
            Store s ON r.store_id = s.store_id
        JOIN 
            Customer c ON r.customer_id = c.customer_id
        ORDER BY 
            r.rental_date DESC
    """)
    result = db.session.execute(sql)
    return result.mappings().all()


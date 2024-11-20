from sqlalchemy.sql import text
from . import db

def get_all_movies():
    sql = text("SELECT * FROM movie")
    result = db.session.execute(sql)
    return result.mappings().all() 

def get_employee_by_credentials(username, password):
    sql = text("SELECT * FROM employee WHERE username = :username AND password = :password")
    result = db.session.execute(sql, {"username": username, "password": password})
    return result.mappings().first()

def get_movies_by_store(store_id):
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
        i.available_copies AS available_copies
    FROM 
        Inventory i
    JOIN 
        Movie m ON i.movie_id = m.movie_id
    WHERE 
        i.store_id = :store_id
""")

    result = db.session.execute(sql, {"store_id": store_id})
    return result.mappings().all()

def get_store_name(store_id):
    sql = text("SELECT store_name FROM Store WHERE store_id = :store_id")
    result = db.session.execute(sql, {"store_id": store_id}).scalar()
    return result


def get_all_stores():
    sql = text("SELECT store_id, store_name FROM Store")
    result = db.session.execute(sql)
    return result.mappings().all()

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
            i.available_copies AS available_copies,
            s.store_name AS store_name,
            s.store_id AS store_id
        FROM 
            Inventory i
        JOIN 
            Movie m ON i.movie_id = m.movie_id
        JOIN 
            Store s ON i.store_id = s.store_id
        WHERE 
            m.title LIKE :query OR 
            m.actor LIKE :query OR 
            m.actress LIKE :query
    """)
    result = db.session.execute(sql, {"query": f"%{query}%"})
    return result.mappings().all()


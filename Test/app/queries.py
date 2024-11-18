from sqlalchemy.sql import text
from . import db

def get_all_movies():
    sql = text("SELECT * FROM movie")
    result = db.session.execute(sql)
    return result.mappings().all() 



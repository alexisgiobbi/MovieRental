# MovieRental

## File structure explanation:

### app folder

**_init_.py:** initializes flask up, sets up SQLAlchemy

**queries.py:** executes SQL commands in python functions

**routes.py:** defines URL routes, handling HTTP request and also passing in functions from queries.py

**templates/:** renders dyanmic HTML pages

### venv/

virtual envrionement setup to avoid conflicts with other Python projects

**how to activate:** venv\Scripts\activate (windows) source venv/bin/activate (mac)

### app.py

creates Flask application for _init_.py and runs app locally

*Required package installs:* pip install flask / pip install flask-sqlalchemy / pip install pymysql




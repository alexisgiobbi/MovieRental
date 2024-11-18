from flask import Blueprint, render_template
from .queries import get_all_movies

main = Blueprint('main', __name__)

@main.route('/')
def index():
    movies = get_all_movies()
    return render_template('index.html', movies=movies)

@main.route('/customer-signup', methods=['GET', 'POST'])
def customer_register():
    return render_template('customer_signup.html')

@main.route('/employee-login', methods=['GET', 'POST'])
def employee_login():
    return render_template('employee_login.html')

@main.route('/customer-dashboard')
def customer_dashboard():
    return render_template('customer_dash.html')

@main.route('/employee-dashboard')
def employee_dashboard():
    return render_template('employee_dash.html')



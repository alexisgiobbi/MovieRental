from flask import Flask, request, jsonify, redirect, render_template
import pymysql

app = Flask(__name__)

# Database connection
def get_db_connection():
    return pymysql.connect(
        host='localhost',
        user='your_user',
        password='your_password',
        database='your_database',
        cursorclass=pymysql.cursors.DictCursor
    )

# Employee Login Route
@app.route('/employee-login', methods=['POST'])
def employee_login():
    username = request.form['username']
    password = request.form['password']
    
    connection = get_db_connection()
    with connection.cursor() as cursor:
        # Query to validate employee login
        query = """
        SELECT * FROM Employee
        WHERE username = %s AND password = %s
        LIMIT 1;
        """
        cursor.execute(query, (username, password))
        result = cursor.fetchone()
    
    connection.close()

    if result:
        # Successful login
        return jsonify({
            "status": "success",
            "message": f"Welcome, {result['name']}!",
            "data": result
        })
    else:
        # Failed login
        return jsonify({
            "status": "fail",
            "message": "Invalid username or password."
        })

# Home Route (optional)
@app.route('/')
def home():
    return render_template('index.html')  # Render a homepage if needed

if __name__ == '__main__':
    app.run(debug=True)

CREATE DATABASE moviedb;

CREATE TABLE Movie(
	movie_id INTEGER PRIMARY KEY,
	title VARCHAR(255),
	genre VARCHAR(255),
	actor VARCHAR(255),
	actress VARCHAR(255),
	director VARCHAR(255), 
	maturity_rating VARCHAR(10),
	release_year YEAR,
	length_of_movie INTEGER,
	country_of_origin VARCHAR(100),
	imbd_rating DECIMAL(3,1)
);

CREATE TABLE Store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE Inventory (
	inventory_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	movie_id INTEGER,
	available_copies INTEGER NOT NULL,
	store_id INTEGER NOT NULL,
	FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
	FOREIGN KEY(store_id) REFERENCES Store(store_id),
	UNIQUE (movie_id, store_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    store_id INT,
    position VARCHAR(50),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

CREATE TABLE Rental (
    rental_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    store_id INT NOT NULL,
    rental_date DATE,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

CREATE TABLE Customer_Review (
	customer_review_id INTEGER PRIMARY KEY,
	movie_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	rating DECIMAL(2,1) NOT NULL CHECK(rating BETWEEN 1 AND 5),
	written_review VARCHAR(255),
	review_date DATE,
	FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

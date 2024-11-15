CREATE DATABASE moviedb;
USE moviedb;

CREATE TABLE Movie
(
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

INSERT INTO Movie (movie_id, title, genre, actor, actress, director, maturity_rating, release_year, length_of_movie, country_of_origin, imbd_rating) VALUES
(1, 'The Shawshank Redemption', 'Epic, Prison Drama, Drama', 'Tim Robbins, Morgan Freeman, Bob Gunton', NULL, 'Frank Darabont', 'R', 1994, 142, 'United States', 9.3),
(2, 'The Godfather', 'Epic, Gangster, Tragedy, Crime, Drama', 'Marlon Brando, Al Pacino, James Caan', NULL, 'Francis Ford Coppola', 'R', 1972, 175, 'United States', 9.2),
(3, 'The Dark Knight', 'Action Epic, Epic, Superhero, Action, Crime, Drama, Thriller', 'Christian Bale, Heath Ledger, Aaron Eckhart', NULL, 'Christopher Nolan', 'PG-13', 2008, 152, 'United States, United Kingdom', 9.0),
(4, 'The Godfather Part II', 'Epic, Gangster, Tragedy, Crime, Drama', 'Al Pacino, Robert De Niro, Robert Duvall', NULL, 'Francis Ford Coppola', 'R', 1974, 202, 'United States', 9.0),
(5, '12 Angry Men', 'Legal Drama, Psychological Drama, Crime, Drama', 'Henry Fonda, Lee J. Cobb, Martin Balsam', NULL, 'Sidney Lumet', 'TV-PG', 1957, 156, 'United States', 9.0),
(6, 'The Lord of the Rings: The Return of the King', 'Adventure Epic, Epic, Fantasy Epic, Mountain Adventure, Quest, Sword & Sorcery, Tragedy, Action, Adventure, Drama', 'Elijah Wood, Viggo Mortensen, Ian McKellen', NULL, 'Peter Jackson', 'PG-13', 2003, 201, 'New Zealand, United States', 9.0),
(7, "Schindler's List", 'Docudrama, Epic, Historical Epic, Period Drama, Prison Drama, Biography, Drama, History', 'Liam Neeson, Ralph Fiennes, Ben Kingsley', NULL, 'Steven Spielberg', 'R', 1993, 195, 'United States', 9.0),
(8, 'Pulp Fiction', 'Dark Comedy, Drug Crime, Gangster, Crime, Drama', 'John Travolta, Samuel L. Jackson', 'Uma Thurman', 'Quentin Tarantino', 'R', 1994, 154, 'United States', 8.9),
(9, 'The Lord of the Rings: The Fellowship of the Ring', 'Adventure Epic, Epic, Fantasy Epic, Quest, Sword & Sorcery, Action, Adventure, Drama, Fantasy', 'Elijah Wood, Ian McKellen, Orlando Bloom', NULL, 'Peter Jackson', 'PG-13', 2001, 178, 'New Zealand, United States, United Kingdom', 8.9),
(10, 'The Good, the Bad and the Ugly', 'Desert Adventure, Quest, Spaghetti Western, Western Epic, Adventure, Drama, Western', 'Clint Eastwood, Eli Wallach, Lee Van Cleef', NULL, 'Sergio Leone', 'R', 1966, 178, 'Italy, Spain, West Germany', 8.8);

CREATE TABLE Store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    address VARCHAR(255)
);
INSERT INTO Store (store_id, store_name, address) VALUES
(1, 'Downtown Movie Rentals', '123 Main St, Springfield, IL'),
(2, 'Uptown Movie Rentals', '456 Elm St, Springfield, IL'),
(3, 'Suburban Movie Rentals', '789 Oak St, Springfield, IL'),
(4, 'City Center Movie Rentals', '101 Pine St, Springfield, IL'),
(5, 'Westside Movie Rentals', '202 Maple St, Springfield, IL');

CREATE TABLE Inventory
(
inventory_id INTEGER PRIMARY KEY,
movie_id INTEGER,
available_copies INTEGER,
store_id INTEGER,
FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
FOREIGN KEY(store_id) REFERENCES Store(store_id)
);

INSERT INTO Inventory (inventory_id, movie_id, available_copies, store_id) VALUES
(1, 1, 20, 1),
(2, 2, 15, 1),
(3, 3, 30, 2),
(4, 4, 10, 2),
(5, 5, 50, 3),
(6, 6, 25, 3),
(7, 7, 40, 4),
(8, 8, 35, 5),
(9, 9, 10, 5),
(10, 10, 45, 5);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(15)
);

INSERT INTO Customer (customer_id, name, email, phone_number) VALUES
(1, 'John Doe', 'johndoe@example.com', '123-456-7890'),
(2, 'Jane Smith', 'janesmith@example.com', '234-567-8901'),
(3, 'Alice Johnson', 'alice.j@example.com', '345-678-9012'),
(4, 'Bob Brown', 'bobb@example.com', '456-789-0123'),
(5, 'Charlie White', 'charliew@example.com', '567-890-1234'),
(6, 'Diana Green', 'dianag@example.com', '678-901-2345'),
(7, 'Evan Black', 'evanb@example.com', '789-012-3456'),
(8, 'Fiona Blue', 'fionab@example.com', '890-123-4567'),
(9, 'George Red', 'georger@example.com', '901-234-5678'),
(10, 'Hannah Silver', 'hannahs@example.com', '012-345-6789');

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    store_id INT,
    position VARCHAR(50),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);
INSERT INTO Employee (employee_id, first_name, last_name, store_id, position) VALUES
(1, 'Evan', 'Blue', 2, 'Customer Support'),
(2, 'Fiona', 'Red', 4, 'Cashier'),
(3, 'Hannah', 'Silver', 1, 'Customer Support'),
(4, 'Alice', 'White', 1, 'Assistant Manager'),
(5, 'Bob', 'Black', 3, 'Customer Support'),
(6, 'Charlie', 'Green', 5, 'Manager'),
(7, 'Jane', 'Johnson', 2, 'Cashier'),
(8, 'George', 'Gold', 4, 'Assistant Manager'),
(9, 'Diana', 'Smith', 3, 'Manager'),
(10, 'John', 'Brown', 5, 'Cashier');


CREATE TABLE Rental (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rental_date DATE,
    return_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

INSERT INTO Rental (rental_id, customer_id, movie_id, rental_date, return_date) VALUES
(1, 1, 1, '2024-11-01', '2024-11-05'),
(2, 2, 2, '2024-11-02', '2024-11-06'),
(3, 3, 3, '2024-11-03', '2024-11-07'),
(4, 4, 4, '2024-11-04', '2024-11-08'),
(5, 5, 5, '2024-11-05', '2024-11-09'),
(6, 6, 6, '2024-11-06', '2024-11-10'),
(7, 7, 7, '2024-11-07', '2024-11-11'),
(8, 8, 8, '2024-11-08', '2024-11-12'),
(9, 9, 9, '2024-11-09', '2024-11-13'),
(10, 10, 10, '2024-11-10', '2024-11-14');

CREATE TABLE Customer_Review
(
customer_review_id INTEGER PRIMARY KEY,
movie_id INTEGER,
customer_id INTEGER,
rating DECIMAL(3,1),
written_review VARCHAR(255),
review_date DATE,
FOREIGN KEY(movie_id) REFERENCES Movie(movie_id),
FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Customer_Review (customer_review_id, movie_id, customer_id, rating, written_review, review_date) VALUES
(1, 3, 7, 5, 'Absolutely loved this movie! A must-watch.', '2024-11-10'),
(2, 6, 2, 4, 'Great storyline but the pacing was a bit off.', '2024-11-11'),
(3, 1, 9, 3, 'Not my cup of tea. Too predictable.', '2024-11-09'),
(4, 8, 5, 2, 'Disappointing. Expected much more based on the hype.', '2024-11-08'),
(5, 10, 10, 4, 'Solid movie with excellent performances.', '2024-11-12'),
(6, 4, 1, 5, 'A masterpiece! Brilliant direction and screenplay.', '2024-11-13'),
(7, 2, 6, 1, 'Terrible. I regret spending time on this.', '2024-11-14'),
(8, 7, 3, 4, 'Pretty good! Would watch again with friends.', '2024-11-07'),
(9, 5, 8, 3, 'Average. A decent one-time watch.', '2024-11-06'),
(10, 9, 4, 5, 'Amazing visuals and a gripping story. Highly recommend!', '2024-11-05');
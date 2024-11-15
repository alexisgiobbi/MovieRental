CREATE DATABASE movie_db;
USE movie_db;

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

CREATE TABLE Inventory
(
inventory_id INTEGER PRIMARY KEY,
movie_id INTEGER,
available_coupies INTEGER,
FOREIGN KEY(movie_id) REFERENCES Movie(movie_id)
);

INSERT INTO Inventory (inventory_id, movie_id, available_copies) VALUES
(1, 1, 9),
(2, 2, 14),
(3, 3, 15),
(4, 4, 15),
(5, 5, 18),
(6, 6, 11),
(7, 7, 0),
(8, 8, 9),
(9, 9, 10),
(10, 10, 17);

CREATE TABLE Customer_Review
(
customer_review_id INTEGER PRIMARY KEY,
movie_id INTEGER,
customer_id INTEGER,
rating DECIMAL(3,1),
written_review VARCHAR(255),
review_date DATE
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

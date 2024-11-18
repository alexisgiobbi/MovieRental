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
(10, 'The Good, the Bad and the Ugly', 'Desert Adventure, Quest, Spaghetti Western, Western Epic, Adventure, Drama, Western', 'Clint Eastwood, Eli Wallach, Lee Van Cleef', NULL, 'Sergio Leone', 'R', 1966, 178, 'Italy, Spain, West Germany', 8.8),
(11, 'Forrest Gump', 'Drama, Comedy', 'Tom Hanks', NULL, 'Robert Zemeckis', 'PG-13', 1994, 142, 'United States', 8.8),
(12, 'The Lord of the Rings: The Two Towers', 'Adventure, Fantasy', 'Elijah Wood, Viggo Mortensen, Ian McKellen, Orlando Bloom, John Rhys-Davies, Andy Serkis', 'Liv Tyler, Miranda Otto', 'Peter Jackson', 'PG-13', 2002, 179, 'New Zealand, United States', 8.8),
(13, 'Fight Club', 'Drama, Thriller', 'Brad Pitt, Edward Norton', NULL, 'David Fincher', 'R', 1999, 139, 'United States', 8.8),
(14, 'Inception', 'Action, Adventure, Sci-Fi', 'Leonardo DiCaprio, Joseph Gordon-Levitt, Tom Hardy', 'Marion Cotillard, Elliot Page', 'Christopher Nolan', 'PG-13', 2010, 148, 'United States, United Kingdom', 8.8),
(15, 'The Matrix', 'Action, Sci-Fi', 'Keanu Reeves, Laurence Fishburne, Joe Pantoliano', 'Carrie-Anne Moss', 'The Wachowskis', 'R', 1999, 136, 'United States', 8.7);

INSERT INTO Store (store_id, store_name, address) VALUES
	(1, 'Downtown Movie Rentals', '123 Main St, Springfield, IL'),
	(2, 'Uptown Movie Rentals', '456 Elm St, Springfield, IL'),
	(3, 'Suburban Movie Rentals', '789 Oak St, Springfield, IL'),
	(4, 'City Center Movie Rentals', '101 Pine St, Springfield, IL'),
	(5, 'Westside Movie Rentals', '202 Maple St, Springfield, IL');

INSERT INTO Inventory (inventory_id, movie_id, available_copies, store_id) VALUES
	# Store 1
	(1, 1, 20, 1),
	(2, 2, 15, 1),
	(3, 3, 10, 1),
	(4, 4, 25, 1),
	(5, 5, 30, 1),
	# Store 2
	(6, 6, 18, 2),
	(7, 7, 22, 2),
	(8, 8, 12, 2),
	(9, 9, 10, 2),
	(10, 10, 20, 2),
	# Store 3
	(11, 11, 30, 3),
	(12, 12, 15, 3),
	(13, 13, 20, 3),
	(14, 14, 18, 3),
	(15, 15, 10, 3),
	# Store 4
	(16, 1, 25, 4),
	(17, 3, 12, 4),
	(18, 5, 20, 4),
	(19, 7, 15, 4),
	(20, 9, 18, 4),
	# Store 5
	(21, 2, 10, 5),
	(22, 4, 18, 5),
	(23, 6, 25, 5),
	(24, 8, 15, 5),
	(25, 10, 30, 5);
    
INSERT INTO Customer (customer_id, username, password, name, email, phone_number) VALUES
	(1, 'johndoe', 'password1', 'John Doe', 'johndoe@example.com', '123-456-7890'),
	(2, 'janesmith', 'password2', 'Jane Smith', 'janesmith@example.com', '234-567-8901'),
	(3, 'alicej', 'password3', 'Alice Johnson', 'alice.j@example.com', '345-678-9012'),
	(4, 'bobbrown', 'password4', 'Bob Brown', 'bobb@example.com', '456-789-0123'),
	(5, 'charliew', 'password5', 'Charlie White', 'charliew@example.com', '567-890-1234'),
	(6, 'dianag', 'password6', 'Diana Green', 'dianag@example.com', '678-901-2345'),
	(7, 'evanb', 'password7', 'Evan Black', 'evanb@example.com', '789-012-3456'),
	(8, 'fionab', 'password8', 'Fiona Blue', 'fionab@example.com', '890-123-4567'),
	(9, 'georger', 'password9', 'George Red', 'georger@example.com', '901-234-5678'),
	(10, 'hannahs', 'password10', 'Hannah Silver', 'hannahs@example.com', '012-345-6789');
    
INSERT INTO Employee (employee_id, username, password, name, store_id, position) VALUES
	(1, 'evanblue', 'password1', 'Evan Blue', 2, 'Customer Support'),
	(2, 'fionared', 'password2', 'Fiona Red', 4, 'Cashier'),
	(3, 'hannahsilver', 'password3', 'Hannah Silver', 1, 'Customer Support'),
	(4, 'alicewhite', 'password4', 'Alice White', 1, 'Assistant Manager'),
	(5, 'bobblack', 'password5', 'Bob Black', 3, 'Customer Support'),
	(6, 'charliegreen', 'password6', 'Charlie Green', 5, 'Manager'),
	(7, 'janejohnson', 'password7', 'Jane Johnson', 2, 'Cashier'),
	(8, 'georgegold', 'password8', 'George Gold', 4, 'Assistant Manager'),
	(9, 'dianasmith', 'password9', 'Diana Smith', 3, 'Manager'),
	(10, 'johnbrown', 'password10', 'John Brown', 5, 'Cashier');
    
INSERT INTO Rental (rental_id, customer_id, movie_id, store_id, rental_date, return_date) VALUES
	(1, 1, 1, 1, '2024-11-01', '2024-11-03'),  
	(2, 2, 2, 1, '2024-11-02', '2024-11-05'),  
	(3, 3, 3, 2, '2024-11-03', '2024-11-07'),  
	(4, 4, 4, 2, '2024-11-04', '2024-11-06'),  
	(5, 5, 5, 3, '2024-11-05', '2024-11-09'),  
	(6, 6, 6, 3, '2024-11-06', '2024-11-08'),  
	(7, 7, 7, 4, '2024-11-07', NULL),          
	(8, 8, 8, 4, '2024-11-08', '2024-11-12'),  
	(9, 9, 9, 5, '2024-11-09', NULL),          
	(10, 10, 10, 5, '2024-11-10', '2024-11-13'); 

INSERT INTO Customer_Review (customer_review_id, movie_id, customer_id, rating, written_review, review_date) VALUES
    (1, 1, 1, 5, 'Absolutely loved this movie! A must-watch.', '2024-11-03'), 
    (2, 2, 2, 4, 'Great storyline but the pacing was a bit off.', '2024-11-05'), 
    (3, 3, 3, 3, 'Not my cup of tea. Too predictable.', '2024-11-07'), 
    (4, 4, 4, 2, 'Disappointing. Expected much more based on the hype.', '2024-11-06'), 
    (5, 5, 5, 4, 'Solid movie with excellent performances.', '2024-11-09'), 
    (6, 6, 6, 5, 'A masterpiece! Brilliant direction and screenplay.', '2024-11-08'), 
    (7, 8, 8, 4, 'Pretty good! Would watch again with friends.', '2024-11-12'), 
    (8, 10, 10, 5, 'Average. A decent one-time watch.', '2024-11-13'); 


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
(1, 1, 101, '2024-11-01', '2024-11-05'),
(2, 2, 102, '2024-11-02', '2024-11-06'),
(3, 3, 103, '2024-11-03', '2024-11-07'),
(4, 4, 104, '2024-11-04', '2024-11-08'),
(5, 5, 105, '2024-11-05', '2024-11-09'),
(6, 6, 106, '2024-11-06', '2024-11-10'),
(7, 7, 107, '2024-11-07', '2024-11-11'),
(8, 8, 108, '2024-11-08', '2024-11-12'),
(9, 9, 109, '2024-11-09', '2024-11-13'),
(10, 10, 110, '2024-11-10', '2024-11-14');
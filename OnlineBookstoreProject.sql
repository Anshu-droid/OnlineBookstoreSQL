
-- Online Bookstore Management System SQL Script

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(6,2),
    stock_quantity INT
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address TEXT,
    registration_date DATE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(8,2),
    payment_date DATE,
    method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Books VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 10.99, 50),
(2, '1984', 'George Orwell', 'Dystopian', 8.99, 100),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 7.99, 80),
(4, 'The Alchemist', 'Paulo Coelho', 'Fiction', 9.49, 60),
(5, 'Sapiens', 'Yuval Noah Harari', 'History', 12.99, 40);

INSERT INTO Customers VALUES
(1, 'Alice Johnson', 'alice@example.com', '123 Main St', '2023-01-15'),
(2, 'Bob Smith', 'bob@example.com', '456 Oak Ave', '2023-02-20'),
(3, 'Charlie Lee', 'charlie@example.com', '789 Pine Rd', '2023-03-05');

INSERT INTO Orders VALUES
(1, 1, '2023-04-01', 'Delivered'),
(2, 2, '2023-04-05', 'Delivered'),
(3, 3, '2023-04-10', 'Cancelled');

INSERT INTO OrderItems VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 1),
(4, 2, 4, 2),
(5, 3, 5, 1);

INSERT INTO Payments VALUES
(1, 1, 30.97, '2023-04-02', 'Credit Card'),
(2, 2, 25.47, '2023-04-06', 'PayPal');

INSERT INTO Reviews VALUES
(1, 1, 1, 5, 'Amazing book!', '2023-04-03'),
(2, 2, 1, 4, 'Very thought-provoking.', '2023-04-04'),
(3, 3, 2, 5, 'A must-read classic.', '2023-04-07'),
(4, 4, 2, 3, 'Good but not great.', '2023-04-08'),
(5, 5, 3, 2, 'Too dense for me.', '2023-04-11');

SELECT SUM(amount) AS total_revenue FROM Payments;

SELECT b.title, SUM(oi.quantity) AS total_sold
FROM OrderItems oi
JOIN Books b ON oi.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
FETCH FIRST 1 ROWS ONLY;

SELECT b.title, AVG(r.rating) AS avg_rating
FROM Reviews r
JOIN Books b ON r.book_id = b.book_id
GROUP BY b.title;

CREATE VIEW OrderDetails AS
SELECT o.order_id, c.name AS customer, b.title AS book, oi.quantity, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Books b ON oi.book_id = b.book_id;

SELECT * FROM OrderDetails;
SELECT b.title, SUM(oi.quantity) AS total_sold
FROM OrderItems oi
JOIN Books b ON oi.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
FETCH FIRST 1 ROWS ONLY;




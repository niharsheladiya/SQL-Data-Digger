-- Welcome to Data Digger Project of SQL
SHOW DATABASES;

CREATE DATABASE DataDigger;

SHOW DATABASES;

USE DataDigger;

-- TABLE CREATION

CREATE TABLE Customers (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
     Name VARCHAR(100) NOT NULL,
     Email VARCHAR(150) NOT NULL UNIQUE,
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID)   REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- 1. Customers Table

INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES
(1, 'Alice',   'alice@example.com',   '12 Ring Road, Surat'),
(2, 'Bob',     'bob@example.com',     '45 MG Road, Mumbai'),
(3, 'Charlie', 'charlie@example.com', '78 Park Street, Kolkata'),
(4, 'David',   'david@example.com',   '23 Anna Salai, Chennai'),
(5, 'Eva',     'eva@example.com',     '9 Civil Lines, Delhi'),
(6, 'Frank',   'frank@example.com',   '56 FC Road, Pune');


SHOW TABLES;

SELECT * FROM Customers;

UPDATE Customers
SET Address = '101 Athwa Lines, Surat'
WHERE CustomerID = 1;

DELETE FROM Customers
WHERE CustomerID = 6;

SELECT * FROM Customers
WHERE Name = 'Alice';

-- 2. Orders Table

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 5  DAY), 2845.00),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 12 DAY), 2499.00),
(3, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 2498.00),
(4, 3, DATE_SUB(CURDATE(), INTERVAL 28 DAY), 2598.00),
(5, 4, DATE_SUB(CURDATE(), INTERVAL 45 DAY), 1700.00),
(6, 5, DATE_SUB(CURDATE(), INTERVAL 60 DAY), 1200.00);

SELECT * FROM Orders
WHERE CustomerID = 1;


UPDATE Orders
SET TotalAmount = 1745.00
WHERE OrderID = 5;


DELETE FROM Orders
WHERE OrderID = 6;


SELECT * FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);


SELECT
    MAX(TotalAmount) AS HighestOrderAmount,
    MIN(TotalAmount) AS LowestOrderAmount,
    AVG(TotalAmount) AS AverageOrderAmount
FROM Orders;


-- 3. Products Table

INSERT INTO Products (ProductID, ProductName, Price, Stock) VALUES
(1, 'Wireless Mouse',       799.00,  50),
(2, 'Mechanical Keyboard', 2499.00,  30),
(3, 'USB-C Cable',          349.00, 100),
(4, 'Bluetooth Headphones',1599.00,  25),
(5, 'Laptop Stand',        1299.00,  40),
(6, 'Phone Case',           299.00,   0);


SELECT * FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 899.00
WHERE ProductID = 1;

SET SQL_SAFE_UPDATES = 0;   


DELETE FROM Products
WHERE Stock = 0;


SET SQL_SAFE_UPDATES = 1;

SELECT * FROM Products
WHERE Price BETWEEN 500 AND 2000;


SELECT
    MAX(Price) AS MostExpensivePrice,
    MIN(Price) AS CheapestPrice
FROM Products;

SELECT ProductID, ProductName, Price
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products)
   OR Price = (SELECT MIN(Price) FROM Products);

-- 4. Orderdetails Table

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 1, 2, 1798.00),
(2, 1, 3, 3, 1047.00),
(3, 2, 2, 1, 2499.00),
(4, 3, 4, 1, 1599.00),
(5, 3, 1, 1,  899.00),
(6, 4, 5, 2, 2598.00),
(7, 5, 3, 5, 1745.00);

SELECT * FROM OrderDetails
WHERE OrderID = 1;

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;


SELECT
    od.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID, p.ProductName
ORDER BY TotalQuantityOrdered DESC
LIMIT 3;

SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 3;

DROP TABLE `Customers`;
DROP TABLE `Products`;

DROP TABLE Orders;

DROP TABLE OrderDetails;




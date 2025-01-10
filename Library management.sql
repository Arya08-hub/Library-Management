CREATE DATABASE library;
USE library;
 CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
 CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
 CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3), -- "Yes" for available, "No" for not available
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
 CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
 CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
 CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'Yes';
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;
SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;
SELECT e.Emp_name, b.Branch_address
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id;
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;
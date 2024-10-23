--Creating a database
CREATE DATABASE self_practice;

--Making use of the database
USE self_practice

--Creating a table called 'Employee'
CREATE TABLE Employees(
		EmployeeID INT PRIMARY KEY,
		FirstName VARCHAR(100),
		LastName VARCHAR(100),
		Department VARCHAR(100),
		Salary DECIMAL(10, 2),
)
SELECT * FROM Employees -- to view the table itself

sp_help[Employees] --to view the internals/backend of the your table created

--Inserting data into the table 
INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, Salary)
VALUES (1, 'John', 'Doe', 'HR', 50000.00),
	   (2, 'Jane', 'Smith', 'Finance', 40000.00),
	   (3, 'Bisi', 'Tosin', 'Marketing', 30000.00);

-- selecting a portion of the Employees table
SELECT FirstName FROM Employees

SELECT FirstName, LastName  FROM Employees

--Using the WHERE clause
SELECT * FROM Employees
WHERE Department = 'Finance'

--Using the WHERE clause with a condition
SELECT * FROM Employees
	WHERE Salary > 30000


--Using UPDATE statement 
UPDATE Employees
SET salary = 58000.00
WHERE EmployeeID = 1

--Alter a column name(updating a column name )
EXEC sp_rename 'Employees.Department', 'Departments', 'COLUMN';


--Delete Function
DELETE FROM Employees
WHERE EmployeeID = 3;


SELECT * FROM [dbo].[house_pricing_dataset]

--Aggregation Functions

--calculate the average
SELECT concat('$', round(AVG(price), 2)) AS AveragePrice --the round there is to round up the decimal averageprice & the (2) is the amt i want round up to.
	FROM [dbo].[house_pricing_dataset]
	WHERE yr_renovated = 2005;

--calculate the Max price
SELECT MAX(price) AS Maximum_price
		FROM [dbo].[house_pricing_dataset]

--calculate the Min price
SELECT MIN(price) AS Minimum_price
		FROM [dbo].[house_pricing_dataset]
		WHERE price >0

--calculate the sum of price
SELECT SUM(price) AS Sum_price
		FROM [dbo].[house_pricing_dataset]

--calculate the average of price
SELECT AVG(price) AS Average_price
		FROM [dbo].[house_pricing_dataset]

--calculate the distinct of cities
SELECT DISTINCT(city) AS Unique_cities
		FROM [dbo].[house_pricing_dataset]

--calculate the count of price
SELECT COUNT(price) AS Price_count
		FROM [dbo].[house_pricing_dataset]

--calculate the count of distinct of city
SELECT COUNT(DISTINCT(city)) AS Unique_cities
		FROM [dbo].[house_pricing_dataset]

--subqueries:
--subquery inside the WHERE clause
SELECT price, yr_renovated, city
	FROM [dbo].[house_pricing_dataset]
		WHERE price > (SELECT AVG(price)
						FROM [dbo].[house_pricing_dataset])
 
--JOINS
SELECT * FROM Employees
INSERT INTO Employees(EmployeeID, FirstName, LastName, Departments, Salary)
VALUES (3, 'Bisi', 'Tosin', 'Marketing', 30000.00);

INSERT INTO Employees(EmployeeID, FirstName, LastName, Departments, Salary)
VALUES (4, 'Dorcas', 'Francis', 'IT', 70000.00);

--Creating a Department table 
CREATE TABLE Departments(
		DepartmentID INT PRIMARY KEY,
		DepartmentName VARCHAR(50)
);
SELECT * FROM Departments
SELECT * FROM Employees

--Inserting data into the Departments table 
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'HR'),
	   (2, 'Finance'),
	   (3, 'Marketing');

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (4, 'Media');

SELECT * FROM Employees
SELECT * FROM Departments


--INNER JOIN 
SELECT Employees.Departments, Departments.DepartmentID FROM Employees
INNER JOIN Departments
ON Employees.Departments = Departments.DepartmentName

--NOTE; THE FIRST TABLE YOU CALL WHEN PERFORMING JOIN IS THE LEFT, WHILE THE ONE AFTER THAT IS THE RIGHT 

-- LEFT JOIN 
SELECT * FROM Employees
LEFT JOIN Departments
ON Employees.Departments = Departments.DepartmentName

-- RIGHT JOIN 
SELECT * FROM Employees
RIGHT JOIN Departments
ON Employees.Departments = Departments.DepartmentName

--FULL OUTER JOIN
SELECT * FROM Employees
FULL OUTER JOIN Departments
ON Employees.Departments = Departments.DepartmentName

-- MULTIPLYING TWO COLUMNS FROM TWO DIFFERENT TABLE 
SELECT Employees.Salary * Departments.DepartmentID AS Net_Salary FROM Employees
LEFT JOIN Departments
ON Employees.Departments = Departments.DepartmentName

-- CONSTRAINTS
--- PRIMARY KEY
CREATE TABLE Employees_1(
		EmployeeID INT PRIMARY KEY,
		FirstName VARCHAR(50),
		LastName VARCHAR(50)
);

INSERT INTO Employees_1(EmployeeID, FirstName, LastName)
VALUES (1, 'John', 'Doe'),
	   (2, NULL, 'Smith'),
	   (3, 'Bisi', 'Tosin');

SELECT * FROM Employees_1

-- FORIEGN KEY 
CREATE TABLE Customers(
		CustomerID INT PRIMARY KEY ,
		CustomerName VARCHAR(100),
);

CREATE TABLE Orders(
		OrderID INT PRIMARY KEY ,
		CustomerID INT,
		OrderDate DATE,
		FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers(CustomerID, CustomerName)
VALUES(101, 'Joe'),
	  (102, 'Smith'),
	  (103, 'Dorcas');


INSERT INTO Orders(OrderID, CustomerID, OrderDate)
VALUES(1, 101, '10-21-2024'),
	  (2, 102, '10-22-2024'),
	  (3, 103, '10-23-2024');

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Products

-- UNIQUE CONSTRAINT
CREATE TABLE Products(
		ProductID INT UNIQUE,
		ProductName VARCHAR(100),
);

-- CHECK CONSTRAINT
CREATE TABLE Student1(
		StudentID INT PRIMARY KEY,
		Age INT
		CHECK (Age >= 18)
);

INSERT INTO Student1(StudentID, Age)
VALUES (01, 19); --(cause the check constraint on the age is that it must be greater than or equal to 18)

INSERT INTO Products(ProductID, ProductName)
VALUES (011, 'Sneakers'),
	   (012, 'Shirts');

-- DEFAULT CONSTRAINTS
CREATE TABLE Orders_1(
		OrderID INT PRIMARY KEY,
		OrderDate DATE DEFAULT GETDATE()
);

INSERT INTO Orders_1(OrderID)
VALUES (10001),
	   (20002),
	   (30003);

SELECT * FROM Orders_1
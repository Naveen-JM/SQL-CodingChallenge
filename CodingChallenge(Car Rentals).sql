CREATE DATABASE CarRentalSystem;
USE CarRentalSystem;

-- Create Vehicle Table
CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DECIMAL(10, 2),
    available Int,
    passengerCapacity INT,
    engineCapacity INT
);
-- Create Customer Table
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255),
    phoneNumber VARCHAR(20)
);

-- Create Lease Table
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20) CHECK (type IN ('DailyLease', 'MonthlyLease')),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- Create Payment Table
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);

INSERT INTO Customer (CustomerID,firstName,lastName , Email, phoneNumber)
VALUES
(1,'John', 'Doe','johndoe@example.com','555-555-5555'),
(2,'Jane', 'Smith','janesmith@example.com', '555-123-4567'),
(3,'Robert', 'Johnson', 'robert@example.com' ,'555-789-1234'),
(4,'Sarah', 'Brown', 'sarah@example.com','555-456-7890'),
(5,'David' ,'Lee','david@example.com','555-987-6543'),
(6,'Laura', 'Hall','laura@example.com','555-234-5678'),
(7,'Michael', 'Davis','ichael@example.com','555-876-5432'),
(8,'Emma','Wilson','emma@example.com','555-432-1098'),
(9,'William','Taylor','william@example.com','555-321-6547'),
(10,'Olivia', 'Adams','livia@example.com','555-765-4321')

Insert Into Vehicle(vehicleID ,make,model,Year ,dailyRate,available, passengerCapacity ,engineCapacity)
Values
(1,'Toyota', 'Camry', '2022', '50.00 ','1' ,'4' ,'1450'),
(2, 'Honda' ,'Civic', '2023', '45.00', '1','7' ,'1500'),
(3, 'Ford', 'Focus', '2022' ,'48.00', '0', '4','1400'),
(4, 'Nissan', 'Altima', '2023', '52.00' ,'1', '7', '1200'),
(5, 'Chevrolet' ,'Malibu' ,'2022', '47.00' ,'1', '4' ,'1800'),
(6, 'Hyundai', 'Sonata' ,'2023',' 49.00',' 0',' 7' ,'1400'),
(7,'BMW' ,'3 Series' ,'2023' ,'60.00',' 1','7' ,'2499'),
(8, 'Mercedes', 'C-Class', '2022', '58.00 ','1',' 8' ,'2599'),
(9, 'Audi' ,'A4', '2022' ,'55.00', '0','4', '2500'),
(10 ,'Lexus','ES' ,'2023' ,'54.00' ,'1' ,'4' ,'2500')

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES
    (1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'DailyLease'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease')

	INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES
    (1, 1, '2023-01-03', 200.00),
    (2, 2, '2023-02-20', 1000.00),
    (3, 3, '2023-03-12', 75.00),
    (4, 4, '2023-04-25', 900.00),
    (5, 5, '2023-05-07', 60.00),
    (6, 6, '2023-06-18', 1200.00),
    (7, 7, '2023-07-03', 40.00),
    (8, 8, '2023-08-14', 1100.00),
    (9, 9, '2023-09-09', 80.00),
    (10, 10, '2023-10-25', 1500.00);

--Q1)
UPDATE Vehicle
SET dailyRate = 68
WHERE make = 'Mercedes';

--Q2)
DELETE FROM Customer
WHERE customerID = 3;

--Q3)
exec sp_rename 'payment.paymentdate','transactiondate';

--Q4)
SELECT *
FROM Customer
WHERE email = 'johndoe@example.com';

--Q5)
SELECT *FROM Lease
WHERE customerID = (SELECT customerID FROM Customer WHERE firstName = 'Olivia' AND lastName = 'Adams')
    AND endDate >= CURRENT_DATE;

  
  --Q6)
  SELECT *FROM Payment
   WHERE leaseID IN 
   (SELECT leaseID FROM Lease WHERE customerID = (SELECT customerID FROM Customer WHERE phoneNumber = '555-765-4321'));

   --Q7)
   SELECT AVG(dailyRate) AS averageDailyRate
   FROM Vehicle
   WHERE available = '1'

   --Q8)
SELECT *
FROM Vehicle
ORDER BY dailyRate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY

 --Q9)
SELECT Vehicle.*
FROM Vehicle
JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Customer.email = 'johndoe@example.com';

--Q10)
SELECT Lease.*, Vehicle.make, Vehicle.model, Customer.firstName, Customer.lastName
FROM Lease
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
JOIN Customer ON Lease.customerID = Customer.customerID
ORDER BY Lease.startDate DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

--Q11)
SELECT *
FROM Payment
WHERE YEAR(paymentDate) = 2023;

--Q12)
SELECT Customer.*
FROM Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
WHERE Payment.paymentID IS NULL;

--Q14)
SELECT
    Customer.*,
    COALESCE(
        (SELECT SUM(Payment.amount)
         FROM Lease
         LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
         WHERE Lease.customerID = Customer.customerID),
        0
    ) AS totalPayments
FROM
    Customer;
--Q15)
SELECT
    Lease.leaseID,
    Lease.startDate,
    Lease.endDate,
    Vehicle.vehicleID,
    Vehicle.make,
    Vehicle.model
FROM
    Lease
JOIN
    Vehicle ON Lease.vehicleID = Vehicle.vehicleID

--Q17)
SELECT
    Customer.customerID,
    Customer.firstName,
    Customer.lastName,
    SUM(Payment.amount) AS totalPayments
FROM
    Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY
    Customer.customerID, Customer.firstName, Customer.lastName
ORDER BY
    totalPayments DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

--18)
SELECT Vehicle.*, Lease.startDate, Lease.endDate, Customer.firstName, Customer.lastName
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Customer ON Lease.customerID = Customer.customerID



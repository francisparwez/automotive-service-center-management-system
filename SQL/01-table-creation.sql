-- 01 — Create the database
CREATE DATABASE AutomotiveServiceCenter;
GO
USE AutomotiveServiceCenter;
GO

-- 2 — Customers Table
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(50),
    RegistrationDate DATE NOT NULL
        DEFAULT CAST(GETDATE() AS DATE)
);
GO

-- 3 — Vehicles Table
CREATE TABLE Vehicles
(
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    Make NVARCHAR(50) NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    VehicleYear INT NOT NULL,
    RegistrationNumber NVARCHAR(20) NOT NULL UNIQUE,
    VIN NVARCHAR(50) UNIQUE,
    Mileage INT NOT NULL,
    FuelType NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Vehicles_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),
    CONSTRAINT CK_Vehicles_Year
        CHECK (VehicleYear BETWEEN 1980 AND 2030),
    CONSTRAINT CK_Vehicles_Mileage
        CHECK (Mileage >= 0),
    CONSTRAINT CK_Vehicles_FuelType
        CHECK (FuelType IN
        (
            'Petrol',
            'Diesel',
            'Hybrid',
            'Electric'
        ))
);
GO

-- 4 — Employees Table
CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Role NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20),
    HireDate DATE NOT NULL,
    Salary DECIMAL(12,2),
    CONSTRAINT CK_Employees_Role
        CHECK (Role IN
        (
            'Mechanic',
            'Service Advisor',
            'Manager',
            'Technician',
            'Receptionist'
        )),
    CONSTRAINT CK_Employees_Salary
        CHECK (Salary >= 0)
);
GO

-- 5 — Services Table
CREATE TABLE Services
(
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    StandardPrice DECIMAL(10,2) NOT NULL,
    EstimatedDurationMinutes INT NOT NULL,
    CONSTRAINT CK_Services_Price
        CHECK (StandardPrice >= 0),
    CONSTRAINT CK_Services_Duration
        CHECK (EstimatedDurationMinutes > 0)
);
GO

-- 6 — Suppliers Table
CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    City NVARCHAR(50)
);
GO

-- 7 — Parts Table
CREATE TABLE Parts
(
    PartID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL,
    PartName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    UnitCost DECIMAL(10,2) NOT NULL,
    SellingPrice DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    ReorderLevel INT NOT NULL,
    CONSTRAINT FK_Parts_Suppliers
        FOREIGN KEY (SupplierID)
        REFERENCES Suppliers(SupplierID),
    CONSTRAINT CK_Parts_UnitCost
        CHECK (UnitCost >= 0),
    CONSTRAINT CK_Parts_SellingPrice
        CHECK (SellingPrice >= 0),
    CONSTRAINT CK_Parts_Stock
        CHECK (StockQuantity >= 0),
    CONSTRAINT CK_Parts_ReorderLevel
        CHECK (ReorderLevel >= 0),
    CONSTRAINT CK_Parts_Price
        CHECK (SellingPrice >= UnitCost)
);
GO

-- 8 — Appointments Table
CREATE TABLE Appointments
(
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status NVARCHAR(30) NOT NULL,
    ProblemDescription NVARCHAR(500),
    CreatedDate DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),
    CONSTRAINT FK_Appointments_Vehicles
        FOREIGN KEY (VehicleID)
        REFERENCES Vehicles(VehicleID),
    CONSTRAINT CK_Appointments_Status
        CHECK (Status IN
        (
            'Scheduled',
            'Confirmed',
            'Completed',
            'Cancelled',
            'No Show'
        ))
);
GO

-- 9 — WorkOrders Table
CREATE TABLE WorkOrders
(
    WorkOrderID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT NOT NULL,
    MechanicID INT NOT NULL,
    StartDateTime DATETIME2,
    CompletionDateTime DATETIME2,
    Status NVARCHAR(30) NOT NULL,
    LaborCost DECIMAL(10,2) NOT NULL DEFAULT 0,
    Notes NVARCHAR(1000),
    CONSTRAINT FK_WorkOrders_Appointments
        FOREIGN KEY (AppointmentID)
        REFERENCES Appointments(AppointmentID),
    CONSTRAINT FK_WorkOrders_Mechanics
        FOREIGN KEY (MechanicID)
        REFERENCES Employees(EmployeeID),
    CONSTRAINT CK_WorkOrders_Status
        CHECK (Status IN
        (
            'Open',
            'In Progress',
            'Completed',
            'Cancelled'
        )),
    CONSTRAINT CK_WorkOrders_LaborCost
        CHECK (LaborCost >= 0),
    CONSTRAINT CK_WorkOrders_Dates
        CHECK
        (
            CompletionDateTime IS NULL
            OR StartDateTime IS NULL
            OR CompletionDateTime >= StartDateTime
        )
);
GO

-- 10 — WorkOrderServices Table
CREATE TABLE WorkOrderServices
(
    WorkOrderServiceID INT IDENTITY(1,1) PRIMARY KEY,
    WorkOrderID INT NOT NULL,
    ServiceID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    ServicePrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_WorkOrderServices_WorkOrders
        FOREIGN KEY (WorkOrderID)
        REFERENCES WorkOrders(WorkOrderID),
    CONSTRAINT FK_WorkOrderServices_Services
        FOREIGN KEY (ServiceID)
        REFERENCES Services(ServiceID),
    CONSTRAINT CK_WorkOrderServices_Quantity
        CHECK (Quantity > 0),
    CONSTRAINT CK_WorkOrderServices_Price
        CHECK (ServicePrice >= 0)
);
GO

-- 11 — PartsUsed Table
CREATE TABLE PartsUsed
(
    PartUsedID INT IDENTITY(1,1) PRIMARY KEY,
    WorkOrderID INT NOT NULL,
    PartID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_PartsUsed_WorkOrders
        FOREIGN KEY (WorkOrderID)
        REFERENCES WorkOrders(WorkOrderID),
    CONSTRAINT FK_PartsUsed_Parts
        FOREIGN KEY (PartID)
        REFERENCES Parts(PartID),
    CONSTRAINT CK_PartsUsed_Quantity
        CHECK (Quantity > 0),
    CONSTRAINT CK_PartsUsed_Price
        CHECK (UnitPrice >= 0)
);
GO

-- 12 — Payments Table
CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    WorkOrderID INT NOT NULL,
    PaymentDate DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(30) NOT NULL,
    PaymentStatus NVARCHAR(30) NOT NULL,
    TransactionReference NVARCHAR(100),
    CONSTRAINT FK_Payments_WorkOrders
        FOREIGN KEY (WorkOrderID)
        REFERENCES WorkOrders(WorkOrderID),
    CONSTRAINT CK_Payments_Amount
        CHECK (Amount > 0),
    CONSTRAINT CK_Payments_Method
        CHECK (PaymentMethod IN
        (
            'Cash',
            'Credit Card',
            'Debit Card',
            'Bank Transfer',
            'JazzCash',
            'EasyPaisa'
        )),
    CONSTRAINT CK_Payments_Status
        CHECK (PaymentStatus IN
        (
            'Pending',
            'Completed',
            'Failed',
            'Refunded'
        ))
);
GO
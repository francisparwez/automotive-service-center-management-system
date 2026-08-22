/*
=========================================================
02 - DATA QUALITY & VALIDATION
Automotive Service Center Management System
=========================================================
*/

USE AutomotiveServiceCenter;
GO


/*
=========================================================
1. REFERENTIAL INTEGRITY CHECKS
=========================================================
*/


-- 1. Vehicles → Customers
SELECT
    v.VehicleID,
    v.CustomerID
FROM Vehicles v
LEFT JOIN Customers c
    ON v.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;


-- 2. Appointments → Vehicles
SELECT
    a.AppointmentID,
    a.VehicleID
FROM Appointments a
LEFT JOIN Vehicles v
    ON a.VehicleID = v.VehicleID
WHERE v.VehicleID IS NULL;


-- 3. WorkOrders → Appointments
SELECT
    wo.WorkOrderID,
    wo.AppointmentID
FROM WorkOrders wo
LEFT JOIN Appointments a
    ON wo.AppointmentID = a.AppointmentID
WHERE a.AppointmentID IS NULL;


-- 4. WorkOrders → Employees
SELECT
    wo.WorkOrderID,
    wo.MechanicID
FROM WorkOrders wo
LEFT JOIN Employees e
    ON wo.MechanicID = e.EmployeeID
WHERE e.EmployeeID IS NULL;


-- 5. WorkOrderServices → WorkOrders
SELECT
    wos.WorkOrderServiceID,
    wos.WorkOrderID
FROM WorkOrderServices wos
LEFT JOIN WorkOrders wo
    ON wos.WorkOrderID = wo.WorkOrderID
WHERE wo.WorkOrderID IS NULL;


-- 6. WorkOrderServices → Services
SELECT
    wos.WorkOrderServiceID,
    wos.ServiceID
FROM WorkOrderServices wos
LEFT JOIN Services s
    ON wos.ServiceID = s.ServiceID
WHERE s.ServiceID IS NULL;


-- 7. PartsUsed → WorkOrders
SELECT
    pu.PartUsedID,
    pu.WorkOrderID
FROM PartsUsed pu
LEFT JOIN WorkOrders wo
    ON pu.WorkOrderID = wo.WorkOrderID
WHERE wo.WorkOrderID IS NULL;


-- 8. PartsUsed → Parts
SELECT
    pu.PartUsedID,
    pu.PartID
FROM PartsUsed pu
LEFT JOIN Parts p
    ON pu.PartID = p.PartID
WHERE p.PartID IS NULL;


-- 9. Payments → WorkOrders
SELECT
    p.PaymentID,
    p.WorkOrderID
FROM Payments p
LEFT JOIN WorkOrders wo
    ON p.WorkOrderID = wo.WorkOrderID
WHERE wo.WorkOrderID IS NULL;
# 🚗 Automotive Service Center Management System

A **SQL-based data analysis project** simulating the operations of a real-world automotive service center.

The project focuses on building a relational database from scratch, inserting realistic business data, performing data-quality checks, and using SQL to answer practical business questions.

The objective is to demonstrate the SQL and analytical skills expected from a **Junior Data Analyst**, including data extraction, cleaning, aggregation, joins, KPI analysis, trend analysis, customer analysis, operational analysis, and business insight generation.

---

# 📌 Project Overview

The Automotive Service Center Management System represents a fictional automotive repair and maintenance business.

The database manages:

- Customers
- Vehicles
- Employees and mechanics
- Services
- Suppliers
- Parts
- Service appointments
- Work orders
- Services performed
- Parts used
- Payments

The project follows a realistic data-analysis workflow:

```text
Database Design
       ↓
Data Generation
       ↓
Data Quality Checks
       ↓
SQL Data Exploration
       ↓
Business Analysis
       ↓
KPI Analysis
       ↓
Trend Analysis
       ↓
Customer Analysis
       ↓
Service & Operations Analysis
       ↓
Inventory Analysis
       ↓
Financial Analysis
       ↓
Business Insights
```

---

# 🎯 Project Objectives

The main objectives of this project are to:

1. Design and build a relational SQL database.
2. Create realistic business data.
3. Establish relationships between business entities.
4. Apply primary keys, foreign keys, and data validation constraints.
5. Perform data-quality and consistency checks.
6. Explore the dataset using SQL.
7. Calculate important business KPIs.
8. Analyze customers, vehicles, services, employees, inventory, and revenue.
9. Identify trends and patterns.
10. Use SQL to investigate business problems.
11. Produce actionable business insights.
12. Demonstrate practical SQL skills relevant to a Junior Data Analyst role.

---

# 🗄️ Database Structure

The project contains **11 relational tables**:

```text
Customers
    │
    └── Vehicles
            │
            └── Appointments
                    │
                    └── WorkOrders
                           │
             ┌─────────────┴─────────────┐
             │                           │
             ▼                           ▼
     WorkOrderServices               PartsUsed
             │                           │
             ▼                           ▼
         Services                     Parts
                                         │
                                         ▼
                                     Suppliers

Employees ────────────────→ WorkOrders

WorkOrders ────────────────→ Payments
```

---

# 🔗 Entity Relationship Diagram (ERD)

```text
Customers
    │
    │ 1:M
    ▼
Vehicles
    │
    │ 1:M
    ▼
Appointments
    │
    │ 1:0..1
    ▼
WorkOrders
    │
    ├───────────────┐
    │               │
    ▼               ▼
WorkOrderServices  PartsUsed
    │               │
    ▼               ▼
Services          Parts
                    │
                    ▼
                 Suppliers


Employees
    │
    │ 1:M
    ▼
WorkOrders


WorkOrders
    │
    │ 1:M
    ▼
Payments
```

## Relationship Explanation

| Relationship | Type | Meaning |
|---|---|---|
| Customer → Vehicle | 1:M | One customer can own multiple vehicles |
| Vehicle → Appointment | 1:M | A vehicle can have many appointments |
| Appointment → WorkOrder | 1:0..1 | An appointment may become a work order |
| Employee → WorkOrder | 1:M | A mechanic can handle many work orders |
| WorkOrder → Service | M:M | A work order can contain multiple services |
| WorkOrder → Part | M:M | A work order can use multiple parts |
| Supplier → Part | 1:M | One supplier can supply many parts |
| WorkOrder → Payment | 1:M | A work order can have one or multiple payments |

## Tables

1. Customers
2. Vehicles
3. Employees
4. Services
5. Suppliers
6. Parts
7. Appointments
8. WorkOrders
9. WorkOrderServices
10. PartsUsed
11. Payments

## Primary Keys

| Table | Primary Key |
|---|---|
| Customers | `CustomerID` |
| Vehicles | `VehicleID` |
| Employees | `EmployeeID` |
| Services | `ServiceID` |
| Suppliers | `SupplierID` |
| Parts | `PartID` |
| Appointments | `AppointmentID` |
| WorkOrders | `WorkOrderID` |
| WorkOrderServices | `WorkOrderServiceID` |
| PartsUsed | `PartUsedID` |
| Payments | `PaymentID` |

---

# 📊 Database Tables

## 1. Customers

Contains information about customers registered with the service center.

**Key fields:**

- `CustomerID`
- `FirstName`
- `LastName`
- `Phone`
- `Email`
- `Address`
- `City`
- `RegistrationDate`

---

## 2. Vehicles

Contains vehicles owned by customers.

**Key fields:**

- `VehicleID`
- `CustomerID`
- `Make`
- `Model`
- `VehicleYear`
- `RegistrationNumber`
- `VIN`
- `Mileage`
- `FuelType`

Relationship:

```text
Customers 1 ─────── M Vehicles
```

A customer can own multiple vehicles.

---

## 3. Employees

Contains employees working at the service center.

**Key fields:**

- `EmployeeID`
- `FirstName`
- `LastName`
- `Role`
- `Phone`
- `HireDate`
- `Salary`

Possible roles include:

- Mechanic
- Technician
- Service Advisor
- Manager
- Receptionist

---

## 4. Services

Contains the services offered by the service center.

**Key fields:**

- `ServiceID`
- `ServiceName`
- `Category`
- `StandardPrice`
- `EstimatedDurationMinutes`

Examples include:

- Oil Change
- Brake Inspection
- Brake Pad Replacement
- Engine Diagnostic
- AC Service
- Wheel Alignment
- Battery Replacement
- Full Service

---

## 5. Suppliers

Contains information about suppliers providing automotive parts.

**Key fields:**

- `SupplierID`
- `SupplierName`
- `ContactPerson`
- `Phone`
- `Email`
- `City`

---

## 6. Parts

Contains automotive parts and inventory information.

**Key fields:**

- `PartID`
- `SupplierID`
- `PartName`
- `Category`
- `UnitCost`
- `SellingPrice`
- `StockQuantity`
- `ReorderLevel`

---

## 7. Appointments

Contains scheduled service appointments.

**Key fields:**

- `AppointmentID`
- `VehicleID`
- `AppointmentDate`
- `AppointmentTime`
- `Status`
- `ProblemDescription`
- `CreatedDate`

Possible appointment statuses:

- Scheduled
- Confirmed
- Completed
- Cancelled
- No Show

---

## 8. WorkOrders

Represents actual repair and maintenance work performed.

**Key fields:**

- `WorkOrderID`
- `AppointmentID`
- `MechanicID`
- `StartDateTime`
- `CompletionDateTime`
- `Status`
- `LaborCost`
- `Notes`

---

## 9. WorkOrderServices

A junction table connecting work orders and services.

A single work order can contain multiple services.

For example:

```text
Work Order #1001

Oil Change
Brake Inspection
Wheel Alignment
AC Service
```

This creates a many-to-many relationship:

```text
WorkOrders M ───── M Services
       │
       │
       ▼
WorkOrderServices
```

---

## 10. PartsUsed

Tracks parts used during each work order.

Example:

```text
Work Order #1001

Engine Oil       × 5
Oil Filter       × 1
Brake Pad        × 1
```

This allows analysis of:

- Parts consumption
- Parts revenue
- Parts cost
- Parts profitability
- Inventory requirements

---

## 11. Payments

Contains payment transactions associated with work orders.

**Key fields:**

- `PaymentID`
- `WorkOrderID`
- `PaymentDate`
- `Amount`
- `PaymentMethod`
- `PaymentStatus`
- `TransactionReference`

Payment methods include:

- Cash
- Credit Card
- Debit Card
- Bank Transfer
- JazzCash
- EasyPaisa

---

# 🔗 Relationships

| Relationship | Type |
|---|---|
| Customer → Vehicles | One-to-Many |
| Vehicle → Appointments | One-to-Many |
| Appointment → Work Order | One-to-Zero/One |
| Employee → Work Orders | One-to-Many |
| Work Order → Services | Many-to-Many |
| Work Order → Parts | Many-to-Many |
| Supplier → Parts | One-to-Many |
| Work Order → Payments | One-to-Many |

---

# 🛡️ Data Quality & Validation

Before performing analysis, the project will include SQL-based data-quality checks.

These checks will investigate:

### Missing Values

- Missing customer information
- Missing vehicle information
- Missing service information
- Missing payment information

### Duplicate Records

- Duplicate customer records
- Duplicate vehicle registrations
- Duplicate VINs
- Duplicate transactions

### Invalid Values

Examples:

```text
Negative mileage
Negative prices
Negative stock quantities
Invalid dates
Invalid payment amounts
```

### Referential Integrity

Checking for records that do not have valid parent records.

For example:

```text
Vehicles with non-existent customers
Work orders with non-existent appointments
Payments with non-existent work orders
```

### Business Rule Validation

Examples:

```text
Completion date before start date
Selling price below cost
Completed appointments without work orders
Completed work orders without payment records
Parts used in quantities greater than available inventory
```

The purpose is to ensure that analysis is based on reliable and consistent data.

---

# 💻 SQL Analysis

The analysis is designed around the type of work a **Junior Data Analyst** would realistically perform.

The project will not simply demonstrate SQL syntax. Queries will be organized around actual business questions.

---

# 1. Data Exploration

Initial exploration will be performed to understand the dataset.

Examples:

- How many customers are registered?
- How many vehicles are in the database?
- How many employees work at the service center?
- How many services are offered?
- How many appointments have been created?
- How many work orders have been completed?
- What date range does the dataset cover?

Example metrics:

```text
Total Customers
Total Vehicles
Total Appointments
Total Work Orders
Total Services
Total Parts
Total Revenue
```

---

# 2. Basic Descriptive Analysis

The project will use SQL to understand the distribution of the data.

Examples:

- Customers by city
- Vehicles by manufacturer
- Vehicles by fuel type
- Services by category
- Employees by role
- Appointments by status
- Payments by payment method
- Parts by category

SQL techniques:

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `ORDER BY`
- `DISTINCT`

---

# 3. Customer Analysis

Customer behavior will be analyzed to identify valuable and inactive customers.

### Questions

- Who are the top customers by spending?
- Which customers have visited the service center most frequently?
- Which customers own multiple vehicles?
- What is the average customer spend?
- Which customers are repeat customers?
- Which customers have not visited recently?
- Which cities have the most customers?
- Which cities generate the most revenue?

### Potential KPIs

```text
Total Customers
Average Customer Spend
Average Visits per Customer
Repeat Customer Rate
Top Customer Revenue
Customer Revenue by City
```

---

# 4. Vehicle Analysis

Vehicle data will be analyzed to understand the types of vehicles serviced.

### Questions

- Which manufacturers are serviced most frequently?
- Which vehicle models are most common?
- Which manufacturers generate the most revenue?
- Which vehicles have received the most services?
- Which vehicles have the highest maintenance costs?
- What is the average mileage of serviced vehicles?
- How does fuel type affect service demand?

### Example segmentation

```text
Vehicle Manufacturer
Vehicle Model
Vehicle Age
Fuel Type
Mileage
Maintenance Cost
Service Frequency
```

---

# 5. Appointment Analysis

Appointments will be analyzed to understand service demand and operational efficiency.

### Questions

- How many appointments are scheduled each month?
- What percentage of appointments are completed?
- What percentage are cancelled?
- What percentage are no-shows?
- Which days have the highest appointment volume?
- Which months have the highest demand?
- How far in advance do customers typically book?
- What are the most common customer-reported problems?

### KPIs

```text
Appointment Completion Rate
Cancellation Rate
No-Show Rate
Monthly Appointment Volume
Average Booking Lead Time
```

---

# 6. Service Analysis

This section identifies the services that drive demand and revenue.

### Questions

- What are the most frequently performed services?
- Which services generate the most revenue?
- Which service categories are most popular?
- What is the average price of each service?
- Which services generate the highest average revenue per work order?
- Which services take the longest to complete?
- Which services are most commonly performed together?

### Example analysis

```text
Service
    ↓
Number of Jobs
    ↓
Revenue
    ↓
Average Price
    ↓
Average Duration
```

---

# 7. Mechanic & Employee Analysis

Employee performance will be analyzed using operational metrics.

### Questions

- Which mechanics complete the most work orders?
- Which mechanics generate the most revenue?
- What is the average completion time by mechanic?
- Which mechanics handle the most expensive jobs?
- Which mechanics have the highest completion rates?
- How many work orders does each mechanic complete per month?

### KPIs

```text
Work Orders Completed
Revenue Generated
Average Job Value
Average Completion Time
Jobs per Month
```

The analysis will focus on **performance metrics rather than simply ranking employees**, allowing potential operational issues to be investigated.

---

# 8. Revenue & Financial Analysis

Revenue analysis is a major component of the project.

Revenue can be analyzed using:

```text
Service Revenue
+
Parts Revenue
+
Labor Revenue
=
Total Revenue
```

### Questions

- What is total revenue?
- What is monthly revenue?
- What is the average work-order value?
- Which services generate the most revenue?
- Which mechanics generate the most revenue?
- Which vehicle manufacturers generate the most revenue?
- Which customers generate the most revenue?
- What is the monthly revenue growth rate?
- What is the highest-revenue month?
- What is the lowest-revenue month?

### KPIs

```text
Total Revenue
Average Work Order Value
Monthly Revenue
Revenue Growth
Service Revenue
Parts Revenue
Labor Revenue
```

---

# 9. Profitability Analysis

Where sufficient cost data is available, profitability will also be investigated.

For parts:

```text
Part Profit =
Selling Price - Unit Cost
```

For a work order:

```text
Estimated Profit =
Service Revenue
+ Parts Revenue
+ Labor Revenue
- Parts Cost
```

### Questions

- Which parts generate the highest profit?
- Which services generate the highest revenue?
- Which work orders generate the highest profit?
- Which service categories have the highest margins?
- What is the estimated gross margin?

---

# 10. Inventory Analysis

The project will analyze spare-parts inventory.

### Questions

- Which parts are below reorder level?
- Which parts are used most frequently?
- Which parts generate the most revenue?
- Which parts generate the most profit?
- Which suppliers provide the most parts?
- What is the total value of current inventory?
- Which parts have low stock but high demand?

### Important business metric

```text
Inventory Value =
Stock Quantity × Unit Cost
```

The analysis can also identify parts that should be prioritized for replenishment.

---

# 11. Supplier Analysis

Supplier performance will be analyzed using available inventory and parts data.

### Questions

- Which suppliers provide the most parts?
- Which suppliers provide the highest-value parts?
- Which supplier has the largest product range?
- What is the average part cost by supplier?
- Which suppliers provide the most frequently used parts?

---

# 12. Time-Series Analysis

SQL date functions will be used to identify trends over time.

Examples:

- Monthly revenue
- Monthly appointments
- Monthly work orders
- Monthly customer activity
- Monthly service demand
- Monthly parts usage

The analysis will investigate:

```text
Month-over-Month Revenue
Month-over-Month Appointments
Seasonal Demand
Service Trends
Customer Activity Trends
```

---

# 13. Customer Retention & Recency Analysis

Customer activity will be analyzed using service history.

### Questions

- Which customers are active?
- Which customers are inactive?
- Which customers have returned multiple times?
- How long has it been since each customer's last visit?
- Which customers are at risk of becoming inactive?

Example customer segmentation:

```text
New Customer
Returning Customer
Active Customer
Inactive Customer
High-Value Customer
```

SQL date functions and conditional logic will be used to create these segments.

---

# 14. Ranking Analysis

SQL window functions will be used where appropriate.

Examples:

- Top customers by revenue
- Top services by revenue
- Top mechanics by completed jobs
- Top vehicle manufacturers
- Top parts by usage
- Top customers within each city

Techniques include:

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
```

---

# 15. Comparative Analysis

The project will also perform comparisons between groups.

Examples:

```text
Revenue by City
Revenue by Vehicle Manufacturer
Revenue by Service Category
Revenue by Mechanic
Revenue by Month
Revenue by Payment Method
```

This helps identify differences in business performance across segments.

---

# 16. Advanced Junior-Level SQL Analysis

The project will include more advanced analytical queries while remaining within the scope of practical Junior Data Analyst work.

Techniques include:

- Common Table Expressions
- Subqueries
- Correlated subqueries
- Conditional aggregation
- Window functions
- Ranking
- Running totals
- Month-over-month comparisons
- Percentage calculations
- Date calculations
- Multiple-table joins
- `CASE` statements

Example:

```sql
RANK() OVER (
    ORDER BY TotalRevenue DESC
)
```

Another example:

```sql
LAG(MonthlyRevenue) OVER (
    ORDER BY RevenueMonth
)
```

These techniques will be used to solve business problems rather than included simply for demonstration.

---

# 📈 Key Performance Indicators

The project will calculate a range of business KPIs.

### Customer KPIs

- Total Customers
- New Customers
- Repeat Customers
- Repeat Customer Rate
- Average Customer Spend
- Customer Lifetime Revenue

### Vehicle KPIs

- Total Vehicles
- Average Vehicle Mileage
- Average Maintenance Cost
- Services per Vehicle

### Appointment KPIs

- Total Appointments
- Completion Rate
- Cancellation Rate
- No-Show Rate

### Service KPIs

- Total Services Performed
- Most Popular Service
- Highest-Revenue Service
- Average Service Price

### Employee KPIs

- Work Orders Completed
- Revenue per Mechanic
- Average Job Completion Time
- Average Work Order Value

### Financial KPIs

- Total Revenue
- Service Revenue
- Parts Revenue
- Labor Revenue
- Average Work Order Value
- Estimated Profit
- Estimated Profit Margin
- Monthly Revenue Growth

### Inventory KPIs

- Total Parts
- Inventory Value
- Low-Stock Parts
- Parts Used
- Parts Revenue
- Parts Profit

---

# 🧠 Business Insights

The final stage of the project will translate SQL results into business recommendations.

Instead of simply reporting:

> "Oil Change was the most frequently performed service."

The analysis should go further:

> "Oil Change was the most frequently performed service, accounting for X% of completed services. This suggests consistent demand for routine maintenance and represents an opportunity to improve customer retention through scheduled maintenance reminders."

Similarly, instead of:

> "Part X has low inventory."

The analysis should investigate:

> "Part X is below its reorder level while ranking among the most frequently used parts. The combination of high demand and low inventory suggests a potential stock-out risk."

The final analysis will therefore focus on:

**Finding → Explanation → Business Impact → Recommendation**

---

# 🧪 Data Quality Analysis

Data quality will be treated as part of the analytical process rather than an afterthought.

The project will investigate:

- Missing values
- Duplicate records
- Invalid values
- Referential integrity
- Outliers
- Incorrect dates
- Negative financial values
- Invalid inventory quantities
- Inconsistent statuses
- Unexpected relationships

Example checks include:

```text
Customers without vehicles
Vehicles without customers
Appointments without valid vehicles
Work orders without appointments
Payments without work orders
Parts below zero stock
Invalid work-order dates
Duplicate vehicle registrations
```

---

# 🛠️ Tools & Technologies

- **Microsoft SQL Server**
- **SQL Server Management Studio (SSMS)**
- **SQL**
- **Git**
- **GitHub**

---

# 📚 SQL Concepts Demonstrated

This project demonstrates practical use of:

### Database

- Relational database design
- Normalization
- Primary keys
- Foreign keys
- Constraints
- Referential integrity

### SQL

- `SELECT`
- `WHERE`
- `DISTINCT`
- `ORDER BY`
- `TOP`
- `CASE`
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `GROUP BY`
- `HAVING`
- `INNER JOIN`
- `LEFT JOIN`
- Multiple-table joins
- Subqueries
- CTEs
- Window functions
- `ROW_NUMBER`
- `RANK`
- `DENSE_RANK`
- `LAG`
- Conditional aggregation
- Date functions
- String functions
- NULL handling
- Percentage calculations

### Analytical Skills

- Data exploration
- Data-quality assessment
- KPI development
- Descriptive analysis
- Comparative analysis
- Trend analysis
- Customer segmentation
- Revenue analysis
- Profitability analysis
- Inventory analysis
- Operational analysis
- Business problem solving
- Insight generation

---

# 🗺️ Project Roadmap

## Phase 1 — Database Architecture

- [x] Identify business entities
- [x] Define tables
- [x] Define relationships
- [x] Define primary keys
- [x] Define foreign keys
- [x] Design relational structure

## Phase 2 — Database Creation

- [ ] Create SQL Server database
- [ ] Create tables
- [ ] Add primary keys
- [ ] Add foreign keys
- [ ] Add constraints

## Phase 3 — Data Quality

- [ ] Validate relationships
- [ ] Identify missing values
- [ ] Identify duplicates
- [ ] Check invalid values
- [ ] Check business-rule violations

## Phase 4 — Data Generation

- [ ] Generate realistic customers
- [ ] Generate vehicles
- [ ] Generate employees
- [ ] Generate services
- [ ] Generate suppliers
- [ ] Generate parts
- [ ] Generate appointments
- [ ] Generate work orders
- [ ] Generate services performed
- [ ] Generate parts used
- [ ] Generate payments

## Phase 5 — Data Exploration

- [ ] Understand dataset size
- [ ] Explore distributions
- [ ] Examine categorical variables
- [ ] Examine numerical variables
- [ ] Identify initial patterns

## Phase 6 — Business Analysis

- [ ] Customer analysis
- [ ] Vehicle analysis
- [ ] Appointment analysis
- [ ] Service analysis
- [ ] Employee analysis
- [ ] Revenue analysis
- [ ] Profitability analysis
- [ ] Inventory analysis
- [ ] Supplier analysis
- [ ] Time-series analysis
- [ ] Customer retention analysis

## Phase 7 — Advanced SQL

- [ ] CTE analysis
- [ ] Subqueries
- [ ] Window functions
- [ ] Ranking
- [ ] Running totals
- [ ] Month-over-month analysis
- [ ] Comparative analysis

## Phase 8 — Business Insights

- [ ] Identify key findings
- [ ] Quantify business impact
- [ ] Identify potential problems
- [ ] Develop recommendations
- [ ] Document final insights

---

# 📌 Project Status

**Status:** 🚧 In Development

### Completed

- Database architecture
- Entity identification
- Relationship design
- Table design
- Primary keys
- Foreign keys
- Data validation constraints
- Initial database schema

### Current Phase

**Phase 3 — Data Quality & Validation**

### Upcoming

**Realistic Data Generation → SQL Data Analysis → Advanced SQL → Business Insights**

---

# 👤 Author

**Francis Parwez**

MSc Data Science

This project is part of my data analytics portfolio and demonstrates practical SQL, relational database design, data-quality analysis, business analysis, and analytical problem-solving skills.
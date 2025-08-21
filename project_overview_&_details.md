# Project Overview <!-- Purpose of the Project -->

This project introduces SQL fundamentals and uses a simplified commerce database. While designed as a beginner-friendly exercise, the schema incorporates multiple real processes, including orders, payments, and many aspects of business operations.


## Business Objective <!-- Goal of the Project -->

In this database, the objective of the project is to demonstrate SQL skills through schema validation, data insertion, and queries that simulate common business questions in a commerce environment. 


## Database Constraints 

- Beginner-level database design 
- Some business constraints may not be represented 
- Analysis is limited due to the small sample size
- Each table includes a minimum of 3 rows of sample data for validation
- Every table has a PK
- Many-to-many relationships have a composite entity 


## Project Process

1. **Design Phase**
    - The database design was influenced by e-commerce businesses such as Amazon and Wayfair.
    - Focused on identifying key entities and relationships needed for a commerce environment.

2. **Implementation Process**
    - Established business rules to determine the required tables and relationships.
    - Constructed PK and FK constraints to enforce referential integrity (3NF).
    - Inserted a minimum of 3 rows per table, resulting in a total of 72 inserts.

3. **Validation Process** 
    - Ran a query that confirmed that each table met the minimum number of inserts.
    - Verified that PK and FK relationships were correctly enforced, utilizing crow's foot.

4. **Analysis Phase**
    - Developed analytical queries to simulate real-world business questions. 


## Schema and Inserts 

The schema was implemented in `schema_and_inserts.sql`, which contains:
- Table creation with PK, FK, and constraints.
- Sample data.

[View Schema and Inserts SQL](schema_&_inserts.sql)


## Challenges & Lessons Learned 

- Understanding SQL constraints like ON DELETE RESTRICT was challenging, as defaults sometimes caused unexpected issues when deleting records.
- This project reinforced the importance of designing well-defined database business rules. A structured, rule-driven approach ensures accuracy, consistency, and smoother implementation.

  
## Credit/Contributions 

**Team members**
- Pravalika Jetty & Yavar Begg → DQL query: Products > $36 by category  
- Alondra Alonso → DQL query: USB-C Hub full record and Aggregate product performance query 
- Ever Becerra → DML/DDL queries, cascade deletes, validation checks  

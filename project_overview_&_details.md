# Project Overview <!-- Purpose of the Project -->

This project introduces SQL fundamentals and uses a simplified commerce database. While designed as a beginner-friendly exercise, the schema incorporates multiple real processes, including orders, payments, and many aspects of business operations.


## Business Objective <!-- Goal of the Project -->

In this database, the goal of the project is to practice SQL skills through schema validation, data insertion, and queries that simulate common business questions in a commerce environment. 


## Database Constraints 

- Beginner-level database design 
- Some business constraints may not be represented 
- Analysis is limited due to the small sample size
- Data minimum (≥ 3 rows per table)
- Every table has a PK
- Many-to-many relationships have a composite entity 


## Project Process

1. **Design Phase**
    - The database design was influenced by e-commerce businesses such as Amazon and Wayfair.
    - Focused on identifying key entities and relationships needed for a commerce environment.

2. **Implementation Process**
    - Established business rules to determine the required tables and relationships.
    - Constructed PK and FK constraints to enforce referential integrity.
    - Inserted a minimum of 3 rows per table, resulting in a total of 72 inserts.

3. **Validation Process** 
    - Ran a query that confirmed that each table met the minimum number of inserts.
    - Verified that PK and FK relationships were correctly enforced.

4. **Analysis Phase**
    - Developed analytical queries to simulate real-world business questions. 


## Schema and Inserts 

The schema was implemented in `schema_and_inserts.sql`, which contains:
- Table creation with PK, FK, and constraints.
- Sample data.

[View Schema and Inserts SQL](schema_and_inserts.sql)


## Challenges & Lessons Learned 

- As a new learner coming into this project, understanding the nuances of SQL behavior was challenging. For example, certain constraints like 'DELETE ON RESTRICT' are enabled by default and cause unexpected issues when attempting to delete related records.
- This project reinforced the importance of designing well-defined database business rules. A structured, rule-driven approach ensures accuracy, consistency, and smoother implementation.

  
## Credit/Contributions 

**Team members**
- Yavar Begg
- Alondra Alonso
- Pravalika Jetty
    

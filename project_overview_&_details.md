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
    - Verified that PK and FK relationships were correctly enforced 

4. **Analysis Phase**
    - Developed analytical queries to simulate real-world business questions. 


## Schema and Inserts 

The schema was implemented in `schema_and_inserts.sql`, which contains:
- Table creation with PK, FK, and constraints.
- Sample data

[View Schema and Inserts SQL](schema_and_inserts.sql)


## Challenges & Lessons Learned 

- When creating a database as a new learner, it was difficult to understand some of the features of the language, for example, some features like 'on delete restrict' come as default and later become a challenge during the project when deleting a specific individual inside an entity.
- Having a rigorous approach on how to creating a database using business rules is essential for a seamless and accurate implementation
- 

## Credit/Contributions 

**Team members**
- Yavar Begg
- Alondra Alonso
- Pravalika Jetty
    

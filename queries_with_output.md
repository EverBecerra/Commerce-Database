# Queries with Output

## 🧪 Query 1: Data Sample Validation Count 

Validates that each table contains at least three inserted rows.

<details>
  <summary><strong>🔍 Show Query 1 and Output</strong></summary>

  ```sql
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'All tables have >= 3 rows'
        ELSE 'Some tables have fewer than 3 rows'
    END AS `Insert Check`
FROM information_schema.tables
WHERE table_schema = 'dbms_project'
	AND table_rows < 3;
```

<img width="219" height="66" alt="image" src="https://github.com/user-attachments/assets/c831a692-3111-4d71-9acb-26bf606363b0" />

</details>


## 🛠️ Query 2: FK Reconstructions and Cascading Deletion

Reconstructed a foreign key with ON DELETE CASCADE to enable deletion of parent rows while preserving referential integrity.

Steps to follow:
   1. Find the FK constraint name on the table using the reference 
   2. Drop the existing FK
   3. Generate a new FK with the CASCADE

<details>
  <summary><strong>🔍 Show Query 2 and Output</strong></summary>
  
```sql
SELECT 
	constraint_name 						    #Name of the FK/PK/Constraint
FROM 
	information_schema.key_column_usage			#Metadata mapping key columns and their references 
WHERE table_schema = 'dbms_project' 			#Database containing the child table
    AND table_name = 'driver' 					#Child table containing the FK we want to modify 
    AND referenced_table_name = 'employees';	#Parent table the FK points to 

-- Step 2: Drop the existing FK from driver
ALTER TABLE driver							
DROP FOREIGN KEY driver_ibfk_1;

-- Step 3: Recreate FK with cascade rules
ALTER TABLE driver 
ADD CONSTRAINT fk_driver_employee
FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;    -- Cascades delete and update actions to child table


-- Repeat for related tables
ALTER TABLE vehicle_fulfillment
DROP FOREIGN KEY vehicle_fulfillment_ibfk_2;

ALTER TABLE vehicle_fulfillment
ADD CONSTRAINT fk_vehicle_fulfillment_driver 
FOREIGN KEY (driver_id) REFERENCES driver(driver_id) ON DELETE CASCADE;

ALTER TABLE delivery
DROP FOREIGN KEY delivery_ibfk_1;

ALTER TABLE delivery
ADD CONSTRAINT fk_delivery_vehicle_fulfillment
FOREIGN KEY (vehicle_id) REFERENCES vehicle_fulfillment(vehicle_id) ON DELETE CASCADE;

ALTER TABLE fulfillment_method
DROP FOREIGN KEY fulfillment_method_ibfk_1;

ALTER TABLE fulfillment_method
ADD CONSTRAINT fk_fulfillment_method_delivery
FOREIGN KEY (delivery_id) REFERENCES delivery(delivery_id) ON DELETE CASCADE;

ALTER TABLE pick_up_location
DROP FOREIGN KEY pick_up_location_ibfk_1;

ALTER TABLE pick_up_location
ADD CONSTRAINT fk_pick_up_location_vehicle_fulfillment
FOREIGN KEY (vehicle_id) REFERENCES vehicle_fulfillment(vehicle_id) ON DELETE CASCADE;
```

<img width="1561" height="262" alt="image" src="https://github.com/user-attachments/assets/7686c7db-74e4-4ba4-a0fd-38d08a55734b" />


```sql
-- View employees table
SELECT * FROM employees;
```

<img width="783" height="106" alt="image" src="https://github.com/user-attachments/assets/71814c40-2bea-47b0-80e0-ffd298025cb5" />

⚠️ Warning: Deleting by name in production environments is risky—consider using the primary key instead.
```sql
-- Disable safe updates (allows deletes without key filters)
SET SQL_SAFE_UPDATES = 0; 

-- Demo delete: remove all employees named Brandon
-- (For demo only — in production, delete by primary key)
DELETE FROM employees
WHERE first_name = 'Brandon';
```

<img width="781" height="81" alt="image" src="https://github.com/user-attachments/assets/b8ec5107-32db-43b2-9600-1f282d2ded21" />

</details>


## 📊 Query 3: Products Priced Above $36 with Inner Join 

This query returns the product name, item price, and category names by performing an inner join between the 'product' and 'category' tables. Items are filtered where the product price is higher than $36.

<details>
	<summary><strong>🔍 Show Query 3 and Output</strong></summary>
		
```sql 
SELECT 
	p.product_name, 
    p.item_price, 
    c.category_name 
FROM product p
INNER JOIN category c
	ON p.category_id = c.category_id
WHERE p.item_price > 36 
ORDER BY p.item_price DESC; 
```

<img width="424" height="65" alt="image" src="https://github.com/user-attachments/assets/127bbe4f-7b2d-45a5-a797-e4481497f369" />

</details>


## 📊 Query 4: Retrieve Full Product Record 

This query retrieves the complete records for the USB-C Hub product, including all attributes stored in the 'product' table.

<details>
	<summary><strong>🔍 Show Query 4 and Output</strong></summary>

```sql
SELECT * 
FROM product 
WHERE product_name = 'USB-C Hub' 
ORDER BY product_name ASC;
```

<img width="407" height="29" alt="image" src="https://github.com/user-attachments/assets/1ff2ec2f-b67b-4486-87b6-f4ff7ec92094" />

</details>


## 📊 Query 5: Aggregate Product Performance

Aggregates product performance with average ratings, review count, and units sold by joining 'product', 'category', 'reviews', and 'order_items'; results are ordered by units sold and rating.

<details>
	<summary><strong>🔍 Show Query 5 and Output</strong></summary>

```sql
SELECT 
	p.product_id, 
	p.product_name, 
	c.category_name, 
	p.item_price, 
	AVG(r.rating) AS average_rating, 
	COUNT(r.review_id) AS total_reviews, 
	COALESCE(SUM(oi.quantity), 0) AS total_units_sold
FROM product p 
JOIN category c
	ON p.category_id = c.category_id 
LEFT JOIN reviews r
	ON p.product_id = r.product_id 
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id 
GROUP BY 
	p.product_id, 
    p.product_name, 
	c.category_name, 
	p.item_price 
ORDER BY 
	total_units_sold DESC, 
	average_rating DESC;
```

<img width="965" height="114" alt="image" src="https://github.com/user-attachments/assets/86f566ba-e869-49c6-96b1-a0b2fda6c85f" />

</details>

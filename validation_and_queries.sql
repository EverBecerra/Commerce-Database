/***

 My Part!!!

***/




-- This statement validates that we successfully inserted 3 rows per table
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'All tables have >= 3 rows'
        ELSE 'Some tables have fewer than 3 rows'
    END AS `Insert Check`
FROM information_schema.tables
WHERE table_schema = 'dbms_project'
  AND table_rows < 3;


/***
 Data Manipulation Language (DML) & Data Definition Language (DDL) queries
 For this particular query we specifically called to drop all instances of Brandon where the first name equals Brandon
 Since ON DELETE CASCADE was not originally defined, MySQL defaults to ON DELETE RESTRICT,
 which prevents deleting a parent row while child rows still reference it.
 Steps to follow:
   1. Find the FK constraint name on the table using the reference 
   2. Drop the existing FK
   3. Generate a new FK with the CASCADE
***/


-- Step 1: Find the FK constraint linking driver to employees
SELECT 
	constraint_name 						    #Name of the FK/PK/Constraint
FROM 
	information_schema.key_column_usage			#Metadata mapping key columns and their references 
WHERE 
	table_schema = 'dbms_project' 				#Database containing the child table
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


-- View employees table
SELECT * FROM employees;

-- Disable safe updates (allows deletes without key filters)
SET SQL_SAFE_UPDATES = 0; 

-- Demo delete: remove all employees named Brandon
-- (For demo only — in production, delete by primary key)
DELETE FROM employees
WHERE first_name = 'Brandon';



/***

 Revised and provided feedback for the following queries created by my team members alter

***/



-- Data Query Language (DQL)
-- Teammates:Pravalika Jetty & Yavar Begg
-- Products priced > $36 with category
SELECT 
	p.product_name, 
    p.item_price, 
    c.category_name 
FROM 
	product p
INNER JOIN category c ON p.category_id = c.category_id
WHERE 
	p.item_price > 36 
ORDER BY 
	p.item_price DESC; 


-- Teammate: Alondra Alonso 
-- Full record for the USB-C Hub product
SELECT 
	* 
FROM
	product 
WHERE 
	product_name = 'USB-C Hub' 
ORDER BY 
	product_name ASC; 


-- Aggregate product performance: avg rating, review count, units sold; join product, category, reviews, order_items; order by units sold & rating
SELECT 
	p.product_id, 
	p.product_name, 
	c.category_name, 
	p.item_price, 
	AVG(r.rating) AS average_rating, 
	COUNT(r.review_id) AS total_reviews, 
	COALESCE(SUM(oi.quantity), 0) AS total_units_sold
FROM 
	product p 
JOIN category c ON p.category_id = c.category_id 
LEFT JOIN reviews r ON p.product_id = r.product_id 
LEFT JOIN order_items oi ON p.product_id = oi.product_id 
GROUP BY 
	p.product_id, 
    p.product_name, 
	c.category_name, 
	p.item_price 
ORDER BY 
	total_units_sold DESC, 
	average_rating DESC; 

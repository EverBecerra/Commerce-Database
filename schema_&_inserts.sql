CREATE DATABASE dbms_project;
USE dbms_project;

CREATE TABLE billing_address (
  billing_id INT PRIMARY KEY,
  street VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(50)
);

CREATE TABLE category (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  description VARCHAR(100),
  updated_date DATE,
  active_status TINYINT(1)
);

CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE customer_address (
  customer_address_id INT PRIMARY KEY,
  street VARCHAR(20),
  city VARCHAR(20),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(20)
);

CREATE TABLE return_location (
  return_address_id INT PRIMARY KEY,
  street VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(50)
);

CREATE TABLE customer_address_link (
  customer_id INT,
  customer_address_id INT,
  PRIMARY KEY (customer_id, customer_address_id),
  KEY customer_address_id (customer_address_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  FOREIGN KEY (customer_address_id) REFERENCES customer_address (customer_address_id)
);

CREATE TABLE customer_payment_option (
  payment_option_id INT PRIMARY KEY,
  payment_type VARCHAR(50),
  card_name VARCHAR(50),
  card_number VARCHAR(16),
  expiration_date DATE,
  billing_id INT,
  KEY billing_id (billing_id),
  FOREIGN KEY (billing_id) REFERENCES billing_address (billing_id)
);

CREATE TABLE warehouse (
  warehouse_id INT PRIMARY KEY,
  warehouse_name VARCHAR(50),
  open_time TIME,
  operating_days VARCHAR(50),
  phone_number VARCHAR(10),
  street VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(50),
  capacity INT,
  temperature_controlled TINYINT(1),
  close_time TIME
);

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  role VARCHAR(20),
  department VARCHAR(20),
  hire_date DATE,
  warehouse_id INT,
  KEY warehouse_id (warehouse_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id)
);

CREATE TABLE driver (
  driver_id INT PRIMARY KEY,
  active_license TINYINT(1),
  license_number VARCHAR(15),
  license_class CHAR(2),
  employee_id INT,
  KEY employee_id (employee_id),
  FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

CREATE TABLE vehicle_fulfillment (
  vehicle_id INT PRIMARY KEY,
  vehicle_type VARCHAR(20),
  vehicle_capacity INT,
  vehicle_status VARCHAR(30),
  driver_id INT,
  warehouse_id INT,
  KEY warehouse_id (warehouse_id),
  KEY driver_id (driver_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
  FOREIGN KEY (driver_id) REFERENCES driver (driver_id)
);

CREATE TABLE delivery (
  delivery_id INT PRIMARY KEY,
  delivery_date DATE,
  delivery_instructions VARCHAR(200),
  distance FLOAT,
  signature_required TINYINT(1),
  delivery_method VARCHAR(20),
  temperature_controlled TINYINT(1),
  vehicle_id INT,
  customer_address_id INT,
  KEY vehicle_id (vehicle_id),
  KEY customer_address_id (customer_address_id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicle_fulfillment (vehicle_id),
  FOREIGN KEY (customer_address_id) REFERENCES customer_address (customer_address_id)
);

CREATE TABLE supplier (
  supplier_id INT PRIMARY KEY,
  supplier_name VARCHAR(50),
  phone_number VARCHAR(10),
  email VARCHAR(50),
  business_type VARCHAR(50),
  contract_status VARCHAR(50),
  shipment_number VARCHAR(7)
);

CREATE TABLE distribution (
  warehouse_id INT,
  supplier_id INT,
  distributer_id INT,
  distributer_name VARCHAR(50),
  shipment_number VARCHAR(7) PRIMARY KEY,
  delivery_date DATE,
  amount_of_items_supplied INT,
  KEY supplier_id (supplier_id),
  KEY distribution_ibfk_1 (warehouse_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse (warehouse_id),
  FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

CREATE TABLE pick_up_location (
  pick_up_id INT PRIMARY KEY,
  location_name VARCHAR(50),
  street VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(50),
  open_time TIME,
  operating_dates DATE,
  phone_number VARCHAR(10),
  capacity INT,
  type_of_location VARCHAR(30),
  vehicle_id INT,
  close_time TIME,
  KEY vehicle_id (vehicle_id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicle_fulfillment (vehicle_id)
);

CREATE TABLE `order` (
  order_id INT PRIMARY KEY,
  order_date DATE,
  order_time TIME,
  customer_id INT,
  KEY customer_id (customer_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE fulfillment_method (
  pick_up_id INT,
  delivery_id INT,
  order_id INT,
  PRIMARY KEY (pick_up_id, delivery_id, order_id),
  KEY delivery_id (delivery_id),
  KEY order_id (order_id),
  FOREIGN KEY (delivery_id) REFERENCES delivery (delivery_id),
  FOREIGN KEY (pick_up_id) REFERENCES pick_up_location (pick_up_id),
  FOREIGN KEY (order_id) REFERENCES `order` (order_id)
);

CREATE TABLE manufacturer (
  manufacturer_id INT PRIMARY KEY,
  manufacturer_name VARCHAR(50),
  phone_number INT,
  email VARCHAR(50),
  street VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2),
  zip_code VARCHAR(10),
  country VARCHAR(50)
);

CREATE TABLE product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  description VARCHAR(100),
  item_price FLOAT,
  category_id INT,
  KEY category_id (category_id),
  FOREIGN KEY (category_id) REFERENCES category (category_id)
);

CREATE TABLE order_items (
  product_id INT,
  order_id INT,
  quantity INT,
  PRIMARY KEY (product_id, order_id),
  KEY order_id (order_id),
  FOREIGN KEY (product_id) REFERENCES product (product_id),
  FOREIGN KEY (order_id) REFERENCES `order` (order_id)
);

CREATE TABLE order_payment (
  order_id INT,
  payment_option_id INT,
  payment_amount FLOAT,
  PRIMARY KEY (order_id, payment_option_id),
  KEY payment_option_id (payment_option_id),
  FOREIGN KEY (order_id) REFERENCES `order` (order_id),
  FOREIGN KEY (payment_option_id) REFERENCES customer_payment_option (payment_option_id)
);

CREATE TABLE `return` (
  return_id INT PRIMARY KEY,
  return_reason VARCHAR(50),
  return_date DATE,
  refund_amount FLOAT,
  return_day_limit INT,
  return_address_id INT,
  order_id INT,
  KEY order_id (order_id),
  KEY return_address_id (return_address_id),
  FOREIGN KEY (order_id) REFERENCES `order` (order_id),
  FOREIGN KEY (return_address_id) REFERENCES return_location (return_address_id)
);

CREATE TABLE reviews (
  review_id INT PRIMARY KEY,
  rating INT,
  review_text VARCHAR(200),
  review_date DATE,
  verified_purchase TINYINT(1),
  product_id INT,
  KEY product_id (product_id),
  FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE supplier_manufacturer_link (
  manufacturer_id INT,
  supplier_id INT,
  PRIMARY KEY (manufacturer_id, supplier_id),
  KEY supplier_id (supplier_id),
  FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (manufacturer_id),
  FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

INSERT INTO category(category_id, category_name, description, updated_date, active_status) VALUES
(301, 'Computer Accessories', 'Various accessories for computers and laptops', '2024-11-07', 1),
(302, 'Keyboards', 'Range of mechanical and membrane keyboards', '2024-11-08', 1),
(303, 'Adapters and Hubs', 'USB and multi-port adapters for connectivity', '2024-11-09', 1);

INSERT INTO product(product_id, product_name, description, item_price, category_id) VALUES
(201, 'Wireless Mouse', 'Ergonomic wireless mouse with USB receiver', 25.99, 301),
(202, 'Mechanical Keyboard', 'RGB backlit mechanical keyboard with blue switches', 59.99, 302),
(203, 'USB-C Hub', '7-in-1 USB-C hub with HDMI and USB 3.0 ports', 34.99, 303);

INSERT INTO customer(customer_id, first_name, last_name, email, phone) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '206-555-0101'),
(2, 'Emily', 'Johnson', 'emily.j@email.com', '503-555-0202'),
(3, 'Michael', 'Brown', 'michael.b@email.com', '415-555-0303');

INSERT INTO billing_address(billing_id, street, city, state, zip_code, country) VALUES
(1, '123 Oak Street', 'Seattle', 'WA', '98101', 'USA'),
(2, '456 Pine Avenue', 'Portland', 'OR', '97201', 'USA'),
(3, '789 Maple Drive', 'San Francisco', 'CA', '94105', 'USA');

INSERT INTO customer_payment_option(payment_option_id, payment_type, card_name, card_number, expiration_date, billing_id) VALUES
(1, 'VISA', 'John Smith', '4111111111111111', '2025-12-31', 1),
(2, 'MASTERCARD', 'Emily Johnson', '5555555555554444', '2024-10-31', 2),
(3, 'AMEX', 'Michael Brown', '378282246310005', '2026-06-30', 3);

INSERT INTO customer_address(customer_address_id, street, city, state, zip_code, country) VALUES
(1, '123 Oak Street', 'Seattle', 'WA', '98101', 'USA'),
(2, '456 Pine Avenue', 'Portland', 'OR', '97201', 'USA'),
(3, '789 Maple Drive', 'San Francisco', 'CA', '94105', 'USA');

INSERT INTO customer_address_link(customer_id, customer_address_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO warehouse(warehouse_id, warehouse_name, open_time, operating_days, phone_number, street, city, state, zip_code, country, capacity, temperature_controlled, close_time) VALUES
(10, 'Seattle DC', '08:00:00', 'Mon-Fri', '2065551111', '1500 1st Ave', 'Seattle', 'WA', '98101', 'USA', 5000, 1, '18:00:00'),
(11, 'Portland Hub', '09:00:00', 'Mon-Sat', '5035552222', '2500 Pine St', 'Portland', 'OR', '97201', 'USA', 3500, 0, '17:00:00'),
(12, 'SF Fulfillment', '07:00:00', 'Daily', '4155553333', '3500 Market St', 'San Francisco', 'CA', '94105', 'USA', 8000, 1, '19:00:00');

INSERT INTO employees(employee_id, first_name, last_name, role, department, hire_date, warehouse_id) VALUES
(1001, 'Alice', 'Nguyen', 'Manager', 'Operations', '2022-05-10', 10),
(1002, 'Brandon', 'Lee', 'Supervisor', 'Logistics', '2023-03-15', 11),
(1003, 'Carla', 'Diaz', 'Coordinator', 'Dispatch', '2024-01-08', 12);

INSERT INTO driver(driver_id, active_license, license_number, license_class, employee_id) VALUES
(2001, 1, 'WA1234567890', 'C1', 1001),
(2002, 1, 'OR0987654321', 'B2', 1002),
(2003, 1, 'CA1122334455', 'A3', 1003);

INSERT INTO vehicle_fulfillment(vehicle_id, vehicle_type, vehicle_capacity, vehicle_status, driver_id, warehouse_id) VALUES
(5001, 'Van', 100, 'Available', 2001, 10),
(5002, 'Truck', 300, 'Available', 2002, 11),
(5003, 'Reefer Truck', 250, 'In Service', 2003, 12);

INSERT INTO pick_up_location(pick_up_id, location_name, street, city, state, zip_code, country, open_time, operating_dates, phone_number, capacity, type_of_location, vehicle_id, close_time) VALUES
(6001, 'Seattle Locker A', '101 Locker Ln', 'Seattle', 'WA', '98101', 'USA', '08:00:00', '2024-11-09', '2065554444', 50, 'Locker', 5001, '20:00:00'),
(6002, 'Portland Counter B', '202 Counter Rd', 'Portland', 'OR', '97201', 'USA', '09:00:00', '2024-11-09', '5035555555', 30, 'Counter', 5002, '18:00:00'),
(6003, 'SF Locker C', '303 Bay St', 'San Francisco', 'CA', '94105', 'USA', '07:30:00', '2024-11-10', '4155556666', 40, 'Locker', 5003, '19:30:00');

INSERT INTO delivery(delivery_id, delivery_date, delivery_instructions, distance, signature_required, delivery_method, temperature_controlled, vehicle_id, customer_address_id) VALUES
(7001, '2024-11-10', 'Leave at front desk', 5.2, 0, 'Standard', 0, 5001, 1),
(7002, '2024-11-10', 'Ring doorbell once', 7.8, 1, 'Priority', 0, 5002, 2),
(7003, '2024-11-11', 'Keep upright', 3.4, 1, 'Refrigerated', 1, 5003, 3);

INSERT INTO manufacturer(manufacturer_id, manufacturer_name, phone_number, email, street, city, state, zip_code, country) VALUES
(3001, 'Northwest Peripherals Inc.', 2025550001, 'contact@nwpinc.com', '400 Tech Way', 'Seattle', 'WA', '98101', 'USA'),
(3002, 'Cascade Electronics', 2005550002, 'info@cascade-elec.com', '500 Silicon Ave', 'Portland', 'OR', '97201', 'USA'),
(3003, 'Bay Area Components', 2147483647, 'sales@baycomponents.com', '600 Innovation Dr', 'San Francisco', 'CA', '94105', 'USA');

INSERT INTO supplier(supplier_id, supplier_name, phone_number, email, business_type, contract_status, shipment_number) VALUES
(4001, 'Evergreen Supply Co.', '2065557777', 'support@evergreensupply.com', 'Wholesaler', 'Active', 'SHP1001'),
(4002, 'Rose City Distributors', '5035558888', 'contact@rosecitydist.com', 'Distributor', 'Active', 'SHP1002'),
(4003, 'Golden Gate Wholesale', '4155559999', 'hello@goldengatewholesale.com', 'Wholesaler', 'On Hold', 'SHP1003');

INSERT INTO supplier_manufacturer_link(manufacturer_id, supplier_id) VALUES
(3001, 4001),
(3002, 4002),
(3003, 4003);

INSERT INTO distribution(warehouse_id, supplier_id, distributer_id, distributer_name, shipment_number, delivery_date, amount_of_items_supplied) VALUES
(10, 4001, 9001, 'Evergreen Logistics', 'DSTR001', '2024-11-09', 120),
(11, 4002, 9002, 'Rose City Freight', 'DSTR002', '2024-11-10', 200),
(12, 4003, 9003, 'Golden Gate Transit', 'DSTR003', '2024-11-11', 180);

INSERT INTO `order`(order_id, order_date, order_time, customer_id) VALUES
(101, '2024-11-09', '10:20:00', 1),
(102, '2024-11-09', '11:15:00', 2),
(103, '2024-11-10', '13:45:00', 3);

INSERT INTO order_items(product_id, order_id, quantity) VALUES
(201, 101, 2),
(202, 102, 1),
(203, 103, 3);

INSERT INTO reviews(review_id, rating, review_text, review_date, verified_purchase, product_id) VALUES
(301, 5, 'Excellent product, works perfectly!', '2024-11-08', 1, 201),
(302, 4, 'Good quality, but a bit pricey.', '2024-11-09', 1, 202),
(303, 3, 'Average performance, decent build.', '2024-11-10', 1, 203);

INSERT INTO order_payment(order_id, payment_option_id, payment_amount) VALUES
(101, 1, 150.00),
(102, 2, 275.50),
(103, 3, 104.97);

INSERT INTO return_location(return_address_id, street, city, state, zip_code, country) VALUES
(8001, '100 Return Way', 'Seattle', 'WA', '98101', 'USA'),
(8002, '200 Return Ave', 'Portland', 'OR', '97201', 'USA'),
(8003, '300 Return Rd', 'San Francisco', 'CA', '94105', 'USA');

INSERT INTO `return`(return_id, return_reason, return_date, refund_amount, return_day_limit, return_address_id, order_id) VALUES
(9001, 'Defective item', '2024-11-12', 59.99, 30, 8001, 102),
(9002, 'Changed mind', '2024-11-13', 25.99, 30, 8002, 101),
(9003, 'Wrong item shipped', '2024-11-14', 34.99, 30, 8003, 103);

INSERT INTO fulfillment_method(pick_up_id, delivery_id, order_id) VALUES
(6001, 7001, 101),
(6002, 7002, 102),
(6003, 7003, 103);

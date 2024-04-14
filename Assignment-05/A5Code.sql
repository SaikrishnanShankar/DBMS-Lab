SET ECHO OFF;
-- Creating Required Tables

DROP TABLE order_list;
DROP TABLE orders;
DROP TABLE pizza;
DROP TABLE customer;

CREATE TABLE customer(
	cust_id VARCHAR2(5),
	cust_name VARCHAR2(25),
	address VARCHAR2(50),
	phone NUMBER(10),
	CONSTRAINT cust_pk PRIMARY KEY(cust_id)
);

CREATE TABLE pizza(
	pizza_id VARCHAR2(5),
	pizza_type VARCHAR2(10),
	unit_price NUMBER(3),
	CONSTRAINT pizza_pk PRIMARY KEY(pizza_id)
);

CREATE TABLE orders(
	order_no VARCHAR2(5),
	cust_id VARCHAR2(5),
	order_date DATE,
	delv_date DATE,
	CONSTRAINT orders_pk PRIMARY KEY(order_no),
	CONSTRAINT orders_fk_cust FOREIGN KEY(cust_id) REFERENCES customer(cust_id)
);

CREATE TABLE order_list(
	order_no VARCHAR2(5),
	pizza_id VARCHAR2(5),
	qty NUMBER(2),
	CONSTRAINT order_list_pk PRIMARY KEY(order_no,pizza_id),
	CONSTRAINT order_list_orders FOREIGN KEY(order_no) REFERENCES orders(order_no),
	CONSTRAINT order_list_pizza FOREIGN KEY(pizza_id) REFERENCES pizza(pizza_id)
); 

-- Inserting Values into Tables

@ /home/mahesh/Pizza_DB.sql
CLEAR SCREEN;
SET ECHO ON;
SET SERVEROUTPUT ON;
SET LINESIZE 150;

-- ****************************************************************************************
-- Q1 Check Whether the given pizza type is available or not
-- ****************************************************************************************

CREATE OR REPLACE PROCEDURE display_type(p_type IN pizza.pizza_type%TYPE) AS
	CURSOR C1 IS
		SELECT *
		FROM pizza;
	c number;
BEGIN
	c:=0;
	FOR entry IN C1 LOOP
		IF entry.pizza_type=p_type THEN
			c:=c + 1;
		END IF;
	END LOOP;

	IF c = 0 THEN
		dbms_output.put_line('No such type Found!');
	ELSE
		dbms_output.put_line('Type found!');
	END IF;
END display_type;
/

DECLARE
	p_type pizza.pizza_type%TYPE;
BEGIN
	p_type:='&pizza_type';
	display_type(p_type);
END;
/

-- ****************************************************************************************
-- Q2 For the given customer name and a range of order date, find whether a customer had
--    placed any order, if so display the number of orders placed by the customer along
--    with the order number(s).
-- ****************************************************************************************

CREATE OR REPLACE PROCEDURE order_range(
	name IN customer.cust_name%TYPE,
	st_date IN DATE,
	ed_date IN DATE
) AS
	CURSOR orders_cust IS
		SELECT *
		FROM orders o join customer c using(cust_id);
	counter NUMBER;
BEGIN
	counter := 0;
	FOR record IN orders_cust LOOP
		IF record.cust_name=name AND record.order_date >= st_date AND record.order_date <= ed_date  THEN
			dbms_output.put_line('Order ID: ' || record.order_no);
			counter := counter + 1;
		END IF;
	END LOOP;

	IF counter = 0 THEN
		dbms_output.put_line('No records found!');
	ELSE
		dbms_output.put_line('No. of orders: ' || counter);
	END IF;
END order_range;
/

DECLARE
	name customer.cust_name%TYPE;
	st_date DATE;
	ed_date DATE;
BEGIN
	name := '&name';
	st_date := '&start_date';
	ed_date := '&end_date';
	order_range(name, st_date, ed_date);
END;
/

-- ****************************************************************************************
-- Q3 Display the customer name along with the details of pizza type and its quantity
--    ordered for the given order number. Also find the total quantity ordered for the given
--    order number as shown below:
-- ****************************************************************************************

CREATE OR REPLACE PROCEDURE order_details(
	oid orders.order_no%TYPE
) AS
	CURSOR or1 IS
		SELECT *
		FROM orders o join customer c using(cust_id);

	CURSOR or2 IS
		SELECT *
		FROM order_list join pizza using(pizza_id);
	found NUMBER := 0;
BEGIN
	FOR record1 in or1 LOOP
		IF record1.order_no = oid THEN
			dbms_output.put_line('Customer Name: ' || record1.cust_name);
			dbms_output.put_line('Ordered the Following Pizzas');
			dbms_output.put_line('PIZZA TYPE' || chr(9) || 'QTY');
			FOR record2 in or2 LOOP
				IF record2.order_no=record1.order_no THEN
					dbms_output.put_line(record2.pizza_type || chr(9) || chr(9) || record2.qty);
					found := found + record2.qty;
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	IF found = 0 THEN
		dbms_output.put_line('No Such order ID!');
	ELSE
		dbms_output.put_line('Total Quantity: ' || found);
	END IF;
END order_details;
/

DECLARE
	oid orders.order_no%TYPE;
BEGIN
	oid := '&oid';
	order_details(oid);
END;
/

-- ****************************************************************************************
-- Q4 Display the total number of orders that contains one pizza type, two pizza type 
--    and so on
-- ****************************************************************************************

CREATE OR REPLACE PROCEDURE different_types
AS
	counter NUMBER;
BEGIN
	FOR type_count IN 1..4 LOOP
		SELECT COUNT(*) INTO counter
		FROM (  SELECT order_no
			FROM order_list
			GROUP BY order_no
			HAVING COUNT(*) = type_count);

		dbms_output.put_line('Orders having ' || type_count || ' types: ' || counter);
	END LOOP;
END different_types;
/
BEGIN
	different_types();
END;
/

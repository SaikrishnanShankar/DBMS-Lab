--*****************************************************
--UCS1412                               B.Senthil Kumar
--Database Lab				Asst. Prof
--	    		    Computer Science Department
--            		     SSN College of Engineering 
--	                   	     senthil@ssn.edu.in
--*****************************************************
-- 	          PIZZA ORDERING DATASET
--                 Version 1.0
--                February 05, 2015
--*****************************************************
--Sources:
--         This dataset is prepared for the assignment
--	on DML, PL/SQL blocks in Database Programming.
--	This is a test dataset - pizza ordered on 28 & 29th Jun 2015.
--	Do NOT MODIFY the instances.
--
--******************************************************


REm customer(cust_id, cust_name, address, phone)
REM pizza (pizza_id, pizza_type, unit_price)
REM orders(order_no, cust_id, order_date ,delv_date, total_amt)
REM order_list(order_no, pizza_id, qty)


REM ------------------------------------------------------------------------------------------

REM customer(cust_id, cust_name,address,phone)

insert into customer values('c001','Hari','32 RING ROAD,ALWARPET',9001200031);
insert into customer values('c002','Ashok','42 bull ROAD,numgambakkam',9444120003);
insert into customer values('c003','Raj','12a RING ROAD,ALWARPET',9840112003);
insert into customer values('c004','Raghu','P.H ROAD,Annanagar',9845712993);
insert into customer values('c005','Sindhu','100 feet ROAD,vadapalani',9840166677);
insert into customer values('c006','Brinda','GST ROAD, TAMBARAM', 9876543210);



REM pizza (pizza_id, pizza_type, unit_price)

insert into pizza values('p001','pan',130);
insert into pizza values('p002','grilled',230);
insert into pizza values('p003','italian',200);
insert into pizza values('p004','spanish',260);

REM insert into pizza values('p005','supremo',250);



REM orders(order_no, cust_id, order_date ,delv_date)

insert into orders values('OP100','c001','28-JUN-2015','30-JUN-2015');
insert into orders values('OP200','c002','28-JUN-2015','30-JUN-2015');
insert into orders values('OP300','c003','29-JUN-2015','01-JUL-2015');
insert into orders values('OP400','c004','29-JUN-2015','01-JUL-2015');
insert into orders values('OP500','c001','29-JUN-2015','01-JUL-2015');
insert into orders values('OP600','c002','29-JUN-2015','01-JUL-2015');



REM order_list(order_no, pizza_id, qty)

insert into order_list values('OP100','p001',3);
insert into order_list values('OP100','p002',2);
insert into order_list values('OP100','p003',1);
insert into order_list values('OP100','p004',5);

insert into order_list values('OP200','p003',2);
insert into order_list values('OP200','p001',6);
insert into order_list values('OP200','p004',8);

insert into order_list values('OP300','p003',3);

insert into order_list values('OP400','p001',3);
insert into order_list values('OP400','p004',1);

insert into order_list values('OP500','p003',6);
insert into order_list values('OP500','p004',5);
insert into order_list values('OP500','p001',null);

insert into order_list values('OP600','p002',3);

--******************************************************

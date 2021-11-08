CREATE SCHEMA ecommerce;

USE ecommerce;

CREATE TABLE supplier (
	supp_id INT AUTO_INCREMENT PRIMARY KEY,
    supp_name VARCHAR(250),
    supp_city VARCHAR(50),
    supp_phone VARCHAR(20) );
    
 CREATE TABLE customer ( 
	cus_id INT AUTO_INCREMENT PRIMARY KEY,
    cus_name VARCHAR(250),
    cus_phone VARCHAR(20),
    cus_city VARCHAR(50),
    cus_gender VARCHAR(1) );
    
 CREATE TABLE category ( 
	cat_id INT PRIMARY KEY,
    cat_name VARCHAR(250) );
    
 CREATE TABLE product ( 
	pro_id INT PRIMARY KEY, 
    pro_name VARCHAR(50),
    pro_desc VARCHAR(250),
    cat_id INT, 
    FOREIGN KEY(cat_id) REFERENCES category(cat_id) );
    
 CREATE TABLE productdetails ( 
	prod_id INT PRIMARY KEY,
    pro_id INT,
    supp_id INT,
    price int,
    FOREIGN KEY(pro_id) REFERENCES product(pro_id),
    FOREIGN KEY(supp_id) REFERENCES supplier(supp_id) );
    
 CREATE TABLE orders ( 
	ord_id INT PRIMARY KEY, 
    ord_amount INT,
    ord_date date,
    cus_id INT,
    prod_id INT,
    FOREIGN KEY(CUS_ID) REFERENCES Customer(CUS_ID),
    FOREIGN KEY(PROD_ID) REFERENCES ProductDetails(PROD_ID) );
    
 CREATE TABLE rating (
	rat_id int primary key,
    cus_id int,
    supp_id int,
    rat_ratstars int,
    FOREIGN KEY(cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY(supp_id) REFERENCES supplier(supp_id));
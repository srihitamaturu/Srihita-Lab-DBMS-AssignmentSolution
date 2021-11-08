-- Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.

select * from customer c inner join `order` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000;

select cus_gender from customer c inner join `order` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000;

select COUNT(cus_gender) from (select cus_gender from customer c inner join `order` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000) as cg group by cus_gender;

select cg.cus_gender, COUNT(cus_gender) from (select cus_gender from customer c inner join `order` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000) as cg group by cus_gender;

select cus_gender,COUNT(cus_gender)  from customer c inner join `order` o on o.CUS_ID=c.CUS_ID where o.ORD_AMOUNT>=3000 group by cus_gender;


-- Display all the orders along with the product name ordered by a customer having Customer_Id=2.
select * from `order` where CUS_ID=2;

select * from `order` o inner join product p on o.PROD_ID=p.PRO_ID where o.CUS_ID=2;

select o.ORD_ID,o.ORD_AMOUNT,o.ORD_DATE,o.CUS_ID,o.PROD_ID,p.PRO_NAME from `order` o inner join product p on o.PROD_ID=p.PRO_ID where o.CUS_ID=2;

select o.ORD_ID,o.ORD_AMOUNT,o.ORD_DATE,o.CUS_ID,o.PROD_ID,p.PRO_NAME from `order` o inner join product p on (o.PROD_ID=p.PRO_ID and o.CUS_ID=2);

-- approach 2
select * from `order`;
select * from product_details;
select * from product;


select `order`.*,product.pro_name from `order` ,product_details,product where `order`.cus_id=2 and `order`.prod_id=product_details.prod_id and product_details.pro_id=product.pro_id;

-- Display the Supplier details who can supply more than one product.
select * from product_details;
select SUPP_ID, count(PROD_ID) from product_details GROUP by SUPP_ID;
select SUPP_ID, count(PROD_ID) as no_of_products from product_details GROUP by SUPP_ID;
select SUPP_ID from (select SUPP_ID, count(PROD_ID) as no_of_products from product_details GROUP by SUPP_ID) as pd where pd.no_of_products >=2;

select * from supplier where supp_id in (select supp_id from product_details group by supp_id having count(supp_id)>1);

select s.* from supplier s join (select supp_id, count(supp_id) from product_details group by supp_id having count(supp_id) > 1) as pd on pd.supp_id = s.supp_id;

-- Find the category of the product whose order amount is minimum.

select min(ORD_AMOUNT) from `order`;


Select c.cat_name, c.cat_id 
from category c inner join 
      (Select p.cat_id, opd.* from product p inner join 
            (Select pd.pro_id, om.* from product_details pd inner join 
                 (Select o.PROD_ID, min(o.ORD_AMOUNT) from `order-directory`.order o) as om on om.prod_id = pd.prod_id) as opd on opd.PRO_ID = p.pro_id) as popd on c.cat_id = popd.cat_id;

select * from category where cat_id in(select cat_id from product where pro_id 
in
( select pro_id from product_details P inner join `order` O on O.prod_id=P.prod_id where O.ORD_AMOUNT=(select min(ORD_AMOUNT) from `order`)));


select category.* from `order` inner join product_details on `order`.prod_id=product_details.prod_id inner join product on product.pro_id=product_details.pro_id inner join category on category.cat_id=product.cat_id where `order`.ORD_AMOUNT = (select min(ORD_AMOUNT) from `order`);

-- Display the Id and Name of the Product ordered after “2021-10-05”.

select * from `order` where ORD_DATE > '2021-10-05';



select b.pro_id,b.pro_name from product b inner join ( select a.PRO_ID from product_details as a inner join `order` as o on o.PROD_ID = a.PROD_ID where o.ORD_DATE > '2021-10-05') q on b.pro_id=q.pro_id;

select a.PRO_ID from product_details as a inner join `order` as o on o.PROD_ID = a.PROD_ID where o.ORD_DATE > '2021-10-05';

SELECT 
    p.PRO_ID, p.PRO_NAME
FROM
    `order` o
        INNER JOIN
    `product_details` prod ON o.prod_id = prod.prod_id
        INNER JOIN
    product p ON p.pro_id = prod.pro_id
WHERE
    o.ORD_DATE > '2021-10-05';

select product.PRO_ID, product.PRO_NAME from `order` INNER JOIN product_details on product_details.PROD_ID = `order`.PROD_ID inner join product on product.PRO_ID= product_details.PRO_ID WHERE `order`.ORD_DATE > '2021-10-05';

-- Print the top 3 supplier name and id and their rating on the basis of their rating along with the customer name who has given the rating.

select s.SUPP_ID. s.SUPP_NAME from supplier s inner join rating r on s.SUPP_ID = r.SUPP_ID;

select s.SUPP_ID, s.SUPP_NAME, r.RAT_RATSTARS from supplier s inner JOIN rating r on s.SUPP_ID = r.SUPP_ID order by r.RAT_RATSTARS desc limit 3;

select supplier.SUPP_ID, supplier.SUPP_NAME, customer.CUS_NAME, rating.RAT_RATSTARS from supplier inner JOIN rating on supplier.SUPP_ID=rating.SUPP_ID INNER JOIN customer on rating.CUS_ID = customer.CUS_ID order by rating.RAT_RATSTARS desc LIMIT 3;

-- Display customer name and gender whose names start or end with character 'A'.
select * from customer where CUS_NAME like 'A%' or CUS_NAME like '%A';

-- Display the total order amount of the male customers.
select sum(ord_amount) from `order` INNER join customer on `order`.CUS_ID= customer.CUS_ID where customer.CUS_GENDER='M';

select sum(ord_amount) from `order` INNER join customer on `order`.CUS_ID= customer.CUS_ID and customer.CUS_GENDER='M';

-- Display all the Customers left outer join with  the orders.
select * from customer left OUTER join `order` on customer.CUS_ID = `order`.CUS_ID;



-- Create a stored procedure to display the Rating for a Supplier if any along with the Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average Supplier” else “Supplier should not be considered”.

call supplierRatings();
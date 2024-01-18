create database Zomato_pro;

use Zomato_pro

CREATE TABLE goldusers_signup
userid integer,
gold_signup_date date; 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
VALUES (1,'2017-09-22'),
(3,'2017-04-20');

CREATE TABLE users(userid integer,signup_date date);

INSERT INTO users(userid,signup_date) 
VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
VALUES (1,'2017-09-04',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);

CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;



Q.1 What is the total amount each customer spent on zomato?  
SELECT a.userid,a.product_id,b.price from sales a inner join product b on a.product_id=b.product_id

#by groupby function  
SELECT a.userid,sum(b.price) from sales a inner join product b on a.product_id=b.product_id
group by a.userid

Q.2 How many days has each customer visited zomato?
SELECT userid,count(distinct created_date) distinct_days from sales group by userid;
 
Q.3 What was the first product purchased by each customer? 

SELECT * from
(SELECT *,rank() over(partition by userid order by created_date) rnk from sales) a where rnk =1

Q.4 What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT userid,count(product_id) cnt from sales where product_id =
(SELECT product_id from sales group by product_id order by count(product_id) desc limit 1) 
group by userid

Q.5 Which item was most popular for each customer?
SELECT * from
(select *,rank() over(partition by userid order by cnt desc) rnk from
(SELECT userid,product_id,count(product_id) cnt from sales group by userid,product_id)a)b
where rnk = 1 



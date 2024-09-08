-- Database creation 

create database mossa_pizza;
use mossa_pizza;

/* Tables imported from csv files into mossa_pissa database
1. order_details.csv  2. orders.csv  3.pizzas.csv  4.pizza_types.csv */

-- explore each table
desc order_details;
desc orders;
desc pizza_types;
desc pizzas;

select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

-- Analyse the data

-- 1. Retrieve the total number of orders placed.
select count(distinct order_id) as 'Total Orders' from orders;

-- 2. Calculate the total revenue generated from pizza sales.

-- to see the details
select order_details.pizza_id, order_details.quantity, pizzas.price
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id;

-- to get the answer
select cast(sum(order_details.quantity * pizzas.price) as decimal(10,2)) as 'Total Revenue'
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id;


-- 3. Top 5 Pizza's in sales

select pizza_types.name, sum(order_details.quantity*pizzas.price) as 'Total sales' 
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name
 order by sum(order_details.quantity*pizzas.price) DESC limit 5;

-- 4. List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name as 'Pizza', sum(quantity) as 'Total Ordered'
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name 
order by sum(quantity) desc limit 5;

-- 5. Determine the distribution of orders by hour of the day.

select hour(time) as 'Hour of the day', count(distinct order_id) as 'No of Orders'
from orders
group by hour(time) 
order by count(distinct order_id) desc;
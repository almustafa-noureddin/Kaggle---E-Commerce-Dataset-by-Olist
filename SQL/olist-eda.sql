/*
 simple expolatory data analysis 
  */


-- first glance at the tables
select * from products limit 5;
select * from orders limit 5;
select * from order_items limit 5;
select * from order_payments limit 5;
select * from order_reviews limit 5;
select * from customers limit 5;
select * from geolocations limit 5;
select * from sellers limit 5;
-- number of orders
select count(*) from orders;
-- 
-- transforming order_estimated_delivery_date from the order table, from timestamp datatype to date
alter table orders add order_estimated_delivery_date_converted date;
SELECT DATE(order_estimated_delivery_date) FROM orders;
update orders set order_estimated_delivery_date_converted=DATE(order_estimated_delivery_date);
select order_estimated_delivery_date_converted from orders;
ALTER TABLE orders DROP COLUMN order_estimated_delivery_date;
-- what period of time does this data cover?
select min(date(order_purchase_timestamp)) as start,max(date(order_purchase_timestamp)) as end from orders;

/*
 -- average delivery time
 
 */

select (order_delivered_customer_date-order_purchase_timestamp) as delivery_time from orders where order_delivered_customer_date IS NOT NULL;
-- longest delivery time
select max(order_delivered_customer_date-order_purchase_timestamp) as delivery_time from orders where order_delivered_customer_date IS NOT NULL;
-- shortest delivery time
select min(order_delivered_customer_date-order_purchase_timestamp) as delivery_time from orders where order_delivered_customer_date IS NOT NULL;
-- average delivery time
select avg(order_delivered_customer_date-order_purchase_timestamp) as delivery_time from orders where order_delivered_customer_date IS NOT NULL;

/*
 -- to see if the estimated delivery date is accurate
 */

-- difference between order_estimated_delivery_date_convered and order_delvered_customer_date
-- positive means the order is delivered before the estimated date of delivery 
select (order_estimated_delivery_date_converted - date(order_delivered_customer_date)) as delivery_time from orders where order_delivered_customer_date IS NOT null;
-- the earliest order to be delivered before the estimated delivery date
select max(order_estimated_delivery_date_converted - date(order_delivered_customer_date)) as delivery_time from orders where order_delivered_customer_date IS NOT null;
-- longest delay from the estimated delivery date
select min(order_estimated_delivery_date_converted - date(order_delivered_customer_date)) as delivery_time from orders where order_delivered_customer_date IS NOT null;
-- the average difference between order_estimated_delivery_date_convered and order_delvered_customer_date
select avg(order_estimated_delivery_date_converted - date(order_delivered_customer_date)) as delivery_time from orders where order_delivered_customer_date IS NOT null;

/*
 -- volume and distance vs freight_cost
 */
-- volume vs freight_cost irrespecive to the distance
select pcnt.product_category_name_english,(p.product_length_cm*p.product_height_cm*p.product_width_cm) as volume_in_cm3 ,p.product_weight_g,oi.freight_value from orders o
 join order_items oi on o.order_id=oi.order_id
 join sellers s on oi.seller_id =s.seller_id 
 join products p on oi.product_id =p.product_id
 join customers c on o.customer_id =c.customer_id 
 join product_category_name_translation pcnt on p.product_category_name =pcnt.product_category_name order by oi.freight_value desc;
/*
-- convert column types to numeric to calculate disances using earthdistance extension
ALTER TABLE geolocations ALTER COLUMN lat TYPE numeric USING NULLIF(lat, '')::numeric;
ALTER TABLE geolocations ALTER COLUMN lan TYPE numeric USING NULLIF(lan, '')::numeric;
-- add extensions to calculate distances
create extension cube;
create extension earthdistance;
-- create new column to hold geographical points created by compining latitude and longitude
alter table geolocations add location_point point;
update geolocations set location_point = point(lan,lat);
-- an attempt to calculate freight cost based on both distance and volume
-- there is a problem with joining geolocations table, no shared column to join on 
select pcnt.product_category_name_english,(p.product_length_cm*p.product_height_cm*p.product_width_cm) as volume_in_cm3 ,p.product_weight_g,oi.freight_value,
 ((select g.location_point from geolocations g where c.customer_zip_code_prefix = g.zip_code_prefix limit 1 ) <@>
  (select g.location_point from geolocations g where s.seller_zip_code_prefix= g.zip_code_prefix limit 1)) as distance_miles
 from orders o
 join order_items oi on o.order_id=oi.order_id
 join sellers s on oi.seller_id =s.seller_id 
 join products p on oi.product_id =p.product_id
 join customers c on o.customer_id =c.customer_id 
 join geolocations g on g.zip_code_prefix =c.customer_zip_code_prefix 
 join product_category_name_translation pcnt on p.product_category_name =pcnt.product_category_name ; 
 */
 
 
 
  



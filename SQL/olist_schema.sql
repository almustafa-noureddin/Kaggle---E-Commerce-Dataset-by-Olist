-- create new database
create database olist;
-- creating tables
create table geolocations(geolocations_table_id serial,zip_code_prefix int,lat text, lan text, city text, state text);
create table customers(customers_table_id serial,customer_id text,customer_unique_id text,customer_zip_code_prefix int, customer_city text, customer_state text);
create table order_items(order_items_table_id serial,order_id text,order_item_id int,product_id text,seller_id text,shipping_limit_date timestamp,price money, freight_value money);
create table order_payments(order_payments_table_id serial,order_id text,payment_sequential int,payments_type text,payment_installments int,payment_value money);
create table order_reviews(order_reviews_table_id serial,review_id text,order_id text,review_score int, review_comment_title text,review_comment_message text);
create table orders(orders_table_id serial,order_id text,customer_id text,order_status text,order_purchase_timestamp timestamp,order_approved_at timestamp,order_delivered_carrier_date timestamp,order_delivered_customer_date timestamp,order_estimated_delivery_date timestamp);
create table products(products_table_id serial,product_id text,product_category_name text,product_name_length int, product_description_length_cm int, product_photos_qty int,product_weight_g bigint,product_length_cm bigint,product_height_cm bigint,product_width_cm bigint);
create table sellers(sellers_table_id serial,seller_id text,seller_zip_code_prefix int,seller_city text,seller_state text);
create table product_category_name_translation(product_category_name_translation_table_id serial,product_category_name text,product_category_name_english text);
-- importing data
--/copy mytable from 'xxx.csv' delimiter ',' csv header;
/copy geolocations from '/USERS/AlMustafa/Desktop/olist_dataset/olist_geolocation_dataset.csv' delimiter ',' csv header;
/copy customers from '/USERS/AlMustafa/Desktop/olist_dataset/olist_customers_dataset.csv' delimiter ',' csv header;
/copy order_items from '/USERS/AlMustafa/Desktop/olist_dataset/olist_order_items_dataset.csv' delimiter ',' csv header;
/copy order_payments from '/USERS/AlMustafa/Desktop/olist_dataset/olist_order_payments_dataset.csv' delimiter ',' csv header;
/copy order_reviews from '/USERS/AlMustafa/Desktop/olist_dataset/olist_order_reviews_dataset.csv' delimiter ',' csv header;
/copy orders from '/USERS/AlMustafa/Desktop/olist_dataset/olist_orders_dataset.csv' delimiter ',' csv header;
/copy products from '/USERS/AlMustafa/Desktop/olist_dataset/olist_products_dataset.csv' delimiter ',' csv header;
/copy sellers from '/USERS/AlMustafa/Desktop/olist_dataset/olist_sellers_dataset.csv' delimiter ',' csv header;
/copy product_category_name_translation from '/USERS/AlMustafa/Desktop/olist_dataset/product_category_name_translation.csv' delimiter ',' csv header;



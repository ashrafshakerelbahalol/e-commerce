create table Category (
category_name varchar(255) unique not null ,
categoty_id  int Primary key
);
create table Product (
product_id Bigint Primary key,
price float not null ,
description  varchar(255) not null,
name varchar(50) not null,
category_id int not null,
Foreign key (category_id) references Category(categoty_id)
);
create table customer (
customer_id bigint primary key,
first_name varchar(50) not null,
last_name varchar (50) not null,
password  varchar (255)not null,
email varchar(100) unique not null
);
create table order_products (
order_id bigint primary key,
total_amount double ,
order_date timestamp default current_timestamp ,
customer_id bigint not null ,
foreign key (customer_id) references customer(customer_id)
);
create table order_detials(
order_id bigint not null,
product_id Bigint not null,
order_detials_id bigint primary key,
quantity int not null ,
unit_price double not null,
Foreign key (order_id) references order_products(order_id),
Foreign key (product_id) references Product(product_id)
);

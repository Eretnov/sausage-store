--V001__create_tables.sql 

CREATE TABLE product (
    id bigint generated by default as identity,
    name varchar(255) not null,
    picture_url varchar(255),
    price double precision
);

CREATE TABLE orders (
    id bigint generated by default as identity,
    status varchar(255),
    date_created date default current_date
);

CREATE TABLE order_product (
    quantity integer not null,
    order_id bigint not null,
    product_id bigint not null
);

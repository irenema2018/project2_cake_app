select pg_terminate_backend(pid)
from pg_stat_activity
where datname='mini_cake_web_app'
and pid!=pg_backend_pid();

drop database mini_cake_web_app;

create database mini_cake_web_app;

\c mini_cake_web_app;

create table cake_types(
  id            serial primary key,
  cake_type     varchar(128),
  image_url     text
);

insert into cake_types (cake_type,image_url)
values('Buttercream','https://i.imgur.com/rKopx1O.jpg?1')
,('Beanpaste','https://i.imgur.com/lt8leDT.jpg?1')
,('Cupcake','https://i.imgur.com/4ubtb12.jpg');

create table cakes(
  id            serial primary key,
  cake_type     varchar(128),
  title         varchar(128),
  price         decimal(10, 2),
  image_url     text
);

insert into cakes (cake_type,title,price,image_url)
values
 ('Buttercream','Lily',70,'https://i.imgur.com/PqR3MKu.jpg?1')
,('Buttercream','Big Rose',70,'https://i.imgur.com/RWfeyHx.jpg')
,('Buttercream','Galaxy Rose',75,'https://i.imgur.com/YAZkUZj.jpg')
,('Buttercream','Pig',65,'https://i.imgur.com/vUpvBmP.jpg?1')
,('Beanpaste','Cherry Blossom',65,'https://i.imgur.com/kSFanEZ.jpg')
,('Beanpaste','Rainbow',80,'https://i.imgur.com/Q5AVvvS.jpg?1')
,('Beanpaste','Peony',70,'https://i.imgur.com/qxaIfom.jpg')
,('Beanpaste','Chrysanthemum',75,'https://i.imgur.com/bGlmQOw.jpg')
,('Cupcake','Assorted_1 x 6',60,'https://i.imgur.com/4ubtb12.jpg')
,('Cupcake','Assorted_2 x 6',60,'https://i.imgur.com/XaI427W.jpg')
,('Cupcake','Unicorn x 6',48,'https://i.imgur.com/mNRqNhq.jpg')
;


create table customers(
  id                serial primary key,
  name              text,
  email             varchar(500),
  password_digest   varchar(500)
);

create table orders(
  id                serial primary key,
  pickup_date       date,
  total_price       decimal(10,2),
  cake_id           integer,
  quantity          integer,
  customer_id       integer
);

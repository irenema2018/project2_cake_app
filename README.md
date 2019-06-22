# project2_cake_app

## [Cake App Link](http://mighty-oasis-52079.herokuapp.com/)

# Introduction
A database driven web application was created for the project. It simulates an online cake shop (featuring cakes made by me). The pages are designed with the principle of simplicity in mind. The workflow is intended to make it easy for users to browse products and place orders.

The web app handles two types of customers. A GUEST customer can place orders and choose to become a MEMBER. A MEMBER customer can log in and review orders.

## Sinatra
1. Use get and post route handlers.
2. Use the sessions object for storing customer id.

## PostgreSQL
Create 4 tables for storing information.
   
   |Table|Columns|
   |---|---|
   |cake_types| id, cake types, image links|
   |cakes| the information of a single cake: id, title, price, image link|
   |customers| id, customer name, email, password|
   |orders| id, pickup date, total price, quantity, cake id, customer id|

## HTML 
Use erb files to render HTML

## CSS
Use flexbox

## JavaScript
Create a simple alert box for order confirmation. 

## Things that can be improved
1. The pickup date validation is required so it is in the future.
2. The customer sign up process can be improved to make it more realistic.
3. A real payment page would be good.

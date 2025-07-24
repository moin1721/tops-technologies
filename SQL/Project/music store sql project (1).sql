create database music ;

use music ;

	create table employee (
	id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	title varchar (50),
	reports_to int ,
	levels char(5),
	birthdate date,
	hire_date date,
	address varchar(65),
	city varchar(25),
	satate varchar(25),
	country varchar(25),
	postal_code char(20),
	phone char(25),
	fax char(25),
	email VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT email_format CHECK (email LIKE '%_@__%.__%') 
	) ;


	select * from employee ;




	LOAD DATA LOCAL INFILE 'C:/Users/chaud/OneDrive/Documents/music store data/employees.csv'
	INTO TABLE employee
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

	SET GLOBAL local_infile=1 ;
	SHOW VARIABLES LIKE 'local_infile';

	drop table customer ;


	create table customer (
	customer_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	company varchar(15),
	address varchar(70),
	city varchar(20),
	state varchar(15),
	country varchar(15),
	postal_code varchar(20),
	phone varchar(25),
	fax varchar(25),
	email VARCHAR(255) NOT NULL UNIQUE,
	support_rep_id int,
	foreign key (support_rep_id) references employee(id),
	CONSTRAINT email CHECK (email LIKE '%_@__%.__%') 
	);

	select * from customer ;

	create table invoice (
	invoice_id int primary key,
	customer_id int ,
	invoice_date date,
	billing_address varchar(70),
	billing_city varchar(25),
	billing_state varchar(20),
	billing_country varchar(10),
	billing_postal_code varchar(15),
	total int ,
	foreign key (customer_id) references customer(customer_id)
	);

	select * from invoice ;

	create table invoice_line (
	invoice_line_id int primary key,
	invoice_id int,
	track_id int ,
	unit_price int,
	quantity int,
	foreign key (invoice_id) references invoice(invoice_id),
	foreign key (track_id) references track(track_id)
	);

	select * from invoice_line ;

	create table track (
	track_id int primary key,
	name varchar(25),
	album_id int,
	media_type_id int,
	genre_id int,
	composer varchar(50),
	milliseconds int ,
	bytes int,
	unit_price int ,
	foreign key (album_id) references album(album_id),
	foreign key (media_type_id) references media_type(media_type_id),
	foreign key (genre_id) references genre(genre_id)
	);

	select * from track ;

	create table album(
	album_id int primary key,
	title varchar(70),
	artist_id int,
	foreign key (artist_id) references artist(artist_id)
	);

	create table album1(
	album_id int primary key,
	title varchar(150),
	artist_id int);

	drop table album1 ;
	select * from album ;

	create table artist (
	artist_id int primary key,
	name varchar (25)
	);

	select * from artist ;

	create table media_type (
	media_type_id int primary key,
	name varchar(25)
	);

	select * from media_type ;

	create table genre (
	genre_id int primary key,
	name varchar(25)
	);

	select * from genre ;

	create table playlist_track (
	playlist_track_id int ,
	track_id int,
	foreign key (track_id) references track(track_id),
	foreign key (playlist_track_id) references playlist(playlist_id)
	);

	drop table playlist_track  ;
	select * from  playlist_track ;

	create table playlist (
	playlist_id int primary key,
	name varchar(25)
	);

	select * from playlist ;



-- total album
select count(*)
from album ;

-- total artist
select count(*)
from artist ;

-- total playlist
select count(*)
from playlist ;

-- total customer
select count(*)
from customer ;

-- total employee
select *
from employee ;

--  Question Set 1 - Easy 

--  Q1: Who is the senior most employee based on job title?
select 
	   title,
       first_name,
       last_name
       levels
from employee

order by levels desc 
limit 1 ;

-- Q2: Which countries have the most Invoices?
SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC ;

-- Q3: What are top 3 values of total invoice?
select * 
from invoice 
order by total desc 
limit 3 ;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
 Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals */
 select * from invoice ;
 select sum(total) as totalinvoice,
        billing_city
 from invoice 
 group by billing_city
 order by totalinvoice desc
 
 ;
 

-- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.
select i.customer_id,
       c.first_name,
       c.last_name,
      sum( i.total) as total_money
from invoice i
join customer c on i.customer_id = c.customer_id
GROUP BY i.customer_id
order by total_money  desc
;
select * from track ;
-- Question Set 2 - Moderate --

--  Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A.
select * from genre ;
select * from customer;
select c.email,
       c.first_name,
       c.last_name,
       g.name
from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id 
join genre g on t.genre_id = g.genre_id 
where g.name = 'Rock'
order by c.email asc;

-- Q2: Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.
select a.name as artidt_name,
       count(t.track_id) as total_tracks
from artist a
join album al on a.artist_id = al.artist_id
join track t on al.album_id = t.album_id 
join genre g on t.genre_id = g.genre_id 
where g.name = 'rock'
group by a.artist_id
order by total_tracks desc
limit 10
;

--  Q3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
select * from track ;
SELECT t.name AS track_name, 
       t.milliseconds
FROM track t
WHERE t.milliseconds > (SELECT AVG(t2.milliseconds) FROM track t2)
ORDER BY t.milliseconds DESC;

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */
select * from customer;
select * from artist;
select * from customer;
select 
       c.first_name AS customer_first_name,
       c.last_name AS customer_last_name,
       a.name AS artist_name,
       SUM(il.unit_price * il.quantity) AS total_spent
       /*c.customer_id,
	   c.first_name,
       c.last_name,
       sum(il.unit_price * il.quantity) as total */
from invoice i
join customer c on i.customer_id = c.customer_id
join invoice_line il on i.invoice_id = il.invoice_id 
JOIN track t ON il.track_id = t.track_id
JOIN album al ON t.album_id = al.album_id
JOIN artist a ON al.artist_id = a.artist_id
GROUP BY c.customer_id, a.artist_id
order by total_spent desc;

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */
WITH GenrePurchases AS (
    SELECT c.country,
           g.name AS genre_name,
           SUM(il.unit_price * il.quantity) AS total_spent
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),
MaxGenrePurchases AS (
    SELECT country,
           MAX(total_spent) AS max_spent
    FROM GenrePurchases
    GROUP BY country
)
SELECT gp.country, gp.genre_name
FROM GenrePurchases gp
JOIN MaxGenrePurchases mgp ON gp.country = mgp.country
WHERE gp.total_spent = mgp.max_spent
ORDER BY gp.country, gp.genre_name;

/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH CustomerSpending AS (
    SELECT c.country,
           c.customer_id,
           c.first_name,
           c.last_name,
           SUM(il.unit_price * il.quantity) AS total_spent
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    GROUP BY c.country, c.customer_id
),
MaxSpendingPerCountry AS (
    SELECT country,
           MAX(total_spent) AS max_spent
    FROM CustomerSpending
    GROUP BY country
)
SELECT cs.country,
       cs.first_name AS customer_first_name,
       cs.last_name AS customer_last_name,
       cs.total_spent
FROM CustomerSpending cs
JOIN MaxSpendingPerCountry mspc ON cs.country = mspc.country
WHERE cs.total_spent = mspc.max_spent
ORDER BY cs.country, cs.total_spent DESC, cs.last_name, cs.first_name;


/*In this project, we designed and queried a music store database to analyze customer behavior, sales trends, and product popularity. 
Through SQL queries, we explored total records, identified top customers, and calculated various metrics, such as the most popular 
genres and the cities with the highest sales. The project showcased the power of relational databases, 
using techniques like normalization, aggregation, and subqueries for efficient data analysis. */

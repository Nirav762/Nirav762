-- Q1: Who is the senior most employee based on job title? 
select first_name, last_name, levels from employee 
order by levels desc limit 5



select* from invoice
select count(*) as c, billing_country from invoice 
group by billing_country 
order by c desc limit 5


--Q3: What are top 3 values of total invoice?

select total from invoice 
order by total desc limit 5 

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. 
--Return both the city name & sum of all invoice totals 



select billing_city, sum(total) as invoice_total from invoice 
group by billing_city
order by  invoice_total desc



-- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.



select* from customer
select * from invoice 
select distinct first_name, last_name, email, sum(total) as total_spend from customer 
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id 
order by total_spend desc limit 5



-- Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A.


select distinct first_name, last_name, email from customer 
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice_line.invoice_id=invoice.invoice_id
where track_id in(
	select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name like 'Rock')
	order by email desc limit 5 


 --Q2: Let's invite the artists who have written the most rock music in our dataset. 
---Write a query that returns the Artist name and total track count of the top 10 rock bands.



select name, milliseconds 
from track 
where milliseconds >(select avg(milliseconds) as avg_milli from track )
order by milliseconds desc


--Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A.

select distinct email as Email, first_name, last_name, genre.name from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on invoice_line.track_id=track.track_id
join genre on track.genre_id=genre.genre_id
where genre.name like 'Rock'
order by email;


--Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands



select artist.artist_id, artist.name,count(artist.artist_id)as number_of_songs from track
join album on album.album_id= track.album_id
join artist on artist.artist_id=album.artist_id
join genre on genre.genre_id=track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

-- Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. 


select name.artist,name,milliseconds from 
track 
where milliseconds>(select avg(milliseconds) as avg_milliseconds from track)
order by milliseconds 




-- Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent?
 with best_selling_artist as(
	 select artist.artist_id as artist_id,artist.name as artist_name, sum(invoice_line.unit_price*invoice_line.quantity) as 
	 total_sales from invoice_line
	  join track on track.track_id=invoice_line.track_id
	  join album on album.album_id=track.album_id
	  join artist on artist.artist_id=album.artist_id
	  group by 1 
	 order by 3 desc limit 3
)
select c.customer_id,c.first_name,c.last_name,bsa.artist_name, sum(il.unit_price*il.quantity) as 
	 amount_spend from invoice i
join customer c on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
join track t on t.track_id=il.track_id
join album alb on alb.album_id=t.album_id
join best_selling_artist bsa on bsa.artist_id=alb.artist_id
group by 1,2,3,4
order by 5 desc 

















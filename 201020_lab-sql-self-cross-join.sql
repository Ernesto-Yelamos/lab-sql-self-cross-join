# Lab | SQL Self and cross join
#In this lab, you will be using the Sakila database of movie rentals.
use sakila;
set sql_safe_updates=0;

### Instructions
	-- 1. Get all pairs of actors that worked together.
select * from sakila.film_actor;
select * from sakila.actor;

select a.actor_id, b.actor_id from sakila.film_actor as a
join sakila.film_actor as b on b.film_id = a.film_id and a.actor_id <> b.actor_id
group by a.actor_id, b.actor_id;

select fa1.film_id, concat(a1.first_name, ' ', a1.last_name) as 'actor 1', concat(a2.first_name, ' ', a2.last_name) as 'actor 2' from sakila.actor as a1
join sakila.film_actor as fa1 on a1.actor_id = fa1.actor_id
join sakila.film_actor as fa2 on (fa1.film_id = fa2.film_id) and (fa1.actor_id <> fa2.actor_id)
join sakila.actor as a2 on a2.actor_id = fa2.actor_id;


	-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select r.customer_id, c.first_name, c.last_name, i.film_id, count(i.film_id) as 'Count films' from sakila.rental as r
join sakila.inventory as i on i.inventory_id = r.inventory_id
join sakila.customer as c on r.customer_id = c.customer_id
group by i.film_id, r.customer_id
having count(i.film_id) >= 3;


select r1.customer_id as 'Customer 1', r2.customer_id as 'Customer 2', count(*) from sakila.rental as r1
join sakila.inventory as i1 on r1.inventory_id = i1.inventory_id
join sakila.inventory as i2 on i1.film_id = i2.film_id
join sakila.rental as r2 on i2.inventory_id = r2.inventory_id
where r1.customer_id <> r2.customer_id
group by r1.customer_id, r2.customer_id
having count(*) >= 3
order by count(*) desc;

	-- 3. Get all possible pairs of actors and films.
select a3.first_name, a3.last_name, a2.title from sakila.film_actor as a1
join sakila.film as a2 on a1.film_id = a2.film_id
join sakila.actor as a3 on a1.actor_id = a3.actor_id
order by a3.first_name;
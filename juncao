use dvdrental

select c.first_name, c.last_name, a.address, y.city, p.country
from customer c
	inner join address a on c.address_id = a.address_id
	inner join city y on a.city_id = y.city_id
	inner join country p on y.country_id = p.country_id
order by c.first_name

--existe algum pais que nao tenho clientes?

select  p.country , c.first_name, a.address_id, y.city_id from country p
	left join city y on p.country_id = y.country_id
	left join address a on y.city_id=a.city_id
	left join customer c on a.address_id = c.address_id
--where c.customer_id is null
order by p.country

--existe algum pais que nao tenho clientes?
SELECT p.country 
FROM country p
WHERE NOT EXISTS (
    SELECT 1 
    FROM city y
    left JOIN address a ON y.city_id = a.city_id
    left JOIN customer c ON a.address_id = c.address_id
    WHERE y.country_id = p.country_id
)
ORDER BY p.country;

select p.country from country p
where p.country_id not in(
	select p1.country_id
	from customer c
	inner join address a on c.address_id = a.address_id
	inner join city y1 on y1.city_id = a.city_id
	inner join country p1 on y1.country_id = p1.country_id
)
order by p.country


--top
select distinct p.country
from customer c
	inner join address a on c.address_id = a.address_id
	inner join city y1 on y1.city_id = a.city_id
	inner join country p1 on y1.country_id = p1.country_id
	right join country p on p1.country_id = p.country_id
where c.customer_id is null
order by p.country

SELECT DISTINCT 
    p.country
FROM country p
LEFT JOIN city y ON p.country_id = y.country_id
LEFT JOIN address a ON y.city_id = a.city_id
LEFT JOIN customer c ON a.address_id = c.address_id
WHERE c.customer_id IS NULL
ORDER BY p.country;

select country from country order by country

insert into country (country) values ('Vaticano'), ('Monaco')

select * from store
select * from staff

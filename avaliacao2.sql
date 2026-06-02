--a) mostre o número de clientes distintos (customer) por cidade (city). (10)
select count(distinct c.customer_id) qtd_cli, cy.city from customer c
inner join address a on a.address_id = c.address_id
inner join city cy on cy.city_id = a.city_id
group by cy.city
order by qtd_cli


--b) considerando que filmes abaixo de 65 minutos sejam considerados como de curta duração, mostre quantos filmes são de curtaduração. (10)
select count(*) filmes_curta_duracao
from film
where film.length < 65


--c) liste o título (title), a duração (length), a classificação (rating) e o ano (release_yar) dos filmes cujo rating começa com ‘pg’
--em ordem alfabética de duração e título. (10)
select f.title, f.length, f.rating, f.release_year
from film f
where f.rating like 'pg%'
order by f.length, f.title


--d) liste o nome completo dos clientes (customer) e o endereço de e-mail, o título do filme locado e as características especiais
--(special_features), apenas dos filmes com as características especiais ‘deleted scenes’ ou ‘behind the scenes’ em ordem
--alfabética. (10)
select concat(c.first_name,' ', c.last_name) full_name,
        c.email, f.title, f.special_features
from customer c
inner join rental r on r.customer_id = c.customer_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
where f.special_features like '%deleted scenes%'
        or f.special_features like '%behind the scenes%'
order by full_name


--e) conte quantos filmes contém as características do item d por rating. (10)
select count(*) qtd_filmes, f.rating from film f
where f.special_features like '%deleted scenes%'
        or f.special_features like '%behind the scenes%'
group by f.rating
order by f.rating


--f) em uma consulta, mostre a soma e a média de faturamento (amount) por filme em ordem alfabética do título. (10)
select sum(p.amount) total, avg(p.amount) media, f.title
from payment p
inner join rental r on r.rental_id = p.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
group by f.title
order by f.title


--g) em outra consulta mostre a quantidade e o total faturado (amount) das locações feitas após as 22 horas. (10)
select count(p.payment_id) qtd_pagamentos, sum(p.amount) total
from payment p
inner join rental r on r.rental_id = p.rental_id
where convert(time, r.rental_date) > convert(time, smalldatetimefromparts (2000, 01, 01, 22, 0))
--fonte ^^ https://learn.microsoft.com/en-us/sql/t-sql/functions/smalldatetimefromparts-transact-sql?view=sql-server-ver17


--h) mostre o total e a média de faturamento (amount) por hora do dia. (10) 
select sum(p.amount) total, avg(p.amount) media,
datepart(hour, p.payment_date) hora_pagamento
from payment p
group by datepart(hour, p.payment_date)
order by hora_pagamento


--i) faça uma consulta que retorne o nome completo dos clientes (customer), o fone, o email, o endereço (address, address2), o
--distrito (district), o código postal, a cidade e o país, que locaram filmes entre os dias 26 e 27 de maio de 2005 e que moram nos
--países da américa do norte em ordem de nome. (10)
select concat(c.first_name, ' ', c.last_name) nome_completo, a.phone,
        c.email, a.address, a.address2, a.district, a.postal_code, ct.city, co.country
from customer c
inner join address a on a.address_id = c.address_id
inner join city ct on ct.city_id = a.city_id
inner join country co on co.country_id = ct.country_id
inner join rental r on r.customer_id = c.customer_id
inner join inventory i on i.inventory_id = r.inventory_id
where (r.rental_date between '2005-05-26' and '2005-05-28') and (co.country in('mexico','canada', 'united states'))
order by nome_completo


--j) mostre o nome das 3 categorias de filmes mais alugadas em ordem alfabética. (10)
select top 3 c.name
from film f
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
group by c.name
order by count(r.rental_id) desc, c.name
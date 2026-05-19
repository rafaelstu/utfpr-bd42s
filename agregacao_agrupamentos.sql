--funcoes de agregacao e agrupamentos

--funcoes de agregacao funcoes estatisticas
--count(*), count(coluna)

--sobre dados numericos
-- sum (coluna) soma
-- avg (coluna) media aritmetica
-- max (coluna) maior vlaor
-- min (coluna) menor valor

--calcular o total de locacoes recebidas

select s.staff_id, s.first_name, s.last_name,
	sum(amount) total_geral, avg(amount) media,
	max(amount) maior, min(amount) menor
from payment p
inner join staff s on s.staff_id = p.staff_id
group by s.staff_id, s.first_name, s.last_name


select count(*) contagem_total,
	count(address2) contagem_nao_nula
from address

select count(*) contagem_geral,
	count(language_id) idiomas,
	count(distinct language_id) idiomas_unicos
from film


select count( distinct country_id) numero_paises
from city

--total faturado por cliente

select c.customer_id, c.first_name, c.last_name, sum(p.amount) total
from customer c
	inner join rental r on r.customer_id = c.customer_id
	inner join payment p on p.rental_id = r.rental_id
group by c.customer_id, c.first_name, c.last_name
order by c.first_name, c.last_name

--top 10 clientes em valor de faturamento

select top 10 c.customer_id, c.first_name,
	c.last_name, sum(p.amount) total
from customer c
	inner join rental r on r.customer_id = c.customer_id
	inner join payment p on p.rental_id = r.rental_id
group by c.customer_id, c.first_name, c.last_name
order by total desc

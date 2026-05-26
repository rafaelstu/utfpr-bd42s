--Relação contendo title, length e rating dos filmes (film) em ordem alfabética de título.
select f.title, f.length, f.rating from film f
order by f.title asc
  
-- Relação de filmes (film), contendo todos os atributos, que foram lançados entre 2006 e 2009 (release_year).
select * from film f
where f.release_year between 2006 and 2009
  
-- Relação de categorias (category) em ordem alfabética.
select * from category order by name
  
-- Relação de clientes (customer) contendo o primeiro nome, último nome e email de todos os clientes inativos. Dica: Active = 0;
select c.first_name, c.last_name, c.email
from customer c
where c.active = 0
  
-- Relação dos filmes (title, rating, release_year) da categoria (Sci-Fi). Dica: faça uma consulta à tabela de categorias e localize o código da categoria Sci-Fi para resolver o exercício.
select f.title, f.rating, f.release_year
from film f
  inner join film_category fc no f.film_id = fc.film_id
where fc.category_id = 14

-- Listar os atores em ordem de sobrenome (last_name).
select * from actor
order by last_name

-- Relação dos pagamentos (payment), com todos os atributos, que foram realizados entre '2007-02-01' e '2007-02-15'
select * from payment p
where p.payment_date between '2007-02-01' and '2007-02-16'
order by p.payment_date

-- Relação dos clientes (customer_id, first_name, last_name, active) em ordem de sobrenome + nome.
select c.customer_id, c.first_name, c.last_name, c.active
from customer c
order by c.last_name, c.first_name

-- Relação de cidades em ordem alfabética.
select * from city
order by city

-- Relação de atores em ordem de nome cujos sobrenomes comecem com 'Kil%'. Pesquise sobre a clásula LIKE do tsql para resolver o exercício.
select * from actor
where last_name like 'kil%'
order by first_name


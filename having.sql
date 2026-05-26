select a.actor_id,
  concat(a.first_name, ' ', a.last_name) nome_completo,
  count(*) num_filmes
from actor a
  inner join film_actior fa on a.actor_id = fa.actor_id
group by a.actor_id, concat(a.first_name, ' ', a.last_name)
having count(*)>30
order by num_filmes desc, nome_completo

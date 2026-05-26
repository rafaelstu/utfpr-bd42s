--a
select * from bancos b
  inner join agencias a on a.cod_banco = b.cod_banco
  inner join cidades c on c.cod_cidade = a.cod_cidade
  inner join estados e on e.cod_estado = a.cod_estado
where e.nome = 'PR'

--b
select c.nome, t.ddd, t.numero
from clientes c
  inner join telefones t on t.cpf = c.cpf
order c.nome

--c
select *
from emprestimos e
where quantia > 1000

--d
select *
from contas c
  inner join tipos t on c.cod_tipo = t.cod_tipo

--e
select c.*
from contas c
  inner join tipos t on c.cod_tipo = t.cod_tipo
where t.nome = 'Poupança' and c.saldo > 10000

--f
select c.*
from clientes c
  inner join cidades cd on c.cod_cidade = cd.cod_cidade
  where cd.nome like 'pato branco'

--g
select a.*, b.nome banco from bancos b
  inner join agencias a on a.cod_banco = b.cod_banco
  inner join cidades c on c.cod_cidade = a.cod_cidade
  inner join estados e on e.cod_estado = a.cod_estado
where e.nome like 'PA'
order by b.nome, a.num_agencia

--h
select ep.*
from emprestimos ep 
  inner join emprestimos_clientes ec on ep.num_emprestimo = ec.num_emprestimo
  inner join clientes c on ec.cpf = c.cpf
  inner join cidades cd on c.cod_cidade = cd.cod_cidade
  inner join estados e on cd.cod_estado = e.cod_estado
where c.nome like 'florianopolis' and e.nome like 'sc'
  and ep.quantia < 10000

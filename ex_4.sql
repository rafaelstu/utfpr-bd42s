--a 
select c.* from clientes c
  inner join cidades cd on c.cod_cidade = cd.cod_cidade
where cd.nome not like 'curitiba'

--b
select a.* from agencias a
  inner join cidades c on a.cod_cidade = a.cod_cidade
  inner join estados e on c.cod_estado = e.cod_estado
where e.nome not like 'rr'

--c
select c.* from contas co
  inner join contas_clientes cc on co.num_conta = cc.num_conta
  inner join clientes c on cc.cpf = c.cpf
  inner join cidades cd on c.cod_cidade = cd.cod_cidade
  inner join estados e on cd.cod_estado = e.cod_estado
where e.nome not like 'go' and co.saldo > 100000
order by e.nome asc, co.saldo desc

--d
select co.*
from contas co
  inner join tipo_conta tc on co.cod_tipo = tc.cod_tipo
where tc.nome not like 'poupança' and co.saldo between 105000 and 220000

--e
select a.* from agencias a
where a.bairro like 'centro'

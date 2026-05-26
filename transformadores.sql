-- banco de dados: transformadores

create database transformadores
go

use transformadores
go

-- excluir tabelas existentes (ordem respeita as chaves estrangeiras)

drop table if exists transformadores
drop table if exists localizacoes
drop table if exists cidades
drop table if exists tipostatus
drop table if exists finalidades
drop table if exists fases
go



-- criacao das tabelas

create table fases(
	id int identity primary key,
	titulo varchar(100) not null,
	descricao varchar(200) not null,
	constraint uq_fases unique (titulo)
)

create table finalidades(
	id int identity primary key,
	titulo varchar(100) not null,
	descricao varchar(200) not null,
	constraint uq_finalidades unique (titulo)
)

create table tipostatus(
	codigo int identity primary key,
	descricao varchar(100) not null,
	constraint uq_tipostatus unique (descricao)
)

create table cidades(
	id int identity primary key,
	cidade varchar(100) not null,
	campo char(2) not null
)

create table localizacoes(
	id int identity primary key,
	latitude decimal(10,7) not null,
	longitude decimal(10,7) not null,
	rua varchar(150) not null,
	cep int not null,
	cidadeid int not null,
	constraint fklocalizacoes_cidades foreign key (cidadeid) references cidades(id)
)

create table transformadores(
	codigo int identity primary key,
	faseid int not null,
	finalidadeid int not null,
	bobinas int not null,
	material varchar(100) not null,
	status int not null,
	localid int not null,
	constraint uq_transformadores unique (codigo),
	constraint fktransformadores_fases foreign key (faseid) references fases(id),
	constraint fktransformadores_finalidades foreign key (finalidadeid) references finalidades(id),
	constraint fktransformadores_tipostatus foreign key (status) references tipostatus(codigo),
	constraint fktransformadores_localizacoes foreign key (localid) references localizacoes(id)
)
go



-- questao 1-a: inserir 5 registros em cada tabela

insert into fases (titulo, descricao) values
	('Monofasico', 'Transformador de fase unica'),
	('Bifasico', 'Transformador de duas fases'),
	('Trifasico', 'Transformador de tres fases'),
	('Tetrafasico', 'Transformador de quatro fases'),
	('Especial', 'Configuracao especial de fases')

insert into finalidades (titulo, descricao) values
	('Residencial', 'Uso em residencias e apartamentos'),
	('Comercial', 'Uso em estabelecimentos comerciais'),
	('Industrial', 'Uso em fabricas e industrias'),
	('Rural', 'Uso em propriedades rurais'),
	('Iluminacao', 'Uso em iluminacao publica')

insert into tipostatus (descricao) values
	('Operacional'),
	('Em Manutencao'),
	('Desativado'),
	('Aguardando Instalacao'),
	('Com Defeito')

insert into cidades (cidade, campo) values
	('Curitiba', 'PR'),
	('Sao Paulo', 'SP'),
	('Florianopolis', 'SC'),
	('Porto Alegre', 'RS'),
	('Londrina', 'PR')

insert into localizacoes (latitude, longitude, rua, cep, cidadeid) values
	(-25.4284, -49.2733, 'Rua das Flores', 80010000, 1),
	(-25.4300, -49.2800, 'Av. Batel', 80420100, 1),
	(-25.4500, -49.2500, 'Rua XV de Novembro', 80060000, 1),
	(-25.4100, -49.2600, 'Av. Sete de Setembro', 80230000, 1),
	(-25.4700, -49.3000, 'Rua Marechal Deodoro', 80010010, 1)

insert into transformadores (faseid, finalidadeid, bobinas, material, status, localid) values
	(1, 1, 6, 'Cobre', 1, 1),
	(2, 2, 8, 'Aluminio', 2, 2),
	(3, 3, 12, 'Cobre', 1, 3),
	(1, 4, 4, 'Aluminio', 3, 4),
	(3, 5, 10, 'Cobre', 1, 5)
go



-- questao 1-b: inserir 5 transformadores com bobinas = 0, finalidade 1 e fase 1

insert into transformadores (faseid, finalidadeid, bobinas, material, status, localid) values
	(1, 1, 0, 'Cobre', 1, 1),
	(1, 1, 0, 'Aluminio', 2, 2),
	(1, 1, 0, 'Cobre', 3, 3),
	(1, 1, 0, 'Aluminio', 1, 4),
	(1, 1, 0, 'Cobre', 2, 5)
go



-- questao 1-c: atualizar localid de 1 para 2 nos transformadores

update transformadores
set localid = 2
where localid = 1
go



-- questao 1-d: excluir todos os transformadores com bobinas = 0

delete from transformadores
where bobinas = 0
go



-- questao 1-e: excluir todas as finalidades

-- tentativa de exclusao
delete from finalidades

-- o comando NAO sera executado com sucesso.
-- o sql server retornara um erro de violacao de chave estrangeira (foreign key constraint violation),
-- pois a tabela transformadores possui registros que referenciam a tabela finalidades
-- atraves da coluna finalidadeid. como existe esse vinculo, o banco nao permite excluir
-- os registros pai enquanto houver registros filho associados a eles.
-- para que a exclusao funcionasse, seria necessario primeiro excluir ou atualizar
-- todos os transformadores vinculados, e somente entao excluir as finalidades.
go



-- questao 1-f: listar transformadores com cep entre 80000000 e 81000000

select t.codigo, t.material, t.bobinas, l.rua, l.cep, c.cidade
from transformadores t
	inner join localizacoes l on t.localid = l.id
	inner join cidades c on l.cidadeid = c.id
where l.cep between 80000000 and 81000000
go



-- questao 1-g: codigo, material, descricao do status, titulo da finalidade e titulo da fase
-- de todos os transformadores com mais de 4 bobinas

select
	t.codigo,
	t.material,
	ts.descricao as status,
	f.titulo as finalidade,
	fa.titulo as fase
from transformadores t
	inner join tipostatus ts on t.status = ts.codigo
	inner join finalidades f on t.finalidadeid = f.id
	inner join fases fa on t.faseid = fa.id
where t.bobinas > 4
go



-- questao 1-h: verificar se existe algum tipostatus sem transformador associado

select ts.codigo, ts.descricao
from tipostatus ts
	left join transformadores t on ts.codigo = t.status
where t.codigo is null
go

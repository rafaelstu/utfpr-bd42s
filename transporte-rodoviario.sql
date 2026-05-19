--  transporte rodoviario

create database rodoviario
use rodoviario
go

drop table if exists passagens
drop table if exists viagens
drop table if exists passageiros
drop table if exists motoristas
drop table if exists carros
drop table if exists linhas
drop table if exists cidades
drop table if exists tipos



-- criacao

create table tipos(
	id int identity primary key,
	descricao varchar(50) not null unique
)

create table cidades(
	id int identity primary key,
	cidade varchar(100) not null,
	uf char(2) not null,
	constraint uq_cidades unique (cidade, uf)
)

create table linhas(
	id int identity primary key,
	cidorigemid  int not null,
	ciddestinoid int not null,
	kms decimal(8,2)  not null,
	constraint fklinhas_origem foreign key (cidorigemid)  references cidades(id),
	constraint fklinhas_destino foreign key (ciddestinoid) references cidades(id)
)

create table carros(
	id int identity primary key,
	placa char(8) not null unique,
	capacidade smallint not null,
	tipoid int not null,
	constraint fkcarros_tipos foreign key (tipoid) references tipos(id)
)

create table motoristas(
	id int identity primary key,
	nome varchar(100) not null,
	cnh varchar(11) not null unique,
	celular varchar(15) null,
	cpf char(11) not null unique,
	rg varchar(12) not null unique,
	email varchar(100) null
)

create table passageiros(
	cpf char(11) primary key,
	nome varchar(100) not null,
	celular varchar(15) null,
	contato varchar(100) null,
	celularcontato varchar(15) null
)

create table viagens(
	id int identity primary key,
	linhaid int not null,
	data date not null,
	hora time not null,
	tarifa decimal(8,2) not null,
	taxa decimal(8,2)  not null default 0,
	carroid int not null,
	motoristaid int not null,
	constraint fkviagens_linhas foreign key (linhaid) references linhas(id),
	constraint fkviagens_carros foreign key (carroid) references carros(id),
	constraint fkviagens_motoristas foreign key (motoristaid) references motoristas(id)
)

create table passagens(
	id int identity primary key,
	viagemid int not null,
	poltrona smallint not null,
	passageiroid char(11) not null,
	-- mesma poltrona nao pode ser vendida duas vezes na mesma viagem
	constraint uq_passagens_viagem_poltrona unique (viagemid, poltrona),
	constraint fkpassagens_viagens foreign key (viagemid) references viagens(id),
	constraint fkpassagens_passageiros foreign key (passageiroid) references passageiros(cpf)
)
go



-- inserir 7 tuplas

insert into tipos (descricao) values
	('Convencional'),
	('Executivo'),
	('Semi-Leito'),
	('Leito'),
	('Leito-Cama'),
	('Micro-Onibus'),
	('Expresso')

insert into cidades (cidade, uf) values
	('Sao Paulo', 'SP'),
	('Curitiba', 'PR'),
	('Florianopolis', 'SC'),
	('Porto Alegre', 'RS'),
	('Cascavel', 'PR'),
	('Foz do Iguacu', 'PR'),
	('Londrina', 'PR')

-- ids gerados automaticamente: sp=1 ctba=2 floripa=3 poa=4 cascavel=5 foz=6 londrina=7
insert into linhas (cidorigemid, ciddestinoid, kms) values
	(1, 2, 408.00),   -- sp -> curitiba
	(2, 3, 300.50),   -- curitiba -> florianopolis
	(3, 4, 476.00),   -- florianopolis -> porto alegre
	(2, 5, 490.00),   -- curitiba -> cascavel
	(5, 6, 140.00),   -- cascavel -> foz do iguacu
	(2, 7, 372.00),   -- curitiba -> londrina
	(1, 4, 900.00)    -- sp -> porto alegre

insert into carros (placa, capacidade, tipoid) values
	('ABC-1234', 44, 1),
	('DEF-5678', 40, 2),
	('GHI-9012', 36, 3),
	('JKL-3456', 32, 4),
	('MNO-7890', 28, 5),
	('PQR-1122', 48, 1),
	('STU-3344', 16, 6)

insert into motoristas (nome, cnh, celular, cpf, rg, email) values
	('Carlos Silva', '12345678901', '(41)99111-1111', '11122233344', '1234567-0', 'carlos@email.com'),
	('Joao Pereira', '23456789012', '(41)99222-2222', '22233344455', '2345678-1', 'joao@email.com'),
	('Marcos Almeida', '34567890123', '(41)99333-3333', '33344455566', '3456789-2', 'marcos@email.com'),
	('Roberto Lima', '45678901234', '(41)99444-4444', '44455566677', '4567890-3', 'roberto@email.com'),
	('Fernando Santos', '56789012345', '(41)99555-5555', '55566677788', '5678901-4', 'fernando@email.com'),
	('Sergio Costa', '67890123456', '(41)99666-6666', '66677788899', '6789012-5', 'sergio@email.com'),
	('Paulo Oliveira', '78901234567', '(41)99777-7777', '77788899900', '7890123-6', 'paulo@email.com')

-- dois passageiros com 'j' na terceira letra do nome (cajujira e fajardo)
insert into passageiros (cpf, nome, celular, contato, celularcontato) values
	('10000000001', 'Ana Souza', '(11)98000-0001', 'Maria Souza', '(11)97000-0001'),
	('20000000002', 'Bruna Ferreira', '(11)98000-0002', 'Pedro Ferreira', '(11)97000-0002'),
	('30000000003', 'Cajujira Mendes', '(41)98000-0003', 'Lucia Mendes', '(41)97000-0003'),
	('40000000004', 'Diego Castro', '(41)98000-0004', 'Julia Castro', '(41)97000-0004'),
	('50000000005', 'Elisa Torres', '(21)98000-0005', 'Joana Torres', '(21)97000-0005'),
	('60000000006', 'Fajardo Silva', '(51)98000-0006', 'Carlos Silva', '(51)97000-0006'),
	('70000000007', 'Gabriel Rocha', '(41)98000-0007', 'Rosa Rocha', '(41)97000-0007')

insert into viagens (linhaid, data, hora, tarifa, taxa, carroid, motoristaid) values
	(1, '2025-03-10', '07:00', 85.00,  5.00, 1, 1),
	(2, '2025-03-11', '09:00', 70.00,  5.00, 2, 2),
	(3, '2025-03-12', '11:00', 95.00,  5.00, 3, 3),
	(4, '2025-03-13', '13:00', 90.00,  5.00, 4, 4),
	(5, '2025-03-14', '15:00', 45.00,  3.00, 5, 5),
	(6, '2025-03-15', '17:00', 80.00,  5.00, 6, 6),
	(7, '2025-03-16', '19:00', 130.00, 8.00, 7, 7)

insert into passagens (viagemid, poltrona, passageiroid) values
	(1, 5, '10000000001'),
	(1, 10, '20000000002'),
	(2, 3, '30000000003'),
	(2, 7, '40000000004'),
	(3, 1, '50000000005'),
	(3, 15, '60000000006'),
	(3, 20, '70000000007')
go



-- adicionar endereco, numero, cep e cidadeid nos motoristas

alter table motoristas
	add endereco varchar(150) null
alter table motoristas
	add numero varchar(10) null
alter table motoristas
	add cep char(8) null
alter table motoristas
	add cidadeid int null
alter table motoristas
	add constraint fkmotoristas_cidades foreign key (cidadeid) references cidades(id)
go



-- passagens das viagens 2 e 3 em ordem de viagemid + poltrona

select
	pa.id as passagem_id,
	pa.viagemid,
	pa.poltrona,
	ps.cpf,
	ps.nome as passageiro,
	v.data as data_viagem,
	v.hora as hora_viagem,
	co.cidade as origem,
	cd.cidade as destino
from passagens pa
	inner join viagens v  on pa.viagemid = v.id
	inner join linhas li on v.linhaid = li.id
	inner join cidades co on li.cidorigemid = co.id
	inner join cidades cd on li.ciddestinoid = cd.id
	inner join passageiros ps on pa.passageiroid = ps.cpf
where pa.viagemid in (2, 3)
order by pa.viagemid, pa.poltrona
go



--  todas as viagens feitas pelo carro 6

select
	v.id as viagem_id,
	v.data,
	v.hora,
	v.tarifa,
	v.taxa,
	ca.placa,
	ca.capacidade,
	t.descricao as tipo_carro,
	m.nome as motorista,
	co.cidade as origem,
	cd.cidade as destino,
	li.kms
from viagens v
	inner join carros ca on v.carroid = ca.id
	inner join tipos t on ca.tipoid = t.id
	inner join motoristas m on v.motoristaid = m.id
	inner join linhas li on v.linhaid = li.id
	inner join cidades co on li.cidorigemid = co.id
	inner join cidades cd on li.ciddestinoid = cd.id
where v.carroid = 6
go



-- linhas com distancia entre 200 e 400 quilometros

select
	l.id as linha_id,
	co.cidade as origem,
	co.uf as uf_origem,
	cd.cidade as destino,
	cd.uf as uf_destino,
	l.kms
from linhas l
	inner join cidades co on l.cidorigemid = co.id
	inner join cidades cd on l.ciddestinoid = cd.id
where l.kms between 200 and 400
order by l.kms
go



--  passageiros que tem 'j' na terceira letra do nome

select *
from passageiros
where nome like '__j%'
order by nome
go

-- Database: Banco2

-- DROP DATABASE IF EXISTS "Banco2";

CREATE DATABASE "Banco2"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

create table Motorista (
	codMot serial primary key,
	cpf numeric(11),
	cnh numeric(10),
	nome varchar(50) ,
	endereco varchar(100)
	
	
);
create table Motorista (
	codMot serial primary key,
	cpf numeric(11),
	cnh numeric(10),
	nome varchar(50) ,
	endereco varchar(100)
	
	
);

create table Entrega (
	hora time,
	data date,
	numven integer references venda(numven),
	placa char(7) references veiculo(placa),
	codMot integer references motorista(codMot),
	primary key (hora, data)
);

create table Veiculo(
	placa char(7) primary key,
	capacidade integer
);


create table Venda(
	numven serial primary key,
	valor_total numeric (11,2),
	codvdd integer references vendedor (codvdd),
	codclient integer references  cliente (codclient)
);
create table Cliente(
	codclient serial primary key,
	nome varchar(50),
	endereco varchar(100),
	tel char(10),
	email varchar(50),
	cpf numeric(11)
	
);
create table Produto(
	codpro serial primary key,
	custo numeric(11,2),
	descricao text,
	preco numeric(11,2),
	nome varchar(50)
	
);
create table Vendedor(
	codvdd serial primary key,
	cpf numeric(11),
	v_comissao numeric(4,2),
	nome varchar(50),
	endereco varchar(100)
	
);

create table item_venda(
	codpro integer,
	numven integer,
	vunitario numeric(11,2),
	qtd integer,
	foreign key (codpro) references produto(codpro),
	foreign key (numven) references venda(numven),
	primary key (codpro, numven)
)

-- inserir dados
insert into motorista (cpf, cnh, nome, endereco) values 
		(12345, 54321, 'zé da MANGA', 'rua da manga' ),
		(26526,02638,'han oruam', 'rio de januario'),
		( 89348, 23348, 'jayson', 'paraiba')



insert into Motorista (cpf, cnh, nome, endereco) values 
(12345678, 9876543, 'zé da MANGA', 'Rua das Flores, 10'),
(23456789, 8765432, 'Maria Souza', 'Av. Central, 500'),
(34567890, 7654321, 'Carlos Lima', 'Rua B, 123');


insert into Veiculo (Placa, Capacidade) values 
('ABC1D23', 1000),
('XYZ9G88', 2500),
('KJH4L55', 1500);


insert into Vendedor (CPF, V_comissao, Nome, Endereco) values 
(4567890, 5.50, 'Roberto Dias', 'Rua dos Vendedores, 1'),
(5678901, 4.00, 'Ana Paula', 'Av. Comercial, 100'),
(6789012, 6.20, 'Marcos Paulo', 'Rua da Loja, 99');


insert into Cliente (Nome, Tel, Endereco, CPF, Email) values 
('Lucas Oliveira', '1199998888', 'Rua dos Clientes, 12', 78901234, 'lucas@email.com'),
('Fernanda Costa', '2188887777', 'Alameda Santos, 45', 89012345, 'fer@email.com'),
('Ricardo Santos', '3177776666', 'Praça da Liberdade, 5', 90123456, 'ricardo@email.com');
insert into Produto (custo, descricao, preco, nome) values 
(200.00, 'Mesa de Jantar Madeira', 550.00, 'Mesa Luxo'),
(50.00, 'Cadeira Estofada Preta', 120.00, 'Cadeira Office'),
(400.00, 'Guarda-roupa 3 Portas', 980.00, 'Roupas Plus');


insert into Venda (valor_total,codvdd, codclient) values 
(670.00, 1, 1),
(120.00, 2, 2),
(980.00, 3, 3);


insert into Item_venda (codpro, numven, vunitario, Qtd) values 
(1, 1, 550.00, 1),
(2, 1, 120.00, 1),
(2, 2, 120.00, 1);

insert into Entrega (hora, data, numven, placa, codMot) values 
('10:30:00', '2023-10-25', 1, 'ABC1D23', 1),
('14:00:00', '2023-10-25', 2, 'XYZ9G88', 2),
('09:15:00', '2023-10-26', 3, 'KJH4L55', 3);


select * from Veiculo
-- atualizar dados
update Produto 
set preco = 150.00 
where codpro = 2;

update Vendedor 
set endereco = 'Nova Rua do Comércio, 200', 
    v_comissao = 7.50
where codvdd = 1;

-- deletar dados
delete from Motorista 
where codMot = 1;

delete from Veiculo 
where placa = 'ABC1D23';


-- Obter o nome e o preço dos produt renomear a coluna de preço
select nome, preco as valor_venda 
from Produto;

-- diferentes capacidades de veículos cadastradas
select distinct capacidade 
from Veiculo;

--  produtos do mais caro para o mais barato 
select nome, preco 
from Produto 
order by preco desc;

-- quantidade de vendas por vendedor
select codvdd, COUNT(*) as total_vendas
from Venda
group by codvdd
HAVING COUNT(*) > 2;

--total de vendas, a maior venda e a média de valores
select SUM(valor_total), MAX(valor_total), AVG(valor_total) 
from Venda;

-- produtos com preço entre 100 e 600 reais
select nome, preco 
from Produto 
where preco BETWEEN 100 AND 600;

-- clientes que o nome começa com 'Maria' 
select nome 
from Cliente 
where nome LIKE 'Maria%'; 

-- Vendas realizadas pelos vendedores de código 1 ou 3
select * from Venda 
where codvdd IN (1, 3);

-- número da venda e o nome do cliente que a realizou
select v.numven, c.nome
from Venda v, Cliente c
where v.codclient = c.codclient;

-- todos os clientes que já realizaram pelo menos uma venda.
select * from Cliente 
where codclient IN (select codclient from Venda);

-- todos os vendedores que temm uma comissão maior que a da vendedor 'Ana Paula'.
select * from Vendedor 
where v_comissao > (SELECT v_comissao FROM Vendedor WHERE nome = 'Ana Paula');

-- INNER JOINH nmero da venda o valor e o nome do vendedor 
select v.numven, v.valor_total, vend.nome as nome_vendedor
from Venda v
INNER JOIN Vendedor vend ON v.codvdd = vend.codvdd;

-- left td os clientes e suas venddas
select 
    c.nome as cliente, 
    v.numven as codigo_venda, 
    v.valor_total
from Cliente c
left join Venda v ON c.codclient = v.codclient
order by c.nome desc;

--right todos os Cliente e suas Venda
select 
    v.numven as codigo_venda, 
    c.nome as nome_cliente
from Venda v 
right join Cliente c ON v.codclient = c.codclient;

-- fullclientes e Vendas
select 
    c.nome as cliente, 
    v.numven as codigo_venda
from Cliente c
full join Venda v ON c.codclient = v.codclient
order by c.nome desc;






-- todos os produtos que acabou estoque  
select p.codpro, p.preco, p.nome, iv.vunitario, iv.qtd 
from Produto p 
left join item_venda iv ON p.codpro = iv.codpro
where not exists (select * from item_venda iv where iv.codpro = p.codpro);

-- todos os produtos que tem estoque 
select p.codpro, p.preco, p.nome, iv.vunitario, iv.qtd 
from Produto p 
inner join item_venda iv ON p.codpro = iv.codpro
where  exists (select * from item_venda iv where iv.codpro = p.codpro);

-- todos os produtos que tem estoque 
select p.codpro, p.preco, p.nome, iv.vunitario, iv.qtd 
from Produto p 
left join item_venda iv ON p.codpro = iv.codpro
where exists (select * from item_venda iv where iv.codpro = p.codpro);



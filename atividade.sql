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


insert into motorista (codMot,cpf, cnh, nome, endereco) 
values (1,12345, 54321, 'zé da MANGA', 'rua da manga' ),
		(2,26526,02638,'han oruam', 'rio de januario'),
		(3, 89348, 23348, 'jayson', 'paraiba')



insert into Motorista (cpf, cnh, nome, endereco) values 
(12345678901, 9876543210, 'zé da MANGA', 'Rua das Flores, 10'),
(23456789012, 8765432109, 'Maria Souza', 'Av. Central, 500'),
(34567890123, 7654321098, 'Carlos Lima', 'Rua B, 123');


insert into Veiculo (Placa, Capacidade) values 
('ABC1D23', 1000),
('XYZ9G88', 2500),
('KJH4L55', 1500);


insert into Vendedor (CPF, V_comissao, Nome, Endereco) values 
(45678901234, 5.50, 'Roberto Dias', 'Rua dos Vendedores, 1'),
(56789012345, 4.00, 'Ana Paula', 'Av. Comercial, 100'),
(67890123456, 6.20, 'Marcos Paulo', 'Rua da Loja, 99');


insert into Cliente (Nome, Tel, Endereco, CPF, Email) values 
('Lucas Oliveira', '1199998888', 'Rua dos Clientes, 12', 78901234567, 'lucas@email.com'),
('Fernanda Costa', '2188887777', 'Alameda Santos, 45', 89012345678, 'fer@email.com'),
('Ricardo Santos', '3177776666', 'Praça da Liberdade, 5', 90123456789, 'ricardo@email.com');


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

update Produto 
set preco = 150.00 
where codpro = 2;

update Vendedor 
set endereco = 'Nova Rua do Comércio, 200', 
    v_comissao = 7.50
where codvdd = 1;

DELETE FROM Motorista 
WHERE codMot = 1;

DELETE FROM Veiculo 
WHERE placa = 'ABC1D23';

-- Obter o nome e o preço dos produtos, renomeando a coluna de preço
select nome, preco as valor_venda 
from Produto;

-- Listar as diferentes capacidades de veículos cadastradas
select distinct capacidade 
from Veiculo;

-- Listar produtos do mais caro para o mais barato 
SELECT nome, preco 
FROM Produto 
ORDER BY preco DESC;

-- quantidade de vendas por vendedor
SELECT codvdd, COUNT(*) as total_vendas
FROM Venda
GROUP BY codvdd
HAVING COUNT(*) > 1;

-- Obter o total de vendas (soma), a maior venda e a média de valores [cite: 238]
select SUM(valor_total), MAX(valor_total), AVG(valor_total) 
from Venda;

-- Produtos com preço entre 100 e 600 reais
SELECT nome, preco 
FROM Produto 
WHERE preco BETWEEN 100 AND 600;

-- Clientes cujo nome começa com 'Maria' [cite: 133]
SELECT nome 
FROM Cliente 
WHERE nome LIKE 'Maria%'; 

-- Vendas realizadas pelos vendedores de código 1 ou 3
SELECT * FROM Venda 
WHERE codvdd IN (1, 3);

-- Listar o número da venda e o nome do cliente que a realizou
SELECT v.numven, c.nome
FROM Venda v, Cliente c
WHERE v.codclient = c.codclient;

-- Selecionar todos os clientes que já realizaram pelo menos uma venda.
SELECT * FROM Cliente 
WHERE codclient IN (SELECT codclient FROM Venda);

--Selecionar todos os vendedores que possuem uma comissão maior que a do vendedor 'Ana Paula'.
SELECT p.* FROM Produto p 
WHERE EXISTS (SELECT 1 FROM item_venda iv WHERE iv.codpro = p.codpro);

-- Usando NOT IN
SELECT * FROM Veiculo 
WHERE placa NOT IN (SELECT placa FROM Entrega);

-- Usando NOT EXISTS
SELECT * FROM Veiculo v 
WHERE NOT EXISTS (SELECT 1 FROM Entrega e WHERE e.placa = v.placa);

-- Lista o número da venda, o valor e o nome do vendedor que a realizou
SELECT v.numven, v.valor_total, vend.nome AS nome_vendedor
FROM Venda v
INNER JOIN Vendedor vend ON v.codvdd = vend.codvdd;

-- LEFT JOIN listar todos os clientes da sua base, inclusive aqueles que ainda não realizaram nenhuma compra
SELECT 
    c.nome AS cliente, 
    v.numven AS codigo_venda, 
    v.valor_total
FROM Cliente c
LEFT JOIN Venda v ON c.codclient = v.codclient
ORDER BY c.nome;

-- Todos os Clientes e suas Vendas
SELECT 
    v.numven AS codigo_venda, 
    c.nome AS nome_cliente
FROM Venda v 
RIGHT JOIN Cliente c ON v.codclient = c.codclient;

-- Clientes e Vendas
SELECT 
    c.nome AS cliente, 
    v.numven AS codigo_venda
FROM Cliente c
FULL OUTER JOIN Venda v ON c.codclient = v.codclient;
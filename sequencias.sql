-- ------------------------------------------  sequencias    --------------------------------------------------


CREATE SEQUENCE serial START 101;

SELECT nextval('serial');

CREATE SEQUENCE three
INCREMENT -1
MINVALUE 1
MAXVALUE 3
START 3
CYCLE;

SELECT nextval('three');


CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    item_text VARCHAR NOT NULL,
    price DEC(10,2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);
select * from order_details;
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;

INSERT INTO
    order_details(order_id, item_id, item_text, price)
VALUES
    (100, nextval('order_item_id'),'DVD Player',100),
    (100, nextval('order_item_id'),'Android TV',550),
    (100, nextval('order_item_id'),'Speaker',250);



--  --------------------------------------------------------------------------------------------------------




-- Database: bolsaL

-- DROP DATABASE IF EXISTS "bolsaL";

CREATE DATABASE "bolsaL"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


create table distribuidor(
id integer primary key,
nome varchar(50)
);



--Cria uma sequência chamada distribuidor_id_seq
CREATE SEQUENCE distribuidor_id_seq START 1;
--Selecionar o próximo valor desta seqüência:
SELECT nextval('distribuidor_id_seq');
--Se a função nextval for chamada duas vezes no mesmo comando 
--a seqüência será incrementada duas vezes
SELECT nextval('distribuidor_id_seq'), nextval('distribuidor_id_seq');
--Para que a seqüência não seja incrementada duas vezes deve 
--ser utilizada a função nextval uma vez e currval na vez seguinte
SELECT nextval('distribuidor_id_seq'), currval('distribuidor_id_seq');

--Redefine o valor do contador do objeto de seqüência
SELECT setval('distribuidor_id_seq', 42);        --   o próximo nextval() retornará 43
SELECT setval('distribuidor_id_seq', 42, true);  --   o mesmo acima
SELECT setval('distribuidor_id_seq', 42, false);  --  o próximo nextval() retornará 42


--Utilizar esta seqüência no comando INSERT:
INSERT INTO distribuidor VALUES (nextval('distribuidor_id_seq'), 'Você S/A');
--delete from distribuidor
--select * from distribuidor


--Consultar os dados de uma sequencia
SELECT * FROM distribuidor_id_seq;

--Apagar uma sequencia
drop sequence distribuidor_id_seq


--EXERCÍCIO
-- Pesquise um modelo relacional no Google 
--crie no mínimo três tabelas diferentes do modelo
--Crie uma sequência para a chave primária de cada tabela
--Faça uso das sequências criadas para inserir dois registros em cada tabela
--Redefine o valor do contador do objeto de seqüência
--Selecione o próximo valor de cada seqüência criada
--Apague as sequencias criadas.


CREATE SEQUENCE order_CNPJ_Farmacia
START 10000000000000
MAXVALUE 99999999999999
INCREMENT 10
OWNED BY Farmacia.CNPJ_Farmacia;



create table Farmacia (
	CNPJ_Farmacia numeric(14)primary key,
	Nome_Farmacia varchar(30),
	Tel_Farmacia numeric(13),
	End_Farmacia varchar(100)
);

INSERT INTO
    Farmacia(CNPJ_Farmacia, Nome_Farmacia, Tel_Farmacia, End_Farmacia)
VALUES
    (nextval('order_CNPJ_Farmacia'),'DVD Player',1223,'RUA ALAL' ),
    (nextval('order_CNPJ_Farmacia'),'Android TV',5503,'RUA KFKM'),
    (nextval('order_CNPJ_Farmacia'),'Speaker',2503,'RUA IDJOSKM');


create table Produto (
	Cod_Produto numeric(14)primary key,
	Valor_Produto varchar(30),
	Qtd_Produto numeric(13),
	CNPJ_Farmacia numeric(14)
);

create table Farmaceutico (
	RG_Farmaceutico numeric(7)primary key,
	Nome_Farmaceutico varchar(30),
	CNPJ_Farmacia numeric(14)

);

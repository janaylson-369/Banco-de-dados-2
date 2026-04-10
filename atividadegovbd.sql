-- Database: bolsalulamolusco

-- DROP DATABASE IF EXISTS bolsalulamolusco;

CREATE DATABASE bolsalulamolusco
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

	--"MÊS COMPETÊNCIA";"MÊS REFERÊNCIA";"UF";"CÓDIGO MUNICÍPIO SIAFI";"NOME MUNICÍPIO";"CPF FAVORECIDO";"NIS FAVORECIDO";"NOME FAVORECIDO";"VALOR PARCELA"


create table Bolsa_Familia_Pagamentos(
	Mes_competencia varchar(100),
	Mes_Referencia varchar(100),
	Uf varchar(30),
	Cod_municipio varchar(100),
	Nome_Municipio varchar(200),
    CPF varchar(200), 
    NIS varchar(200),
    Nome_Pessoa varchar(200), 
	Valor varchar(100)
	 
);

select * from Bolsa_Familia_Pagamentos

COPY Bolsa_Familia_Pagamentos FROM '/tmp/202101_BolsaFamilia_Pagamentos.csv' WITH (
    FORMAT csv, HEADER,DELIMITER ';',   ENCODING 'LATIN1'
);

explain analyse select * from Bolsa_Familia_Pagamentos where NIS = '16285415367'

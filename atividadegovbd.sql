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

CREATE TABLE bolsa_familia_saques (
    mes_referencia        VARCHAR(100),
    mes_competencia       VARCHAR(100),
    uf                    VARCHAR(100),
    codigo_municipio_siafi VARCHAR(100),
    nome_municipio        VARCHAR(100),
    cpf_favorecido        VARCHAR(14),
    nis_favorecido        VARCHAR(11),
    nome_favorecido       VARCHAR(200),
    valor_saque           VARCHAR(100),
    data_saque            VARCHAR(100)
);

CREATE TABLE pe_de_meia (
    mes_referencia         TEXT,
    mes_competencia        TEXT,
    uf                     TEXT,
    codigo_municipio_siafi TEXT,
    nome_municipio         TEXT,
    nis_favorecido         TEXT,
    cpf_favorecido         TEXT,
    nome_favorecido        TEXT,
    valor_pagamento        TEXT,
    tipo_incentivo         TEXT
);

CREATE TABLE pe_de_meia (
    col1 TEXT, col2 TEXT, col3 TEXT, col4 TEXT, col5 TEXT,
    col6 TEXT, col7 TEXT, col8 TEXT, col9 TEXT, col10 TEXT,
    col11 TEXT, col12 TEXT, col13 TEXT, col14 TEXT, col15 TEXT,
    col16 TEXT, col17 TEXT, col18 TEXT
);

select * from pe_de_meia
COPY pe_de_meia 
FROM 'C:/My Project/Banco de Dados/Banco2/202507_PeDeMeia/202507_PeDeMeia.csv' 
WITH (FORMAT CSV, HEADER, DELIMITER ';', ENCODING 'LATIN1');



select * from Bolsa_Familia_Pagamentos

COPY Bolsa_Familia_Pagamentos FROM '/tmp/202101_BolsaFamilia_Pagamentos.csv' WITH (
    FORMAT csv, HEADER,DELIMITER ';',   ENCODING 'LATIN1'
);

--3º Mostrar o tempo gasto sem o uso de índices: 00:00:02.245
explain analyse select * from Bolsa_Familia_Pagamentos where NIS = '16285415367'

--4º Criar um índice para a coluna utilizada na cláusula where
create index bolsa_idx on Bolsa_Familia_Pagamentos(NIS)

--5º Mostrar o tempo gasto com o uso do índice:  00:00:00.086
explain analyse select * from Bolsa_Familia_Pagamentos where NIS = '16285415367'


SELECT count(*) AS total_pagamentos FROM Bolsa_Familia_Pagamentos; --14.233.116 registros
SELECT count(*) AS total_saques FROM bolsa_familia_saques; -- 14.060.673 registros
SELECT count(*) AS total_pede_meia FROM pe_de_meia; -- 3.653.684 registros


SELECT 
    p.Nome_Pessoa, 
    p.Valor AS Valor_Pago, 
    s.valor_saque AS Valor_Sacado,
    s.data_saque
FROM Bolsa_Familia_Pagamentos p
JOIN bolsa_familia_saques s ON p.NIS = s.nis_favorecido
LIMIT 10000;
-- Criando índices nas colunas usadas para o JOIN
CREATE INDEX idx_pede_meia_nis ON pe_de_meia(nis_favorecido);
CREATE INDEX idx_bolsa_pagamentos_nis ON Bolsa_Familia_Pagamentos(NIS);
CREATE INDEX idx_bolsa_saques_nis ON bolsa_familia_saques(nis_favorecido);

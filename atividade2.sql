-- Database: ativ2jay

-- DROP DATABASE IF EXISTS ativ2jay;

CREATE DATABASE ativ2jay
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;







--Ambulatódrios(nroa, andar, capacidade)
create table Ambulatodrios (
	nroa serial primary key,
	andar int,
	capacidade int
);

--Pacientes(codp, CPF, nome, idade, cidade, doença)
create table Pacientes (
	codp serial primary key,
	CPF numeric(7),
	nome text,
	idade int,
	cidade text,
	doenca text
);

--Médicos(codm, CPF, nome, idade, cidade, especialidade, #nroa)
create table Medicos (
	codm serial primary key,
	CPF numeric(11),
	nome text,
	idade int,
	cidade text,
	especialidade text,
	nroa int references Ambulatodrios (nroa)
);


--Consultas(#codm, #codp, data, hora)
create table Consultas(
	codm integer references Paciente(codp),
	codp integer references Medicos(codm),
	data date,
	hora time,
	primary key (codm, codp)
	
);

insert into Medicos (CPF, nome, idade, cidade, especialidade, nroa)values
(),

insert into Ambulatodrios ()values
(),

insert into Pacientes ()values
(),

insert into Consultas ()values
(),


--Que apresente o nome do médico, nome do paciente e a hora da consulta;
select nome.m, nome.p, hora.c 
from Medicos m, Pacientes p
inner join Consultas c 


--A hora da consulta, o andar do ambulatódrio e o códdigo do médico;

--Todos os nomes dos médicos (até os que não tem consultas) e a data e a hora da consulta;

--A idade dos pacientes, doença, nome dos médicos e o códdigo dos ambulatódrios.

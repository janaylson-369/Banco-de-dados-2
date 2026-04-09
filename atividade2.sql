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


	

create table ambulatodrios (
    nroa serial primary key,
    andar int,
    capacidade int
);

create table pacientes (
    codp serial primary key,
    cpf numeric(7),
    nome text,
    idade int,
    cidade text,
    doenca text
);

create table medicos (
    codm serial primary key,
    cpf numeric(11),
    nome text,
    idade int,
    cidade text,
    especialidade text,
    nroa int references ambulatodrios (nroa)
);

create table consultas (
    codm integer references medicos(codm),
    codp integer references pacientes(codp),
    data date,
    hora time,
    primary key (codm,codp)
);


insert into ambulatodrios (andar, capacidade) values
(1, 3),
(1, 10),
(2, 5),
(2, 8);

insert into pacientes (cpf, nome, idade, cidade, doenca) values
(1234567, 'ana silva', 28, 'sao paulo', 'gripe'),
(7654321, 'bruno oliveira', 45, 'rio de janeiro', 'rinite'),
(1122334, 'carla souza', 32, 'curitiba', 'diabetes');

insert into medicos (cpf, nome, idade, cidade, especialidade, nroa) values
(22222555777, 'dr. roberto catro', 49, 'paraiba', 'otorrino', 1),
(11122233344, 'dr. ricardo moura', 45, 'sao paulo', 'ortopedia', 1),
(55566677788, 'dra. helena costa', 38, 'rio de janeiro', 'cardiologia', 2),
(99900011122, 'dr. fabio santos', 52, 'curitiba', 'pediatria', 3);

insert into consultas (codm, codp, data, hora) values
(1, 1, '2026-04-10', '09:00:00'),
(2, 2, '2026-04-10', '14:30:00'),
(3, 3, '2026-04-11', '10:00:00');






--Que apresente o nome do médico, nome do paciente e a hora da consulta;
create view View_Consultas as
select m.nome as nome_medico, p.nome as nome_paciente, c.hora
from Consultas c
join Medicos m on c.codm = m.codm
join Pacientes p on c.codp = p.codp;

select * from View_Consultas;

--A hora da consulta, o andar do ambulatódrio e o códdigo do médico;
create view View_Consultas_Ho as
select c.hora, a.andar, m.codm
from Consultas c
join Medicos m on c.codm = m.codm
join ambulatodrios a on m.nroa = a.nroa;

select * from View_Consultas_Ho;
--Todos os nomes dos médicos (até os que não tem consultas) e a data e a hora da consulta;
create view View_Medicos_Agendamentos as
select m.nome, c.data, c.hora
from Medicos m
left join Consultas c on m.codm = c.codm;

select * from View_Medicos_Agendamentos;

--A idade dos pacientes, doença, nome dos médicos e o códdigo dos ambulatódrios.
create view View_Atendimento as
select p.idade, p.doenca, m.nome as nome_medico, m.nroa as codigo_ambulatorio
from Pacientes p
join Consultas c on p.codp = c.codp
join Medicos m on c.codm = m.codm;

select * from View_Atendimento;

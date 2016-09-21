create schema universidade;

use universidade;

create table pessoas(
cpf varchar(11) primary key,
nome varchar(255) not null,
sexo enum('M','F') 
);

create table professores(
cpf varchar(11) primary key,
matricula char(4) not null unique,
salario decimal(10,2) unsigned not null,
foreign key(cpf) references pessoas(cpf) 
);

create table alunos(
cpf varchar(11) primary key,
ra varchar(10) not null unique,
foreign key(cpf) references pessoas(cpf) 
);

create table predios(
id_predio bigint primary key auto_increment,
nome varchar(20) not null unique
);

create table salas(
id_sala bigint primary key auto_increment,
numero varchar(10) not null,
tipo_sala enum('TEORICA','PRATICA'),
id_predio bigint not null,
constraint uc_sala unique(numero, id_predio),
foreign key (id_predio) references predios(id_predio)	
);

create table periodos(
id_periodo bigint primary key auto_increment,
descricao varchar(20) not null,
dt_inicial date not null, 
dt_final date not null
);

create table disciplinas(
codigo_disciplina varchar(10) primary key,
nome varchar(100) unique not null,
ch_total int unsigned not null
);

create table pre_requisitos(
codigo_pre_requisito varchar(10),
codigo_disciplina varchar(10), 
primary key(codigo_pre_requisito, codigo_disciplina),
foreign key(codigo_pre_requisito) references disciplinas(codigo_disciplina),
foreign key(codigo_disciplina) references disciplinas(codigo_disciplina) 
);

create table turmas(
id_turma bigint primary key auto_increment,
turno enum('MATUTINO', 'VESPERTINO', 'NOTURNO'),
cpf varchar(11) not null,
codigo_disciplina varchar(10) not null,
id_periodo bigint not null,
constraint unique(cpf, codigo_disciplina, id_periodo),
foreign key(cpf) references professores(cpf),
foreign key(codigo_disciplina) references disciplinas(codigo_disciplina),
foreign key(id_periodo) references periodos(id_periodo) 
);

create table alunos_turmas(
cpf varchar(11), 
id_turma bigint, 
primary key(cpf,id_turma),
foreign key(cpf) references alunos(cpf),	
foreign key(id_turma) references turmas(id_turma)	
);

create table aulas(
id_aula bigint primary key auto_increment,
conteudo text,
dt_aula date not null,
id_turma bigint not null,
foreign key(id_turma) references turmas(id_turma)
);

create table faltas(
id_falta bigint primary key auto_increment,
dt_falta date,
faltou tinyint default 0,
cpf varchar(11) not null,
id_turma bigint not null,
foreign key(cpf) references alunos(cpf),
foreign key(id_turma) references turmas(id_turma)
);
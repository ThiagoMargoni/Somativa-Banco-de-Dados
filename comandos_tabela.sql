alter table usuarios add 
(foto text not null,
telefone int not null);

create table tarefas(
	id bigint primary key auto_increment, 
    titulo varchar(50) not null,
    descricao varchar(500) not null,
    statusAtual varchar(20) not null,
    solicitante_id bigint not null,
    local_id bigint not null,
    dataAbertura datetime not null default now(),
    dataFim datetime,
    prazoExecucao datetime not null,
    foreign key(solicitante_id) references usuarios(id),
    foreign key(local_id) references locais(id)
);

insert into tarefas values(
	0,
    'Arrumar Ipad',
    'Ipad não está iniciando, achei uns amassos nas pontas e acredito que o botão esteja afundado, mais detalhes na imagem',
    'Aberta',
    4,
    1,
    now(),
    null,
    '2023-06-02 23:59:00'
), 
(
	0,
    'Limpar Parede Suja',
    'Um aluno pasou mal e acabou vomitando na parede, por ser num lugar entre as mesas acabei não conseguindo puxar por conta do meu problema na coluna',
    'Concluída',
    6,
    5,
    '2023-05-25 20:40:00',
    '2023-05-25 22:00:00',
    '2023-05-26 10:00:00'
),
(
	0, 
    'Verificar Barulho Ar Condicionado',
    'Ele está fazendo um barulho estranho tem alguns dias. Estou abrindo essa tarefa pois estou ficando preocupado',
    'Aberta',
	 4,
	 1,
     now(),
     null,
     '2023-05-31 10:00:00'
);

create table fotos_tarefas(
	id bigint primary key auto_increment,
    imagem text not null,
    tarefa_id bigint not null,
    foreign key(tarefa_id) references tarefas(id)
);

insert into fotos_tarefas values
(
	0,
    'www.acervoimages.com.br/imagem1-tablet-amassado',
    1
), 
(
	0,
    'www.acervoimages.com.br/imagem2-botao-table-afundado',
    1
),
(
	0,
    'www.acervoimages.com.br/parede-vomitada',
    2
);

create table responsaveis_tarefas(
	id bigint primary key auto_increment,
    tarefa_id bigint not null, 
    responsavel_id bigint not null,
    foreign key(tarefa_id) references tarefas(id),
    foreign key(responsavel_id) references usuarios(id)
);

insert into responsaveis_tarefas values(0,1,1), (0,1,5), (0,2,4);

create table status_tarefa(
	id bigint primary key auto_increment,
    tarefa_id bigint not null,
    status varchar(20) not null,
    data datetime not null,
    comentario varchar(100) not null,
    foreign key(tarefa_id) references tarefas(id)
);

insert into status_tarefa values(0, 2, 'Em Andamento', '2023-05-25 21:00:00', 'Terminar de subir uma nota e já irei limpar - Roberto :)'),
								(0, 2, 'Concluída', '2023-05-25 22:00:00', 'Limpinho, mandei as fotos no anexo');

create table imagens_status_tarefa(
	id bigint primary key auto_increment,
    imagem text not null,
    status_tarefa_id bigint not null,
    foreign key(status_tarefa_id) references status_tarefa(id)
);

insert into imagens_status_tarefa values(
	0,
    'www.acervoimages.com.br/parede-limpinha',
    2
);
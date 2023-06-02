/* a */ select * from responsaveis_tarefas rt
inner join tarefas t on rt.tarefa_id = t.id
inner join usuarios u on rt.responsavel_id = u.id;

/* b */ select l.* from locais l 
inner join tarefas t on t.local_id = l.id
group by t.local_id 
having count(l.id) > 2;

/* c */ select u.* from usuarios u  
inner join responsaveis_tarefas rt on rt.responsavel_id = u.id
group by rt.responsavel_id 
having count(u.id) >= 2;

/* d */ select l.*, e.*, t.* from locais l
inner join eventos e on e.localFk = l.id
inner join tarefas t on t.local_id = l.id
where t.statusAtual != 'Concluída' and e.inicio > now();

/* e */ select l.*, count(t.id) total_tarefas from locais l
inner join tarefas t on t.local_id = l.id
group by l.id;

/* f */ select l.*, count(t.id) total_tarefas from locais l
inner join (
	select * from tarefas 
    where tarefas.statusAtual = 'Concluída'
) t on t.local_id = l.id
group by l.id;

/* g */ select u.*, count(rt.responsavel_id) total_tarefas from usuarios u
inner join responsaveis_tarefas rt on rt.responsavel_id = u.id
group by u.id;

/* h */ select u.*, count(rt.responsavel_id) total_tarefas from usuarios u
inner join responsaveis_tarefas rt on rt.responsavel_id = u.id
inner join (
	select * from tarefas
    where tarefas.statusAtual in ('Em Andamento', 'Aberta')
) t on rt.tarefa_id = t.id
group by u.id;

/* i */ select *, round(avg(t.count), 2) media from locais l 
inner join (
	select local_id, month(dataAbertura) mes, count(*) count from tarefas 
    group by local_id, mes
) t on l.id = t.local_id 
group by l.id, t.mes;
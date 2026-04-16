-- ejercicio 1 --
update entradas 
set estado = 'cancelar'
where id_entrada = 3;

 -- ejercicio 2 --
update tipos_entrada
set precio = 100.00
where id_tipo = 3;
 
 -- ejercicio 3 --
update eventos 
set aforo_total = 600
where id_evento = 1;

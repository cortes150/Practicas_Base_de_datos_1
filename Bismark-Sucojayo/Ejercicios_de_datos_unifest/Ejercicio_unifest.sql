-- primer ejercicio
update entradas
 set estado = 'cancelada'
 where id_entrada =1;
 
 -- segundo
  update tipos_entrada
 set precio = 200.00
 where id_tipo = 2;
 
 -- tercer
 update eventos 
 set aforo_total = 700
 where id_evento = 1;
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
 set aforo_total = 600
 where id_evento = 1;
 
 -- cuarto
 update pagos
 set metodo_pago = 'efectivo'
 where id_pago = 9;
 
 -- quinto
 update asistencia
 set asistio = 1
 where id_asistencia = 4;
 
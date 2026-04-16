--EJERCICIO 1--
--cambiar el precio de la entrada  vip
select * from eventos
update tipos_entrada set precio ='300' where id_tipo = 2
--EJERCICIO 2--
--cambiar el estado de una entrada a cancelada
update entradas set estado ='cancelada' where id_tipo = 2
--EJERCICIO 3--
update eventos set aforo_total = 600 where id_evento = 1
--actualizar el aforo del evento rock que sea 600
--cambiar el metodo de pago tarjeta por efectivo donde el identificador es 9
--actualizar la asistencia del evento 2

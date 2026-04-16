--Ejercicio 1
--cambiar el estado de una entrada a cancelado
update entradas
set estado 'cancelada'
where id_entrada = 6
--Ejercicio 2
--cambiar el precio de la entrada vip
update tipos_entrada 
set precio = 150.00
where nombre_tipo = 'VIP'
--Ejercicio 3
--actualizar el aforo del evento rock universitario, que el nuevo aforo sea 600

--Ejercicio 4
--cambiar el metodo de pago tarjeta por efectivo donde el identificador es 9

--Ejercicio 5
--actualizar la asistencia del evento 2 con su identificador 2 

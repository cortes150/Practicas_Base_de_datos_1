##EJERCICIOS
## 1. cambiar una entrada su estado a cancelada
update entradas set estado = 'cancelada' where id_entrada = 4;
## 2. cambiar el precio de la entrada VIP
update tipos_entrada set precio = '300.00' where id_tipo = 2;
## 3. actualizar el aforo del evento rock universitario que sea 600
update eventos set aforo_total = '600' where id_evento = 1;
## 4. cambiar el metodo de pago tarjeta por ejectivo donde el indentificador es 9
## 5. actualizar la asistencia del evento 2 
-- ejercicios datos

-- E1: cancelar una entrada activa 
update entradas 
set estado = 'cancelada'
where id_entrada = 4;

-- E2: cambiar el precio de la entrada vip
update tipos_entrada
set precio= 120.00
where id_tipo = 4;
-- E3: actualizar el aforo del evento rock universitario a 600
update eventos
set aforo_total = 600
where id_evento = 1;
-- E4: Cambiar el metodo de pago targeta ´por efectivo donde el id es 9
-- E5: actualizar la asistencia del evento 2  id 2 

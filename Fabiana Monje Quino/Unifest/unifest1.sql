--EJERCICIO 1--
--cambiar el precio de la entrada  vip
select * from pagos
update tipos_entrada set precio ='300' where id_tipo = 2
--EJERCICIO 2--
--cambiar el estado de una entrada a cancelada
update entradas set estado ='cancelada' where id_tipo = 2
--EJERCICIO 3--
update eventos set aforo_total = 600 where id_evento = 1
--actualizar el aforo del evento rock que sea 600
--EJERCICIO 4--
INSERT INTO pagos (id_pago, id_entrada, id_pagador, monto, metodo_pago) VALUES
(6, 1, 3, 20.00, 'efectivo'),
(7, 2, 3, 15.50, 'online'),
(8, 3, 4, 10.00, 'tarjeta');
INSERT INTO pagos (id_pago, id_entrada, id_pagador, monto, metodo_pago) 
VALUES (9, 1, 3, 50.00, 'tarjeta');
update pagos set metodo_pago = 'efectivo' where id_pago = 9
--cambiar el metodo de pago tarjeta por efectivo donde el identificador es 9
--EJERCICIO 5--
UPDATE asistencia 
SET asistio = 1 
WHERE id_evento = 2;
--actualizar la asistencia del evento 2

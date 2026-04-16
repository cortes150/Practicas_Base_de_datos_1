-- ejercicio1
update entradas
set estado = 'cancelada'
where id_entrada = 1;

-- ejercicio2
UPDATE tipos_entrada
SET precio = 150.00
WHERE id_tipo = 2;

-- ejercicio3
UPDATE eventos
SET aforo_total = 600
WHERE id_evento = 1;

-- ejercicio4
UPDATE pagos
SET metodo_pago = 'efectivo'
WHERE id_pago = 9;

-- ejercicio5
UPDATE asistencia
SET asistio = 1
WHERE id_evento = 2;
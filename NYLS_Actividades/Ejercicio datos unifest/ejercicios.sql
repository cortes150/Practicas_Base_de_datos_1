-- ejercicio1
update entradas
set estado = 'cancelada'
where id_entrada = 1;

-- ejercicio2
update tipos_entrada
set precio = 150.00
where id_tipo = 2;

-- ejercicio3
update eventos
set aforo_total = 600
where id_evento = 1;

-- ejercicio4
update pagos
set metodo_pago = 'efectivo'
where id_pago = 9;

-- ejercicio5
update asistencia
set asistio = 1
where id_evento = 2;
###Ejercicio 4 : cambiar el metodo pago tarjeta por efectivo donde el identificador es 9
update pagos
set metodo_pago = 'efectivo'
where id_pago = 9;



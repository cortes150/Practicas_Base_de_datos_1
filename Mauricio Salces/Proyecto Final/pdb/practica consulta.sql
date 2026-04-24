-- Ejercicios
-- REPORTES SQL – COCA COLA

-- 1. TOP PRODUCTOS MÁS VENDIDOS  x (por cantidad)
 select p.nombre as producto, sum(dp.cantidad) as total_unidades
 from producto p
 inner join detalle_pedido dp on p.id_producto = dp.id_producto
 group by p.id_producto
 order by sum(dp.cantidad) desc;
 
-- 2. TOP PRODUCTOS POR INGRESOS 
 select p.nombre as producto, sum(dp.cantidad*dp.precio_unitario) as ingreso
 from producto p
 inner join detalle_pedido dp on p.id_producto = dp.id_producto
 group by p.id_producto
 order by sum(dp.cantidad*dp.precio_unitario) desc;
 
--  3. VENTAS POR CIUDAD 
 select c.ciudad, sum(dp.cantidad*dp.precio_unitario) as valor_pedido
 from cliente c
 inner join pedido p on c.id_cliente = p.id_cliente
 inner join detalle_pedido dp on p.id_pedido = dp.id_pedido
 group by c.ciudad
 order by valor_pedido desc;
 
-- 4. CLIENTES QUE MÁS COMPRAN 
select c.nombre as Cliente, sum(dp.cantidad * dp.precio_unitario) as total_comprado
from cliente c
inner join pedido p on c.id_cliente = p.id_cliente
inner join detalle_pedido dp on p.id_pedido = dp.id_pedido
group by c.id_cliente
order by total_comprado desc;
  
-- 5. PRODUCTOS MÁS VENDIDOS POR CANTIDAD (> X)
 select p.nombre as producto, sum(dp.cantidad) as cantidad_total
 from producto p 
 inner join detalle_pedido dp on p.id_producto = dp.id_producto
 group by p.id_producto
 having sum(dp.cantidad) > 5
 order by cantidad_total desc;
 
-- 6. DISTRIBUIDOR CON MÁS ENTREGAS 
 select d.nombre as Distribuidor, count(e.id_entrega) as Numero_entregas
 from distribuidor d
 inner join ruta r on d.id_distribuidor = r.id_distribuidor
 inner join pedido p on p.id_ruta = r.id_ruta
 inner join entrega e on e.id_pedido = p.id_pedido
 group by d.id_distribuidor
 order by Numero_entregas desc;
 
-- 7. PEDIDOS POR ESTADO
 select p.estado, count(p.id_pedido) as total_pedidos
 from pedido p
 group by p.estado
 order by total_pedidos desc;
 
-- 8. STOCK TOTAL POR PRODUCTO
 select p.nombre as Producto, sum(i.stock) as stock_total
 from producto p
 inner join inventario i on p.id_producto = i.id_producto
 group by p.id_producto;
 
-- 9. PRODUCTOS CON BAJO STOCK 
 select p.nombre as Producto, sum(i.stock) as stock_total
 from producto p
 inner join inventario i on p.id_producto = i.id_producto
 group by p.id_producto
 order by stock_total asc;
 
--  10. RUTAS CON MÁS PEDIDOS
select r.nombre as Ruta, count(p.id_pedido) Cantidad_Pedidos
from ruta r
inner join pedido p on r.id_ruta = p.id_ruta
group by r.id_ruta
order by Cantidad_Pedidos desc;
 
-- 11. VENTAS POR CATEGORÍA 
select c.nombre_categoria, sum(dp.cantidad*dp.precio_unitario) as Ventas
from categoria c
inner join producto p on c.id_categoria = p.id_categoria
inner join detalle_pedido dp on dp.id_producto = p.id_producto
group by c.id_categoria;

-- 12. PROMEDIO DE COMPRA POR PEDIDO 
 select p.id_pedido as numero_pedido, avg(dp.cantidad*dp.precio_unitario) as promedio_compra
 from pedido p
 join detalle_pedido dp on p.id_pedido = dp.id_pedido
 group by p.id_pedido;
 
--  13. CLIENTES SIN PEDIDOS 
 select c.nombre as cliente
 from cliente c
 left join pedido p on c.id_cliente = p.id_cliente
 where p.id_pedido is null;
 
-- 14. PEDIDOS NO ENTREGADOS 
select id_pedido, estado
from pedido
where estado != 'entregado';
 
-- 15. PRODUCTO MÁS VENDIDO (TOP 1) 
select p.nombre as producto, sum(dp.cantidad) as cantidad_vendida
from producto p
join detalle_pedido dp on p.id_producto = dp.id_producto
group by p.id_producto
order by cantidad_vendida desc
limit 1;


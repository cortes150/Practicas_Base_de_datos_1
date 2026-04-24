
CREATE DATABASE unifest_db;
USE unifest_db;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATE,
    lugar VARCHAR(100)
);
CREATE TABLE entrada (
    id_entrada INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT,
    precio DECIMAL(10,2),
    estado ENUM('vendida','cancelada'),
    
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

CREATE TABLE compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_entrada INT,
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_entrada) REFERENCES entrada(id_entrada)
);

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT,
    monto DECIMAL(10,2),
    metodo ENUM('efectivo','tarjeta','online'),
    
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);

CREATE TABLE asistencia (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_evento INT,
    asistio TINYINT(1),
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

INSERT INTO usuario (nombre, correo) VALUES
('Juan Perez','juan@mail.com'),
('Maria Lopez','maria@mail.com'),
('Carlos Diaz','carlos@mail.com'),
('Ana Torres','ana@mail.com'),
('Luis Rojas','luis@mail.com');
INSERT INTO evento (nombre, fecha, lugar) VALUES
('Concierto Rock','2025-06-01','Auditorio'),
('Festival DJ','2025-06-05','Coliseo'),
('Feria Tech','2025-06-10','Campus'),
('Expo Gamer','2025-06-15','Centro Convenciones');
INSERT INTO entrada (id_evento, precio, estado) VALUES
(1,100,'vendida'),
(1,120,'vendida'),
(1,120,'cancelada'),
(2,150,'vendida'),
(2,150,'vendida'),
(2,180,'cancelada'),
(3,80,'vendida'),
(3,90,'vendida'),
(4,200,'vendida'),
(4,250,'vendida');
INSERT INTO compra (id_usuario, id_entrada) VALUES
(1,1),
(1,2),
(2,4),
(2,5),
(3,7),
(3,8),
(4,9),
(5,10);
INSERT INTO pago (id_compra, monto, metodo) VALUES
(1,100,'efectivo'),
(2,120,'tarjeta'),
(3,150,'tarjeta'),
(4,150,'online'),
(5,80,'efectivo'),
(6,90,'tarjeta'),
(7,200,'online'),
(8,250,'tarjeta');
INSERT INTO asistencia (id_usuario, id_evento, asistio) VALUES
(1,1,1),
(2,2,1),
(3,3,1),
(4,4,0),
(5,1,0);

/*1 lista todos los eventos*/
select e.nombre, COUNT(en.id_entrada) as total_vendidas
from evento e
join entrada en on e.id_evento = en.id_evento
group by e.nombre;
/*2 muestra los nombres de los usuarios*/
select distinct u.nombre
from usuario u
join compra c on u.id_usuario = c.id_usuario join pago p on c.id_compra = p.id_compra
where p.metodo = 'Tarjeta';
/*3 mostrar el total recaudado*/
select metodo, SUM(monto) as total_recaudado
from pago
group by metodo;
select*from pago;
/*4 mostrar lo eventos qsue tienen al menos una entrada cancelada*/
select e.nombre, count(en.id_entrada) as cantidad_canceladas
from evento e
join entrada en on e.id_evento = en.id_evento
WHERE en.estado = 'Cancelada'
GROUP BY e.nombre;

/*5 muestra los usuarios que compraron mas de una entrada*/
select u.nombre, COUNT(c.id_entrada) as cantidad_comprada from usuario u
join compra c on u.id_usuario = c.id_usuario
group by u.id_usuario, u.nombre
having count(c.id_entrada)>1;
/*6 encuentra el evento com la entrada mas cara del sistema*/
select e.nombre, en.precio from evento e
join entrada en on e.id_evento = en.id_evento
order by en.precio desc
limit 1;
/*7 muestra a los usuarios que asistieron al menos a un evento*/
select distinct u.nombre from usuario u
join asistencia a on u.id_usuario = a.id_usuario
where a.asistio = 1;
/* 8 muestra el promedio del precio de las entradas por cada evento*/
select e.nombre, avg(en.precio) as promedio_precio from evento e
join entrada en on e.id_evento = en.id_evento
group by e.nombre;

/*9 muestra los usuario que no asistieron a un evento*/
select nombre from usuario
where id_usuario not in (
    select id_usuario 
    from asistencia 
    where asistio = 1
);
/*10 muestra cuanto dinero a pagado en total cada usuario orddenado de mayor a menor*/
select u.nombre, SUM(p.monto) as total_invertido from usuario u
join compra c on u.id_usuario = c.id_usuario
join pago p on c.id_compra = p.id_compra
group by u.id_usuario, u.nombre
order by total_invertido desc;
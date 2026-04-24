
CREATE TYPE estado_entrada AS ENUM ('vendida', 'cancelada');
CREATE TYPE metodo_pago AS ENUM ('efectivo', 'tarjeta', 'online');



CREATE TABLE usuario (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE evento (
    id_evento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATE,
    lugar VARCHAR(100)
);

CREATE TABLE entrada (
    id_entrada INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_evento INT,
    precio DECIMAL(10,2),
    estado estado_entrada,
    CONSTRAINT fk_evento FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

CREATE TABLE compra (
    id_compra INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT,
    id_entrada INT,
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_entrada FOREIGN KEY (id_entrada) REFERENCES entrada(id_entrada)
);

CREATE TABLE pago (
    id_pago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_compra INT,
    monto DECIMAL(10,2),
    metodo metodo_pago,
    CONSTRAINT fk_compra FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
);

CREATE TABLE asistencia (
    id_asistencia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT,
    id_evento INT,
    asistio BOOLEAN, -- En Postgres usamos BOOLEAN en lugar de TINYINT
    CONSTRAINT fk_usuario_asistencia FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_evento_asistencia FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);
SELECT * FROM PAGO
SELECT * FROM asistencia
SELECT * FROM compra
SELECT * FROM entrada
SELECT * FROM EVENTO
SELECT * FROM usuario

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
INSERT INTO asistencia (id_usuario, id_evento, asistio) 
VALUES (1,1,true),
(2,2,true),
(3,3,true),
(4,4,false),
(5,1,false);
--ejercicio1
select evento.nombre, count(entrada.id_entrada) as entradas_vendidas
from evento
inner join entrada on evento.id_evento = entrada.id_evento
where entrada.estado = 'vendida'
group by evento.id_evento, evento.nombre
--ejercicio2
SELECT usuario.nombre AS usuarios_compra_con_tarjeta
FROM usuario
INNER JOIN compra on usuario.id_usuario = compra.id_usuario
INNER JOIN pago ON compra.id_compra = pago.id_compra
WHERE pago.metodo = 'tarjeta';

--ejercicio3
SELECT metodo, SUM(monto) AS total_recaudado
FROM pago
GROUP BY metodo;

--ejercicio4
SELECT e.nombre, COUNT(en.id_entrada) AS cantidad_canceladas
FROM evento e
inner JOIN entrada en ON e.id_evento = en.id_evento
WHERE en.estado = 'cancelada'
GROUP BY e.id_evento, e.nombre
HAVING COUNT(en.id_entrada) > 0;

--ejercico5 
SELECT usuario.nombre AS usuarios_compra_entrada
FROM usuario
INNER JOIN compra on usuario.id_usuario = compra.id_usuario
INNER join entrada on entrada.id_entrada = compra.id_entrada
GROUP BY usuario.nombre
having count (entrada.id_entrada) > 1;

--ejercicio6 
SELECT e.nombre, en.precio
FROM evento e
inner JOIN entrada en ON e.id_evento = en.id_evento
ORDER BY en.precio DESC
LIMIT 1;

--ejercicio7
select usuario.nombre
from usuario
INNER JOIN asistencia on usuario.id_usuario = asistencia.id_usuario
where asistencia.asistio = true;

--ejercicio8 
SELECT e.nombre, AVG(en.precio) AS precio_promedio
FROM evento e
JOIN entrada en ON e.id_evento = en.id_evento
GROUP BY e.id_evento, e.nombre;

--ejercicio9
select usuario.nombre
from usuario
INNER JOIN asistencia on usuario.id_usuario = asistencia.id_usuario
where asistencia.asistio = false;

--ejercicio10
select usuario.nombre, Sum(pago.monto) as total_pagado
from usuario 
inner join compra on usuario.id_usuario = compra.id_usuario
inner join pago on compra.id_compra = pago.id_compra
group by usuario.id_usuario, usuario.nombre
order by total_pagado desc






create database soporte_tecnico;
use soporte_tecnico;
create table Cliente(
id_cliente int auto_increment primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
CI varchar(20) unique not null,
celular varchar(20) not null,
telefono varchar(20),
direccion varchar(100),
tipo_cliente enum('Persona_natural', 'Empresa') default 'Persona_natural' not null,
correo_electronico varchar(100) unique not null, 
fecha_registro timestamp default current_timestamp not null
);

create table Equipo(
id_equipo int auto_increment primary key, 
nro_serie varchar (50) unique not null,
tipo_equipo enum('Laptop', 'Desktop', 'Celular', 'Consola') not null,
marca varchar (50) not null,
modelo varchar (50) not null,
especificacion text,
estado_estetico text,
contraseña_acceso varchar(50),
fecha_registro date default (current_date),
id_cliente int not null,
foreign key (id_cliente) references Cliente (id_cliente)
);

create table Tecnico(
id_tecnico int auto_increment primary key,
nombre varchar (50) not null,
apellido varchar (50) not null,
ci varchar (20) unique not null,
especialidad varchar(100) not null,
telefono varchar (20) not null,
correo_institucional varchar (100) unique not null,
fecha_ingreso date not null,
estado_tecnico enum ('Disponible', 'Ocupado', 'Vacaciones') default 'Disponible',
nivel_acceso enum ('Administrador', 'Tecnico Senior', 'Pasante') default 'Tecnico Senior'
);
ALTER TABLE Tecnico 
ADD COLUMN password VARCHAR(100) NOT NULL AFTER correo_institucional;
create table Repuesto (
id_repuesto int auto_increment primary key,
codigo_parte varchar (50) unique not null,
nombre_repuesto varchar (100) not null,
marca varchar (50) not null,
descripcion text,
precio_costo decimal(10,2) not null,
precio_venta decimal(10,2) not null,
stock_actual int default 0,
stock_minimo int default 2,
categoria enum ('Almacenamiento', 'RAM', 'Pantallas', 'Otros') not null   
);

create table Orden_Servicio(
id_orden int auto_increment primary key,
id_cliente int not null,
id_equipo int not null,
id_tecnico int not null,
fecha_ingreso datetime default current_timestamp,
fecha_prometida date,
falla_reportada text not null,
diagnostico_tecnico text,
prioridad enum ('Baja', 'Media', 'Alta','Urgente') default 'Media',
estado_actual enum ('Recibido','En Diagnostico','Esperando Repuestos','Reparado','Entregado') default 'Recibido',
costo_total decimal(10,2) default 0.00
);
ALTER TABLE Orden_Servicio
ADD CONSTRAINT fk_orden_cliente
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Orden_Servicio
ADD CONSTRAINT fk_orden_equipo
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Nota: Se usa RESTRICT para proteger la integridad del historial de trabajo
ALTER TABLE Orden_Servicio
ADD CONSTRAINT fk_orden_tecnico
    FOREIGN KEY (id_tecnico) REFERENCES Tecnico(id_tecnico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

create table Historial_Estado(
id_historial int auto_increment primary key,
id_tecnico int not null, 
id_orden int not null,
estado enum('Recibido', 'En Diagnóstico', 'Esperando Repuestos', 'Reparado', 'Entregado', 'Cancelado')not null,
fecha_hora datetime not null default current_timestamp,
observaciones text,
foreign key (id_tecnico) references Tecnico (id_tecnico),
foreign key (id_orden) references Orden_Servicio (id_orden)
);

create table Detalle_Reparacion(
id_detalle int auto_increment primary key,
id_repuesto int not null,
id_orden int not null,
cantidad int not null default 1,
precio_unitario_aplicado decimal(10,2) not null,
subtotal decimal(10,2) not null,
foreign key (id_repuesto) references Repuesto (id_repuesto),
foreign key (id_orden) references Orden_Servicio (id_orden)
);

create table Pago (
id_pago int auto_increment primary key,
id_orden int not null,
monto decimal (10,2) not null,
fecha_pago datetime default current_timestamp,
metodo_pago enum ('Efectivo','QR','Transferencia','Tarjeta') not null,
nro_comprobante varchar(50),
foreign key (id_orden) references Orden_Servicio (id_orden)
);
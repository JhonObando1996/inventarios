drop table if exists categorias;
create table categorias(
	codigo_cat serial not null,
	nombre varchar(100)not null,
	categoria_padre int,
	constraint codigo_cat_pk primary key(codigo_cat),
	constraint categoria_padre_fk foreign key (categoria_padre) references categorias(codigo_cat)
);

insert into categorias(nombre, categoria_padre)
values ('Materia Prima',null);
insert into categorias(nombre, categoria_padre)
values ('Proteina',1);
insert into categorias(nombre, categoria_padre)
values ('Salsas',1);
insert into categorias(nombre, categoria_padre)
values ('Punto de Venta',null);
insert into categorias(nombre, categoria_padre)
values ('Bebidas',4);
insert into categorias(nombre, categoria_padre)
values ('Con Alcohol',5);
insert into categorias(nombre, categoria_padre)
values ('Sin Alcohol',5);

--select * from categorias

drop table if exists categorias_unidad_medida;
create table categorias_unidad_medida(
	codigo_categoria_udm char(1)not null,
	nombre varchar(100)not null,
	constraint codigo_categoria_udm_pk primary key(codigo_categoria_udm)
);

insert into categorias_unidad_medida(codigo_categoria_udm, nombre)
values ('U','Unidades');
insert into categorias_unidad_medida(codigo_categoria_udm, nombre)
values ('V','Volumen');
insert into categorias_unidad_medida(codigo_categoria_udm, nombre)
values ('P','Peso');

--select * from categorias_unidad_medida

drop table if exists unidades_medida;
create table unidades_medida(
	codigo_udm char(2) not null,
	descripcion varchar(100)not null,
	codigo_categoria_udm char(1)not null,
	constraint codigo_udm_pk primary key(codigo_udm),
	constraint codigo_categoria_udm_fk foreign key (codigo_categoria_udm) references categorias_unidad_medida(codigo_categoria_udm)
);

insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('ml','mililitros','V');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('l','litros','V');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('u','unidad','U');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('d','docena','U');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('g','gramos','P');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('kg','kilogramos','P');
insert into unidades_medida(codigo_udm, descripcion, codigo_categoria_udm)
values ('lb','libras','P');

--select * from unidades_medida

drop table if exists productos;
create table productos(
	codigo_producto serial not null,
	nombre_producto varchar(100)not null,
	codigo_udm char(2) not null,
	precio_venta money not null,
	tiene_iva boolean not null,
	coste money not null,
	codigo_cat int not null,
	stock int not null,
	constraint codigo_producto_pk primary key(codigo_producto),
	constraint codigo_udm_fk foreign key (codigo_udm) references unidades_medida(codigo_udm),
	constraint codigo_cat_fk foreign key (codigo_cat) references categorias(codigo_cat)
);

insert into productos(nombre_producto, codigo_udm, precio_venta,tiene_iva, coste,codigo_cat,stock)
values('Coca cola pequeña', 'u',0.5804, true, 0.3729,7,105 );
insert into productos(nombre_producto, codigo_udm, precio_venta,tiene_iva, coste,codigo_cat,stock)
values('Salsa de tomate', 'kg',0.95, true, 0.87,3,0 );
insert into productos(nombre_producto, codigo_udm, precio_venta,tiene_iva, coste,codigo_cat,stock)
values('Mostaza', 'kg',0.95, true, 0.89,3,0 );
insert into productos(nombre_producto, codigo_udm, precio_venta,tiene_iva, coste,codigo_cat,stock)
values('Fuze tea', 'u',0.80, true, 0.70,7,49 );

--select * from productos

drop table if exists tipo_documentos;
create table tipo_documentos(
	codigo_tipo_documento char(1)not null,
	descripcion varchar(50)not null,
	constraint codigo_tipo_documento_pk primary key(codigo_tipo_documento)
);

insert into tipo_documentos(codigo_tipo_documento,descripcion)
values('C', 'Cedula');
insert into tipo_documentos(codigo_tipo_documento,descripcion)
values('R', 'RUC');
insert into tipo_documentos(codigo_tipo_documento,descripcion)
values('P', 'Pasaporte');

--select * from tipo_documentos

drop table if exists proveedores;
create table proveedores(
	identificador varchar(10)not null,
	codigo_tipo_documento char(1)not null,
	nombre_proveedor varchar(50)not null,
	telefono_proveedor varchar(10)not null,
	correo_proveedor varchar(100)not null,
	direccion_proveedor varchar(100)not null,
	constraint identificador_pk primary key(identificador),
	constraint codigo_tipo_documento_fk foreign key (codigo_tipo_documento) references tipo_documentos(codigo_tipo_documento)
);
insert into proveedores(identificador,codigo_tipo_documento,nombre_proveedor,telefono_proveedor,correo_proveedor,direccion_proveedor)
values('0928329','R', 'Jhon Obando', '0967115322','jhoda1996@gmail.com','San Roque');
insert into proveedores(identificador,codigo_tipo_documento,nombre_proveedor,telefono_proveedor,correo_proveedor,direccion_proveedor)
values('0928329777','C', 'Snack S.A', '0989657895','snacksa@gmail.com','La Carolina');
insert into proveedores(identificador,codigo_tipo_documento,nombre_proveedor,telefono_proveedor,correo_proveedor,direccion_proveedor)
values('0989898980','C', 'Jhonathan Rojas', '0987985698','jhonathan1998@gmail.com','La Tola');

--select * from proveedores

drop table if exists estado_pedidos;
create table estado_pedidos(
	codigo_estado_pedido char(1)not null,
	descripcion varchar(100)not null,
	constraint codigo_estado_pedido_pk primary key(codigo_estado_pedido)
);

insert into estado_pedidos(codigo_estado_pedido,descripcion)
values('S','Solicitado');
insert into estado_pedidos(codigo_estado_pedido,descripcion)
values('R','Recibido');

--select * from estado_pedidos

drop table if exists cabecera_pedido;
create table cabecera_pedido(
	numero_cabecera_pedido serial not null,
	identificador varchar(10)not null,
	fecha date not null,
	codigo_estado_pedido char(1)not null,
	constraint numero_cabecera_pedido_pk primary key(numero_cabecera_pedido),
	constraint identificador_fk foreign key (identificador) references proveedores(identificador),
	constraint codigo_estado_pedido_fk foreign key (codigo_estado_pedido) references estado_pedidos(codigo_estado_pedido)
);

insert into cabecera_pedido(identificador,fecha,codigo_estado_pedido)
values('0928329','20/11/2023','R');
insert into cabecera_pedido(identificador,fecha,codigo_estado_pedido)
values('0928329','20/11/2023','R');

delete from cabecera_pedido
where numero_cabecera_pedido = 4;
--select * from cabecera_pedido

drop table if exists detalle_pedido;
create table detalle_pedido(
	codigo_detalle_pedido serial not null,
	numero_cabecera_pedido int not null,
	codigo_producto int not null,	
	cantidad_solicitada int not null,
	subtotal money not null,
	cantidad_recibida int not null,
	constraint codigo_detalle_pedido_pk primary key(codigo_detalle_pedido),
	constraint numero_cabecera_pedido_fk foreign key (numero_cabecera_pedido) references cabecera_pedido(numero_cabecera_pedido),
	constraint codigo_producto_fk foreign key (codigo_producto) references productos(codigo_producto)
);

insert into detalle_pedido(numero_cabecera_pedido,codigo_producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(1,1,100,37.29,100);
insert into detalle_pedido(numero_cabecera_pedido,codigo_producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(1,4,50,11.8,50);
insert into detalle_pedido(numero_cabecera_pedido,codigo_producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(2,1,10,3.73,10);

--select * from detalle_pedido

drop table if exists historial_stock;
create table historial_stock(
	codigo_historial_stock serial not null,
	fecha timestamp not null,
	referencia varchar(50)not null,
	codigo_producto int not null,	
	cantidad int not null,
	constraint codigo_historial_stock_pk primary key(codigo_historial_stock),
	constraint codigo_producto_fk foreign key (codigo_producto) references productos(codigo_producto)
);

insert into historial_stock(fecha, referencia, codigo_producto, cantidad)
values('20/11/2023  19:59:08', 'Pedido 1', 1, 100);
insert into historial_stock(fecha, referencia, codigo_producto, cantidad)
values('20/11/2023  19:59:08', 'Pedido 1', 4, 50);
insert into historial_stock(fecha, referencia, codigo_producto, cantidad)
values('20/11/2023  20:00:00', 'Pedido 2', 1, 10);
insert into historial_stock(fecha, referencia, codigo_producto, cantidad)
values('20/11/2023  20:00:00', 'Venta 1', 1, -5);
insert into historial_stock(fecha, referencia, codigo_producto, cantidad)
values('20/11/2023  20:00:00', 'Venta 1', 4, -1);

--select * from historial_stock

drop table if exists cabecera_ventas;
create table cabecera_ventas(
	codigo_cabecera_ventas serial not null,
	fecha timestamp not null,
	total_sin_iva money not null,
	iva money not null,
	total money not null,
	constraint codigo_cabecera_ventas_pk primary key(codigo_cabecera_ventas)
);

insert into cabecera_ventas(fecha, total_sin_iva, iva, total)
values('20/11/2023  20:00:00', 3.26, 0.39,3.65);

--select * from cabecera_ventas

drop table if exists detalle_ventas;
create table detalle_ventas(
	codigo_detalle_ventas serial not null,
	codigo_cabecera_ventas int not null,
	codigo_producto int not null,
	cantidad int not null,
	precio_venta money not null,
	subtotal money not null,
	subtotal_con_iva money not null,
	constraint codigo_detalle_ventas_pk primary key(codigo_detalle_ventas),
	constraint codigo_cabecera_ventas_fk foreign key (codigo_cabecera_ventas) references cabecera_ventas(codigo_cabecera_ventas),
	constraint codigo_producto_fk foreign key (codigo_producto) references productos(codigo_producto)
);

insert into detalle_ventas(codigo_cabecera_ventas, codigo_producto, cantidad, precio_venta, subtotal, subtotal_con_iva)
values(1,1,5,0.58,2.9,3.25);
insert into detalle_ventas(codigo_cabecera_ventas, codigo_producto, cantidad, precio_venta, subtotal, subtotal_con_iva)
values(1,4,1,0.36,0.36,0.4);

--select * from detalle_ventas

select prov.identificador ,prov.codigo_tipo_documento,td.descripcion,prov.nombre_proveedor ,prov.telefono_proveedor ,prov.correo_proveedor,prov.direccion_proveedor
from proveedores prov, tipo_documentos td
where prov.codigo_tipo_documento = td.codigo_tipo_documento
and upper(nombre_proveedor) like '%JH%'

select prod.codigo_producto, prod.nombre_producto, udm.codigo_udm as nombre_udm,udm.descripcion as descripcion_udm, 
prod.precio_venta, prod.tiene_iva, prod.coste, prod.codigo_cat as categoria, cat.nombre as nombre_categoria,prod.stock 
from  productos prod, unidades_medida udm, categorias cat
where prod.codigo_udm = udm.codigo_udm
and prod.codigo_cat = cat.codigo_cat
and upper(prod.nombre_producto) like '%M%'

select * from proveedores
select * from tipo_documentos
select * from unidades_medida
select * from productos



select * from cabecera_pedido
select * from detalle_pedido

select * from historial_stock
select * from cabecera_ventas
select * from detalle_ventas
select * from productos
























































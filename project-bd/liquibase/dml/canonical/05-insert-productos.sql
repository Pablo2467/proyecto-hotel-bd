--liquibase formatted sql

--changeset equipo:105
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Agua mineral 500ml', 'Botella de agua mineral', 3500.00, 100, 'bebidas');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Gaseosa 350ml', 'Bebida gaseosa lata', 4500.00, 80, 'bebidas');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Cerveza nacional', 'Cerveza botella 330ml', 7000.00, 60, 'bebidas');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Desayuno continental', 'Jugo, pan, huevo, cafe', 18000.00, 30, 'alimentos');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Almuerzo ejecutivo', 'Sopa, plato, postre, jugo', 25000.00, 20, 'alimentos');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Snack mixto', 'Maní, papas y galletas', 8000.00, 50, 'alimentos');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Toalla extra', 'Toalla de baño adicional', 5000.00, 40, 'servicios');
INSERT INTO productos (nombre, descripcion, precio_unitario, stock, categoria) VALUES ('Servicio lavanderia', 'Lavado y planchado por prenda', 12000.00, 99, 'servicios');
--rollback DELETE FROM productos;
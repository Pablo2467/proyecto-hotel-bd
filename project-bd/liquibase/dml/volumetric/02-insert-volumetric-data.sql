--liquibase formatted sql

--changeset equipo:202

-- USUARIOS (10 registros)
INSERT INTO usuarios (nombre_completo, correo, contrasena, rol_id) VALUES
('Angie Administradora', 'angie@hotel.com', 'admin123', 1),
('Carlos Recepcion', 'carlos@hotel.com', 'rec123', 2),
('Maria Recepcion', 'maria@hotel.com', 'rec123', 2),
('Pedro Limpieza', 'pedro@hotel.com', 'clean123', 3),
('Laura Limpieza', 'laura@hotel.com', 'clean123', 3),
('Jorge Restaurante', 'jorge@hotel.com', 'rest123', 4),
('Sofia Restaurante', 'sofia@hotel.com', 'rest123', 4),
('Ricardo Auditor', 'ricardo@hotel.com', 'audit123', 5),
('Diana Recepcion', 'diana@hotel.com', 'rec123', 2),
('Luis Limpieza', 'luis@hotel.com', 'clean123', 3);

-- HABITACIONES (20 registros)
INSERT INTO habitaciones (numero_habitacion, tipo_id, estado_id, piso) VALUES
('101', 1, 1, 1), ('102', 1, 1, 1), ('103', 2, 1, 1), ('104', 2, 2, 1),
('105', 3, 1, 1), ('201', 1, 1, 2), ('202', 1, 2, 2), ('203', 2, 1, 2),
('204', 2, 1, 2), ('205', 3, 3, 2), ('301', 1, 1, 3), ('302', 1, 1, 3),
('303', 2, 1, 3), ('304', 4, 2, 3), ('305', 3, 1, 3), ('401', 4, 1, 4),
('402', 4, 1, 4), ('403', 3, 4, 4), ('404', 2, 1, 4), ('405', 1, 1, 4);

-- HUESPEDES (20 registros)
INSERT INTO huespedes (nombre_completo, tipo_documento, numero_documento, correo, telefono, nacionalidad) VALUES
('Juan Perez', 'CC', '1001234567', 'juan@gmail.com', '3001234567', 'Colombia'),
('Maria Lopez', 'CC', '1009876543', 'maria@gmail.com', '3009876543', 'Colombia'),
('Carlos Gomez', 'CC', '1005678901', 'carlos@gmail.com', '3005678901', 'Colombia'),
('Ana Torres', 'CE', 'E123456', 'ana@gmail.com', '3112345678', 'Venezuela'),
('Luis Martinez', 'CC', '1007654321', 'luis@gmail.com', '3107654321', 'Colombia'),
('Sofia Ruiz', 'PAS', 'AB123456', 'sofia@gmail.com', '3201234567', 'España'),
('Pedro Vargas', 'CC', '1003456789', 'pedro@gmail.com', '3203456789', 'Colombia'),
('Laura Castro', 'CC', '1008765432', 'laura@gmail.com', '3208765432', 'Colombia'),
('Diego Mora', 'CE', 'E234567', 'diego@gmail.com', '3151234567', 'Ecuador'),
('Valentina Rios', 'CC', '1006543210', 'valentina@gmail.com', '3156543210', 'Colombia'),
('Andres Pena', 'CC', '1002345678', 'andres@gmail.com', '3002345678', 'Colombia'),
('Camila Diaz', 'PAS', 'CD789012', 'camila@gmail.com', '3007890123', 'Mexico'),
('Roberto Silva', 'CC', '1004567890', 'roberto@gmail.com', '3104567890', 'Colombia'),
('Isabella Reyes', 'CC', '1009012345', 'isabella@gmail.com', '3109012345', 'Colombia'),
('Miguel Herrera', 'CE', 'E345678', 'miguel@gmail.com', '3161234567', 'Peru'),
('Daniela Flores', 'CC', '1001357924', 'daniela@gmail.com', '3001357924', 'Colombia'),
('Sebastian Cruz', 'CC', '1008024681', 'sebastian@gmail.com', '3008024681', 'Colombia'),
('Natalia Mendez', 'PAS', 'NM456789', 'natalia@gmail.com', '3211234567', 'Argentina'),
('Felipe Ortega', 'CC', '1005791357', 'felipe@gmail.com', '3105791357', 'Colombia'),
('Gabriela Vega', 'CC', '1003579135', 'gabriela@gmail.com', '3203579135', 'Colombia');

-- RESERVAS (20 registros) - IDs de habitacion 1-20 en orden SERIAL
INSERT INTO reservas (habitacion_id, usuario_id, nombre_huesped, fecha_entrada, fecha_salida, estado) VALUES
(1, 2, 'Juan Perez', '2026-01-10 14:00:00', '2026-01-13 12:00:00', 'finalizada'),
(3, 2, 'Maria Lopez', '2026-01-12 14:00:00', '2026-01-15 12:00:00', 'finalizada'),
(5, 3, 'Carlos Gomez', '2026-01-15 14:00:00', '2026-01-18 12:00:00', 'finalizada'),
(6, 3, 'Ana Torres', '2026-01-20 14:00:00', '2026-01-23 12:00:00', 'finalizada'),
(8, 2, 'Luis Martinez', '2026-02-01 14:00:00', '2026-02-05 12:00:00', 'finalizada'),
(9, 9, 'Sofia Ruiz', '2026-02-05 14:00:00', '2026-02-08 12:00:00', 'finalizada'),
(10, 9, 'Pedro Vargas', '2026-02-10 14:00:00', '2026-02-12 12:00:00', 'finalizada'),
(11, 2, 'Laura Castro', '2026-02-15 14:00:00', '2026-02-20 12:00:00', 'finalizada'),
(12, 3, 'Diego Mora', '2026-03-01 14:00:00', '2026-03-05 12:00:00', 'finalizada'),
(13, 9, 'Valentina Rios', '2026-03-05 14:00:00', '2026-03-08 12:00:00', 'finalizada'),
(2, 2, 'Andres Pena', '2026-03-10 14:00:00', '2026-03-13 12:00:00', 'finalizada'),
(4, 3, 'Camila Diaz', '2026-03-15 14:00:00', '2026-03-18 12:00:00', 'finalizada'),
(7, 9, 'Roberto Silva', '2026-04-01 14:00:00', '2026-04-04 12:00:00', 'finalizada'),
(14, 2, 'Isabella Reyes', '2026-04-05 14:00:00', '2026-04-08 12:00:00', 'finalizada'),
(15, 3, 'Miguel Herrera', '2026-04-10 14:00:00', '2026-04-14 12:00:00', 'finalizada'),
(16, 9, 'Daniela Flores', '2026-04-15 14:00:00', '2026-04-17 12:00:00', 'finalizada'),
(17, 2, 'Sebastian Cruz', '2026-04-20 14:00:00', '2026-04-23 12:00:00', 'finalizada'),
(18, 3, 'Natalia Mendez', '2026-05-01 14:00:00', '2026-05-05 12:00:00', 'finalizada');


-- ESTADIAS (18 registros)
INSERT INTO estadias (reserva_id, huesped_id, habitacion_id, fecha_checkin, fecha_checkout, estado, total_hospedaje) VALUES
(1, 1, 1, '2026-01-10 14:00:00', '2026-01-13 12:00:00', 'finalizada', 240000.00),
(2, 2, 3, '2026-01-12 14:00:00', '2026-01-15 12:00:00', 'finalizada', 390000.00),
(3, 3, 5, '2026-01-15 14:00:00', '2026-01-18 12:00:00', 'finalizada', 750000.00),
(4, 4, 6, '2026-01-20 14:00:00', '2026-01-23 12:00:00', 'finalizada', 390000.00),
(5, 5, 8, '2026-02-01 14:00:00', '2026-02-05 12:00:00', 'finalizada', 520000.00),
(6, 6, 9, '2026-02-05 14:00:00', '2026-02-08 12:00:00', 'finalizada', 240000.00),
(7, 7, 10, '2026-02-10 14:00:00', '2026-02-12 12:00:00', 'finalizada', 260000.00),
(8, 8, 11, '2026-02-15 14:00:00', '2026-02-20 12:00:00', 'finalizada', 1250000.00),
(9, 9, 12, '2026-03-01 14:00:00', '2026-03-05 12:00:00', 'finalizada', 1280000.00),
(10, 10, 13, '2026-03-05 14:00:00', '2026-03-08 12:00:00', 'finalizada', 960000.00),
(11, 11, 2, '2026-03-10 14:00:00', '2026-03-13 12:00:00', 'finalizada', 240000.00),
(12, 12, 4, '2026-03-15 14:00:00', '2026-03-18 12:00:00', 'finalizada', 390000.00),
(13, 13, 7, '2026-04-01 14:00:00', '2026-04-04 12:00:00', 'finalizada', 240000.00),
(14, 14, 14, '2026-04-05 14:00:00', '2026-04-08 12:00:00', 'finalizada', 390000.00),
(15, 15, 15, '2026-04-10 14:00:00', '2026-04-14 12:00:00', 'finalizada', 520000.00),
(16, 16, 16, '2026-04-15 14:00:00', '2026-04-17 12:00:00', 'finalizada', 160000.00),
(17, 17, 17, '2026-04-20 14:00:00', '2026-04-23 12:00:00', 'finalizada', 960000.00),
(18, 18, 18, '2026-05-01 14:00:00', '2026-05-05 12:00:00', 'finalizada', 1280000.00);

-- CONSUMOS (30 registros)
INSERT INTO consumos (estadia_id, producto_id, cantidad, precio_unitario, fecha_consumo, usuario_id) VALUES
(1, 1, 3, 3500.00, '2026-01-11 09:00:00', 6),
(1, 4, 2, 18000.00, '2026-01-11 08:00:00', 6),
(2, 2, 4, 4500.00, '2026-01-13 10:00:00', 7),
(2, 5, 3, 25000.00, '2026-01-13 13:00:00', 7),
(3, 3, 6, 7000.00, '2026-01-16 19:00:00', 6),
(3, 4, 3, 18000.00, '2026-01-16 08:00:00', 6),
(4, 1, 2, 3500.00, '2026-01-21 09:00:00', 7),
(4, 6, 4, 8000.00, '2026-01-21 16:00:00', 7),
(5, 5, 4, 25000.00, '2026-02-02 13:00:00', 6),
(5, 3, 8, 7000.00, '2026-02-03 20:00:00', 6),
(6, 4, 3, 18000.00, '2026-02-06 08:00:00', 7),
(6, 2, 5, 4500.00, '2026-02-06 11:00:00', 7),
(7, 7, 2, 5000.00, '2026-02-11 10:00:00', 6),
(7, 8, 3, 12000.00, '2026-02-11 14:00:00', 6),
(8, 4, 5, 18000.00, '2026-02-16 08:00:00', 7),
(8, 5, 5, 25000.00, '2026-02-17 13:00:00', 7),
(9, 3, 10, 7000.00, '2026-03-02 20:00:00', 6),
(9, 6, 6, 8000.00, '2026-03-03 16:00:00', 6),
(10, 1, 4, 3500.00, '2026-03-06 09:00:00', 7),
(10, 4, 3, 18000.00, '2026-03-06 08:00:00', 7),
(11, 2, 3, 4500.00, '2026-03-11 11:00:00', 6),
(12, 5, 3, 25000.00, '2026-03-16 13:00:00', 7),
(13, 3, 4, 7000.00, '2026-04-02 19:00:00', 6),
(14, 4, 4, 18000.00, '2026-04-06 08:00:00', 7),
(15, 8, 4, 12000.00, '2026-04-11 14:00:00', 6),
(16, 1, 2, 3500.00, '2026-04-16 09:00:00', 7),
(17, 6, 5, 8000.00, '2026-04-21 16:00:00', 6),
(17, 3, 6, 7000.00, '2026-04-22 20:00:00', 6),
(18, 4, 5, 18000.00, '2026-05-02 08:00:00', 7),
(18, 5, 4, 25000.00, '2026-05-03 13:00:00', 7);

-- PAGOS (18 registros)
INSERT INTO pagos (estadia_id, metodo_pago_id, monto, fecha_pago, observacion, usuario_id) VALUES
(1, 1, 247000.00, '2026-01-13 11:00:00', 'Pago total en efectivo', 2),
(2, 2, 465000.00, '2026-01-15 11:00:00', 'Pago con tarjeta credito', 2),
(3, 3, 804000.00, '2026-01-18 11:00:00', 'Pago con tarjeta debito', 3),
(4, 1, 422000.00, '2026-01-23 11:00:00', 'Pago en efectivo', 3),
(5, 4, 716000.00, '2026-02-05 11:00:00', 'Transferencia bancaria', 9),
(6, 2, 317500.00, '2026-02-08 11:00:00', 'Tarjeta credito', 2),
(7, 1, 296000.00, '2026-02-12 11:00:00', 'Efectivo', 3),
(8, 3, 1465000.00, '2026-02-20 11:00:00', 'Debito', 9),
(9, 2, 1630000.00, '2026-03-05 11:00:00', 'Tarjeta credito', 2),
(10, 1, 1068000.00, '2026-03-08 11:00:00', 'Efectivo', 3),
(11, 4, 253500.00, '2026-03-13 11:00:00', 'Transferencia', 9),
(12, 2, 465000.00, '2026-03-18 11:00:00', 'Tarjeta credito', 2),
(13, 1, 268000.00, '2026-04-04 11:00:00', 'Efectivo', 3),
(14, 3, 462000.00, '2026-04-08 11:00:00', 'Debito', 9),
(15, 4, 568000.00, '2026-04-14 11:00:00', 'Transferencia', 2),
(16, 1, 167000.00, '2026-04-17 11:00:00', 'Efectivo', 3),
(17, 2, 1062000.00, '2026-04-23 11:00:00', 'Tarjeta credito', 9),
(18, 3, 1470000.00, '2026-05-05 11:00:00', 'Debito', 2);



--rollback DELETE FROM pagos; DELETE FROM consumos; DELETE FROM estadias; DELETE FROM reservas; DELETE FROM huespedes; DELETE FROM habitaciones; DELETE FROM usuarios;
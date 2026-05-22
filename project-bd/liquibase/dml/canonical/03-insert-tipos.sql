--liquibase formatted sql

--changeset equipo:103
INSERT INTO tipos_habitacion (id, nombre_tipo, capacidad, precio_noche) VALUES (1, 'sencilla', 1, 80000.00);
INSERT INTO tipos_habitacion (id, nombre_tipo, capacidad, precio_noche) VALUES (2, 'doble', 2, 130000.00);
INSERT INTO tipos_habitacion (id, nombre_tipo, capacidad, precio_noche) VALUES (3, 'suite', 3, 250000.00);
INSERT INTO tipos_habitacion (id, nombre_tipo, capacidad, precio_noche) VALUES (4, 'familiar', 4, 320000.00);
--rollback DELETE FROM tipos_habitacion;
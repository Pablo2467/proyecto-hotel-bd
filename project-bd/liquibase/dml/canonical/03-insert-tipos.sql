--liquibase formatted sql

--changeset equipo:103
INSERT INTO tipos_habitacion (nombre_tipo, capacidad, precio_noche) VALUES ('sencilla', 1, 80000.00);
INSERT INTO tipos_habitacion (nombre_tipo, capacidad, precio_noche) VALUES ('doble', 2, 130000.00);
INSERT INTO tipos_habitacion (nombre_tipo, capacidad, precio_noche) VALUES ('suite', 3, 250000.00);
INSERT INTO tipos_habitacion (nombre_tipo, capacidad, precio_noche) VALUES ('familiar', 4, 320000.00);
--rollback DELETE FROM tipos_habitacion;
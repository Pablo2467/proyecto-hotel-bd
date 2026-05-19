--liquibase formatted sql

--changeset equipo:102
INSERT INTO estados_habitacion (nombre_estado) VALUES ('disponible');
INSERT INTO estados_habitacion (nombre_estado) VALUES ('ocupada');
INSERT INTO estados_habitacion (nombre_estado) VALUES ('en_limpieza');
INSERT INTO estados_habitacion (nombre_estado) VALUES ('mantenimiento');
INSERT INTO estados_habitacion (nombre_estado) VALUES ('fuera_de_servicio');
--rollback DELETE FROM estados_habitacion;
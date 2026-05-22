--liquibase formatted sql

--changeset equipo:102
INSERT INTO estados_habitacion (id, nombre_estado) VALUES (1, 'disponible');
INSERT INTO estados_habitacion (id, nombre_estado) VALUES (2, 'ocupada');
INSERT INTO estados_habitacion (id, nombre_estado) VALUES (3, 'en_limpieza');
INSERT INTO estados_habitacion (id, nombre_estado) VALUES (4, 'mantenimiento');
INSERT INTO estados_habitacion (id, nombre_estado) VALUES (5, 'fuera_de_servicio');
--rollback DELETE FROM estados_habitacion;
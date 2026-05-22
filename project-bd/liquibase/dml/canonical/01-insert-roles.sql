--liquibase formatted sql

--changeset equipo:101
INSERT INTO roles (id, nombre_rol) VALUES (1, 'administrador');
INSERT INTO roles (id, nombre_rol) VALUES (2, 'recepcionista');
INSERT INTO roles (id, nombre_rol) VALUES (3, 'housekeeping');
INSERT INTO roles (id, nombre_rol) VALUES (4, 'restaurante');
INSERT INTO roles (id, nombre_rol) VALUES (5, 'auditor');
--rollback DELETE FROM roles;
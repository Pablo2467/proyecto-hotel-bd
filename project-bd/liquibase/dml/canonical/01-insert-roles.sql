--liquibase formatted sql

--changeset equipo:101
INSERT INTO roles (nombre_rol) VALUES ('administrador');
INSERT INTO roles (nombre_rol) VALUES ('recepcionista');
INSERT INTO roles (nombre_rol) VALUES ('housekeeping');
INSERT INTO roles (nombre_rol) VALUES ('restaurante');
INSERT INTO roles (nombre_rol) VALUES ('auditor');
--rollback DELETE FROM roles;
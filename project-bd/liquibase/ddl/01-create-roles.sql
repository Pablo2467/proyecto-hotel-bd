--liquibase formatted sql

--changeset equipo:1
CREATE TABLE roles (
    id INT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);
--rollback DROP TABLE roles;

--liquibase formatted sql

--changeset equipo:2
CREATE TABLE estados_habitacion (
    id INT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE
);
--rollback DROP TABLE estados_habitacion;

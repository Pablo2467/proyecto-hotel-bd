--liquibase formatted sql

--changeset equipo:3
CREATE TABLE tipos_habitacion (
    id INT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    capacidad INT NOT NULL,
    precio_noche DECIMAL(10,2) NOT NULL
);
--rollback DROP TABLE tipos_habitacion;

--liquibase formatted sql

--changeset equipo:11
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_unitario NUMERIC(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria VARCHAR(50)
);
--rollback DROP TABLE productos;

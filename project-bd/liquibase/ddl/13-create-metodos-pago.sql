--liquibase formatted sql

--changeset equipo:13
CREATE TABLE metodos_pago (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
--rollback DROP TABLE metodos_pago;
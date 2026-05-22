--liquibase formatted sql

--changeset equipo:8
CREATE TABLE auditoria_estados (
    id SERIAL PRIMARY KEY,
    habitacion_id INT NOT NULL,
    estado_anterior_id INT,
    estado_nuevo_id INT NOT NULL,
    usuario_id INT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auditoria_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);
--rollback DROP TABLE auditoria_estados;

--liquibase formatted sql

--changeset equipo:7
CREATE TABLE asignaciones_limpieza (
    id SERIAL PRIMARY KEY,
    habitacion_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_inicio_limpieza TIMESTAMP,
    fecha_fin_limpieza TIMESTAMP,
    CONSTRAINT fk_asignacion_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id),
    CONSTRAINT fk_asignacion_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
--rollback DROP TABLE asignaciones_limpieza;

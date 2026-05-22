--liquibase formatted sql

--changeset equipo:6
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    habitacion_id INT NOT NULL,
    usuario_id INT NOT NULL,
    nombre_huesped VARCHAR(100) NOT NULL,
    fecha_entrada TIMESTAMP NOT NULL,
    fecha_salida TIMESTAMP,
    CONSTRAINT fk_reserva_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id),
    CONSTRAINT fk_reserva_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
--rollback DROP TABLE reservas;

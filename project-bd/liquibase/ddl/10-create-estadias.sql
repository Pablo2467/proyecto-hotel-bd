--liquibase formatted sql

--changeset equipo:10
CREATE TABLE estadias (
    id SERIAL PRIMARY KEY,
    reserva_id INT NOT NULL REFERENCES reservas(id),
    huesped_id INT NOT NULL REFERENCES huespedes(id),
    habitacion_id INT NOT NULL REFERENCES habitaciones(id),
    fecha_checkin TIMESTAMP NOT NULL,
    fecha_checkout TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'activa',
    total_hospedaje NUMERIC(12,2)
);
--rollback DROP TABLE estadias;

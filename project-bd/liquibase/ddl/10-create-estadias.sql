CREATE TABLE estadias (
    id SERIAL PRIMARY KEY,
    reserva_id INT NOT NULL REFERENCES reservas(id),
    huesped_id INT NOT NULL REFERENCES huespedes(id),
    habitacion_id INT NOT NULL REFERENCES habitaciones(id),
    fecha_entrada TIMESTAMP NOT NULL,
    fecha_salida TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'activa'
);
CREATE TABLE reservas (
    id INT PRIMARY KEY,
    habitacion_id INT NOT NULL,
    usuario_id INT NOT NULL, -- Recepcionista que registró
    nombre_huesped VARCHAR(100) NOT NULL,
    fecha_entrada TIMESTAMP NOT NULL,
    fecha_salida TIMESTAMP,
    CONSTRAINT fk_reserva_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id),
    CONSTRAINT fk_reserva_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
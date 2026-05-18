CREATE TABLE habitaciones (
    id INT PRIMARY KEY,
    numero_habitacion VARCHAR(10) NOT NULL UNIQUE,
    tipo_id INT NOT NULL,
    estado_id INT NOT NULL,
    piso INT NOT NULL,
    CONSTRAINT fk_habitacion_tipo FOREIGN KEY (tipo_id) REFERENCES tipos_habitacion(id),
    CONSTRAINT fk_habitacion_estado FOREIGN KEY (estado_id) REFERENCES estados_habitacion(id)
);
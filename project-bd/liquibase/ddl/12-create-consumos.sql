CREATE TABLE consumos (
    id SERIAL PRIMARY KEY,
    estadia_id INT NOT NULL REFERENCES estadias(id),
    producto_id INT NOT NULL REFERENCES productos(id),
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario NUMERIC(10,2) NOT NULL,
    fecha_consumo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT
);
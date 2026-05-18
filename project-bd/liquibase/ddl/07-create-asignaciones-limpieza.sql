CREATE TABLE asignaciones_limpieza (
    id INT PRIMARY KEY,
    habitacion_id INT NOT NULL,
    usuario_id INT NOT NULL, -- Empleado de limpieza
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_inicio_limpieza TIMESTAMP,
    fecha_fin_limpieza TIMESTAMP,
    CONSTRAINT fk_asignacion_habitacion FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id),
    CONSTRAINT fk_asignacion_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
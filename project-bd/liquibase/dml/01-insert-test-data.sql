-- Un recepcionista de prueba
INSERT INTO usuarios (id, nombre_completo, correo, contrasena, rol_id) 
VALUES (1, 'Angie Admin', 'angie@hotel.com', 'admin123', 1);

-- Una habitación de prueba (Sencilla y Disponible)
INSERT INTO habitaciones (id, numero_habitacion, tipo_id, estado_id, piso) 
VALUES (101, '101', 1, 1, 1);
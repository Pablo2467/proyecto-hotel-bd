-- ============================================================
-- CONSULTAS DE VALIDACIÓN — JOIN DE 6+ TABLAS
-- ============================================================

-- CONSULTA 1 (Integrante 1)
-- Huéspedes con estadías finalizadas: habitación, tipo, consumos y pagos
SELECT
    h.nombre_completo AS huesped,
    h.numero_documento,
    hab.numero_habitacion,
    t.nombre_tipo AS tipo_habitacion,
    e.fecha_checkin,
    e.fecha_checkout,
    e.total_hospedaje,
    COALESCE(SUM(c.subtotal), 0) AS total_consumos,
    COALESCE(SUM(p.monto), 0) AS total_pagado,
    fn_total_pendiente_estadia(e.id) AS saldo_pendiente
FROM estadias e
JOIN huespedes h ON e.huesped_id = h.id
JOIN habitaciones hab ON e.habitacion_id = hab.id
JOIN tipos_habitacion t ON hab.tipo_id = t.id
JOIN reservas r ON e.reserva_id = r.id
LEFT JOIN consumos c ON c.estadia_id = e.id
LEFT JOIN pagos p ON p.estadia_id = e.id
WHERE e.estado = 'finalizada'
GROUP BY h.nombre_completo, h.numero_documento, hab.numero_habitacion,
         t.nombre_tipo, e.fecha_checkin, e.fecha_checkout, e.total_hospedaje, e.id
ORDER BY e.fecha_checkin DESC;

-- ============================================================

-- CONSULTA 2 (Integrante 2)
-- Productos más consumidos por estadía con método de pago usado
SELECT
    pr.nombre AS producto,
    pr.categoria,
    SUM(c.cantidad) AS total_unidades,
    SUM(c.subtotal) AS total_facturado,
    h.nombre_completo AS huesped,
    hab.numero_habitacion,
    t.nombre_tipo,
    mp.nombre AS metodo_pago
FROM consumos c
JOIN productos pr ON c.producto_id = pr.id
JOIN estadias e ON c.estadia_id = e.id
JOIN huespedes h ON e.huesped_id = h.id
JOIN habitaciones hab ON e.habitacion_id = hab.id
JOIN tipos_habitacion t ON hab.tipo_id = t.id
LEFT JOIN pagos p ON p.estadia_id = e.id
LEFT JOIN metodos_pago mp ON p.metodo_pago_id = mp.id
GROUP BY pr.nombre, pr.categoria, h.nombre_completo,
         hab.numero_habitacion, t.nombre_tipo, mp.nombre
ORDER BY total_facturado DESC;
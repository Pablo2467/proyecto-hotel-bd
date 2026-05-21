--liquibase formatted sql

--changeset equipo:15
ALTER TABLE reservas ADD COLUMN estado VARCHAR(20) NOT NULL DEFAULT 'pendiente';
ALTER TABLE reservas ADD CONSTRAINT chk_estado_reserva CHECK (estado IN ('pendiente', 'confirmada', 'cancelada', 'finalizada'));
--rollback ALTER TABLE reservas DROP COLUMN estado;
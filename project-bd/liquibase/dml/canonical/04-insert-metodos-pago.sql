--liquibase formatted sql

--changeset equipo:104
INSERT INTO metodos_pago (nombre) VALUES ('efectivo');
INSERT INTO metodos_pago (nombre) VALUES ('tarjeta_credito');
INSERT INTO metodos_pago (nombre) VALUES ('tarjeta_debito');
INSERT INTO metodos_pago (nombre) VALUES ('transferencia');
--rollback DELETE FROM metodos_pago;
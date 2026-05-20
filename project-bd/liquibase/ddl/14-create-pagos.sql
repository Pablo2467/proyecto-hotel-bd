--liquibase formatted sql

--changeset equipo:14
CREATE TABLE pagos (
    id SERIAL PRIMARY KEY,
    estadia_id INT NOT NULL,
    metodo_pago_id INT NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacion TEXT,
    usuario_id INT NOT NULL,
    CONSTRAINT fk_pago_estadia FOREIGN KEY (estadia_id) REFERENCES estadias(id),
    CONSTRAINT fk_pago_metodo FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id),
    CONSTRAINT fk_pago_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    CONSTRAINT chk_monto CHECK (monto > 0)
);
--rollback DROP TABLE pagos;
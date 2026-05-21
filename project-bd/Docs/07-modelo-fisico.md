# 07. Modelo Físico de la Base de Datos

Este documento detalla la implementación física de la base de datos para el sistema de gestión hotelera. La estructura está diseñada específicamente para el motor **PostgreSQL**, utilizando tipos de datos optimizados, restricciones de integridad referencial rígidas y una arquitectura de despliegue automatizada mediante **Docker Compose** y control de versiones con **Liquibase**.


## 1. Arquitectura de Despliegue y Tecnologías

El entorno físico de persistencia se rige bajo los siguientes parámetros de infraestructura tecnológica:

* **Motor de Base de Datos:** PostgreSQL (Imagen oficial optimizada en contenedor).
* **Despliegue Orientado a Contenedores:** Orquestación mediante `docker-compose.yml` para garantizar la reproducibilidad absoluta del ambiente de desarrollo y producción.
* **Control de Versiones del Esquema (Migraciones):** Gestión DDL y DML a través de Liquibase mediante un archivo maestro `changelog-master.xml`, garantizando la trazabilidad de los cambios y la capacidad de aplicar reversiones (*Rollbacks*).
* **Separación de Responsabilidades:** Organización estricta en el sistema de archivos separando físicamente la definición de estructuras (`ddl/`) de la carga de datos iniciales y volumétricos (`dml/`).



## 2. Diccionario de Datos Físico (Scripts DDL)

A continuación, se detalla la especificación técnica y los tipos de datos asignados a cada tabla, respetando el orden secuencial de ejecución de los scripts del proyecto:

### 2.1. `roles` (01-create-roles.sql)
* `id_rol` **SERIAL**: Llave primaria autoincremental (4 bytes).
* `nombre_rol` **VARCHAR(50)**: Nombre único del rol. Restricción `NOT NULL` y `UNIQUE`.

### 2.2. `estados` (02-create-estados.sql)
* `id_estado` **SERIAL**: Llave primaria autoincremental.
* `nombre_estado` **VARCHAR(50)**: Nombre único del estado de la habitación (Ej: 'Disponible', 'Sucia'). Restricción `NOT NULL` y `UNIQUE`.

### 2.3. `tipos` (03-create-tipos.sql)
* `id_tipo` **SERIAL**: Llave primaria autoincremental.
* `nombre_tipo` **VARCHAR(50)**: Categoría de la habitación (Ej: 'Suite', 'Doble'). Restricción `NOT NULL` y `UNIQUE`.

### 2.4. `usuarios` (04-create-usuarios.sql)
* `id_usuario` **SERIAL**: Llave primaria autoincremental.
* `id_rol` **INT**: Llave foránea que referencia a `roles(id_rol)`. Restricción `NOT NULL`.
* `nombre` **VARCHAR(100)**: Nombre del trabajador. Restricción `NOT NULL`.
* `apellido` **VARCHAR(100)**: Apellido del trabajador. Restricción `NOT NULL`.
* `correo_electronico` **VARCHAR(150)**: Correo institucional. Restricción `NOT NULL` y `UNIQUE`.
* `contraseña` **VARCHAR(255)**: Hash de seguridad de la credencial. Restricción `NOT NULL`.

### 2.5. `habitaciones` (05-create-habitaciones.sql)
* `id_habitacion` **SERIAL**: Llave primaria autoincremental.
* `id_tipo` **INT**: Llave foránea que referencia a `tipos(id_tipo)`. Restricción `NOT NULL`.
* `id_estado` **INT**: Llave foránea que referencia a `estados(id_estado)`. Restricción `NOT NULL`.
* `numero_habitacion` **VARCHAR(10)**: Identificador físico/comercial de la habitación. Restricción `NOT NULL` y `UNIQUE`.
* `precio_base` **NUMERIC(10,2)**: Soporte monetario de alta precisión. Restricción `NOT NULL` y `CHECK (precio_base >= 0)`.

### 2.6. `huespedes` (09-create-huespedes.sql)
* `id_huesped` **SERIAL**: Llave primaria autoincremental.
* `documento_huesped` **VARCHAR(20)**: Cédula o pasaporte. Restricción `NOT NULL` y `UNIQUE`.
* `nombre_huesped` **VARCHAR(100)**: Nombre completo registrado. Restricción `NOT NULL`.
* `telefono` **VARCHAR(20)**: Teléfono de contacto. Permite valores nulos.

### 2.7. `reservas` (06-create-reservas.sql)
* `id_reserva` **SERIAL**: Llave primaria autoincremental.
* `id_huesped` **INT**: Llave foránea que referencia a `huespedes(id_huesped)`. Restricción `NOT NULL`.
* `id_habitacion` **INT**: Llave foránea que referencia a `habitaciones(id_habitacion)`. Restricción `NOT NULL`.
* `fecha_checkin_prevista` **TIMESTAMP**: Fecha y hora programada de entrada. Restricción `NOT NULL`.
* `fecha_checkout_prevista` **TIMESTAMP**: Fecha y hora programada de salida. Restricción `NOT NULL`.
* `estado_reserva` **VARCHAR(30)**: Control de estado administrativo. Restricción `NOT NULL` y `CHECK (estado_reserva IN ('Activa', 'Finalizada', 'Cancelada'))`.

### 2.8. `estadias` (10-create-estadias.sql)
* `id_estadia` **SERIAL**: Llave primaria autoincremental.
* `id_reserva` **INT**: Llave foránea que referencia a `reservas(id_reserva)`. Restricción `NOT NULL` y `UNIQUE` (Relación 1:1 física).
* `fecha_ingreso_real` **TIMESTAMP**: Marca de tiempo exacta del Check-in real. Restricción `NOT NULL`.
* `fecha_salida_real` **TIMESTAMP**: Marca de tiempo exacta del Check-out real. Permite `NULL` mientras la estadía permanezca activa.

### 2.9. `asignaciones_limpieza` (07-create-asignaciones-limpieza.sql)
* `id_asignacion` **SERIAL**: Llave primaria autoincremental.
* `id_habitacion` **INT**: Llave foránea que referencia a `habitaciones(id_habitacion)`. Restricción `NOT NULL`.
* `id_usuario` **INT**: Llave foránea que referencia a `usuarios(id_usuario)`. Operario con rol de limpieza asignado. Restricción `NOT NULL`.
* `fecha_asignacion` **TIMESTAMP**: Registro de ordenamiento. Restricción `NOT NULL DEFAULT CURRENT_TIMESTAMP`.
* `hora_inicio` **TIMESTAMP**: Inicio real de la limpieza. Permite `NULL` hasta que el operario active la tarea.
* `hora_fin` **TIMESTAMP**: Conclusión de la tarea. Permite `NULL` hasta que se finalice la higienización.
* `estado_tarea` **VARCHAR(30)**: Restricción `NOT NULL` y `CHECK (estado_tarea IN ('Pendiente', 'En Proceso', 'Completada'))`.

### 2.10. `auditoria_estados` (08-create-auditoria-estados.sql)
* `id_auditoria` **SERIAL**: Llave primaria autoincremental.
* `id_habitacion` **INT**: Llave foránea que referencia a `habitaciones(id_habitacion)`. Restricción `NOT NULL`.
* `id_usuario` **INT**: Llave foránea que referencia a `usuarios(id_usuario)`. Identifica al responsable del cambio. Restricción `NOT NULL`.
* `id_estado_anterior` **INT**: Llave foránea que referencia a `estados(id_estado)`. Restricción `NOT NULL`.
* `id_estado_nuevo` **INT**: Llave foránea que referencia a `estados(id_estado)`. Restricción `NOT NULL`.
* `fecha_cambio` **TIMESTAMP**: Instante exacto del evento. Restricción `NOT NULL DEFAULT CURRENT_TIMESTAMP`.

### 2.11. `productos` (11-create-productos.sql)
* `id_productos` **SERIAL**: Llave primaria autoincremental.
* `nombre_producto` **VARCHAR(100)**: Descripción comercial del bien. Restricción `NOT NULL`.
* `precio_unitario` **NUMERIC(10,2)**: Valor base de venta. Restricción `NOT NULL` y `CHECK (precio_unitario >= 0)`.

### 2.12. `consumos` (12-create-consumos.sql)
* `id_consumo` **SERIAL**: Llave primaria autoincremental.
* `id_estadia` **INT**: Llave foránea que referencia a `estadias(id_estadia)`. Restricción `NOT NULL`.
* `id_productos` **INT**: Llave foránea que referencia a `productos(id_productos)`. Restricción `NOT NULL`.
* `cantidad` **INT**: Unidades adquiridas. Restricción `NOT NULL` y `CHECK (cantidad > 0)`.
* `precio_cobrado` **NUMERIC(10,2)**: Precio congelado al momento de la venta (evita alteraciones históricas si el producto cambia de precio base). Restricción `NOT NULL`.
* `fecha_consumo` **TIMESTAMP**: Registro del cargo. Restricción `NOT NULL DEFAULT CURRENT_TIMESTAMP`.

### 2.13. `metodos_pago` (Mapeado en dml/canonical)
* `id_metodo_pago` **SERIAL**: Llave primaria autoincremental.
* `nombre_metodo` **VARCHAR(50)**: Descripción del medio de pago ('Efectivo', 'Tarjeta credito', 'Debito', 'Transferencia'). Restricción `NOT NULL` y `UNIQUE`.

### 2.14. `pagos` (Mapeado en dml/volumetric)
* `id_pago` **SERIAL**: Llave primaria autoincremental.
* `id_estadia` **INT**: Llave foránea que referencia a `estadias(id_estadia)`. Restricción `NOT NULL`.
* `id_metodo_pago` **INT**: Llave foránea que referencia a `metodos_pago(id_metodo_pago)`. Restricción `NOT NULL`.
* `monto_total` **NUMERIC(10,2)**: Total facturado y pagado. Restricción `NOT NULL`.
* `fecha_pago` **TIMESTAMP**: Instante de la transacción financiera. Restricción `NOT NULL`.



## 3. Integridad Referencial y Acciones Físicas (Triggers y Constraints)

Para asegurar el comportamiento reactivo automatizado del negocio detallado en los requerimientos del dominio, la base de datos implementa de manera física:

1. **Estrategia de Integridad ON DELETE / ON UPDATE:**
    * Todas las relaciones entre tablas operativas e históricas implementan la cláusula `ON UPDATE CASCADE` para sincronizar cualquier mantenimiento de llaves primarias.
    * Las llaves foráneas ligadas a tablas maestras y catálogos implementan `ON DELETE RESTRICT`, impidiendo que la eliminación accidental de un rol, un estado o un producto corrompa las transacciones históricas registradas.
2. **Automatización del Flujo de Estados (Triggers Físicos):**
    * **Trigger Check-out:** Programado para ejecutarse `AFTER UPDATE` sobre la tabla `reservas` o `estadias`. Al detectar el fin del hospedaje operativo, dispara una función que realiza un `UPDATE` automático en la tabla `habitaciones` modificando su `id_estado` hacia el equivalente de **"Sucia"**.
    * **Trigger de Trazabilidad:** Programado `AFTER UPDATE` sobre la tabla `habitaciones` para que, ante cualquier mutación en la columna `id_estado`, capture el `OLD.id_estado`, el `NEW.id_estado` y el usuario en sesión, ejecutando un `INSERT` automático en la tabla `auditoria_estados`.



## 4. Scripts de Rollback (Gestión de Deshacer en Liquibase)

Cada archivo de migración gestionado por Liquibase incluye de manera explícita su bloque de reversión física (`--rollback`), asegurando que la base de datos pueda regresar a cualquier estado anterior sin dejar residuos en el diccionario de datos.

* **Ejemplo de reversión de esquema (DDL):** `DROP TABLE nombre_tabla CASCADE;`
* **Ejemplo de reversión de datos (DML):** `DELETE FROM pagos; DELETE FROM consumos; ...` (Garantizando la limpieza ordenada respetando el orden inverso de las dependencias de llaves foráneas).
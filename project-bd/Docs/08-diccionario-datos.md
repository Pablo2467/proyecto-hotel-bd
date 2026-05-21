# 08. Diccionario de Datos

Este documento contiene la especificación detallada y técnica de todas las tablas que componen la base de datos del sistema de gestión hotelera en **PostgreSQL**. Su objetivo es servir como manual de referencia para el desarrollo, mantenimiento y auditoría del sistema.

---

## 1. Módulo de Usuarios y Accesos

### 1.1. Tabla: `roles`
* **Descripción:** Catálogo maestro que define los perfiles de acceso y responsabilidades del personal.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_rol` | SERIAL | NO | PRIMARY KEY | Identificador único autoincremental del rol. |
| `nombre_rol` | VARCHAR(50) | NO | UNIQUE | Nombre descriptivo del rol (Administrador, Recepcionista, Limpieza, Auditor). |

### 1.2. Tabla: `usuarios`
* **Descripción:** Registro del personal operativo y administrativo del hotel habilitado en el sistema.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_usuario` | SERIAL | NO | PRIMARY KEY | Identificador único autoincremental del usuario. |
| `id_rol` | INT | NO | FOREIGN KEY | Referencia al rol asignado (`roles.id_rol`). |
| `nombre` | VARCHAR(100) | NO | - | Nombre(s) del empleado. |
| `apellido` | VARCHAR(100) | NO | - | Apellido(s) del empleado. |
| `correo_electronico` | VARCHAR(150) | NO | UNIQUE | Correo electrónico de inicio de sesión único. |
| `contraseña` | VARCHAR(255) | NO | - | Hash seguro de la contraseña del usuario. |

---

## 2. Módulo de Habitaciones e Infraestructura

### 2.1. Tabla: `estados`
* **Descripción:** Catálogo de estados operativos por los que atraviesa una habitación durante su ciclo operativo.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_estado` | SERIAL | NO | PRIMARY KEY | Identificador único autoincremental del estado. |
| `nombre_estado` | VARCHAR(50) | NO | UNIQUE | Estado de la habitación (Disponible, Sucia, Ocupada, Mantenimiento). |

### 2.2. Tabla: `tipos`
* **Descripción:** Definición de categorías de habitaciones comerciales y su segmentación.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_tipo` | SERIAL | NO | PRIMARY KEY | Identificador único del tipo de habitación. |
| `nombre_tipo` | VARCHAR(50) | NO | UNIQUE | Nombre de la categoría (Sencilla, Doble, Suite). |

### 2.3. Tabla: `habitaciones`
* **Descripción:** Registro físico de las unidades habitacionales disponibles en el hotel.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_habitacion` | SERIAL | NO | PRIMARY KEY | Identificador único de la habitación. |
| `id_tipo` | INT | NO | FOREIGN KEY | Referencia al tipo de habitación (`tipos.id_tipo`). |
| `id_estado` | INT | NO | FOREIGN KEY | Referencia al estado actual (`estados.id_estado`). |
| `numero_habitacion` | VARCHAR(10) | NO | UNIQUE | Número físico comercial de la habitación (Ej: '101'). |
| `precio_base` | NUMERIC(10,2) | NO | CHECK (>= 0) | Tarifa base por noche de alojamiento. |

---

## 3. Módulo de Huéspedes y Reservas

### 3.1. Tabla: `huespedes`
* **Descripción:** Registro central de clientes que adquieren o disfrutan de los servicios de hospedaje.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_huesped` | SERIAL | NO | PRIMARY KEY | Identificador único artificial del huésped. |
| `documento_huesped` | VARCHAR(20) | NO | UNIQUE | Documento de identidad legal (Cédula/Pasaporte). |
| `nombre_huesped` | VARCHAR(100) | NO | - | Nombre completo del huésped. |
| `telefono` | VARCHAR(20) | SÍ | - | Teléfono o celular de contacto del cliente. |

### 3.2. Tabla: `reservas`
* **Descripción:** Intenciones y planificación de alojamiento registradas por los clientes.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_reserva` | SERIAL | NO | PRIMARY KEY | Identificador único de la reserva. |
| `id_huesped` | INT | NO | FOREIGN KEY | Referencia al huésped titular (`huespedes.id_huesped`). |
| `id_habitacion` | INT | NO | FOREIGN KEY | Referencia a la habitación asignada (`habitaciones.id_habitacion`). |
| `fecha_checkin_prevista` | TIMESTAMP | NO | - | Fecha y hora estimada de llegada del cliente. |
| `fecha_checkout_prevista`| TIMESTAMP | NO | - | Fecha y hora estimada de salida del cliente. |
| `estado_reserva` | VARCHAR(30) | NO | CHECK (In list) | Estado de la reserva ('Activa', 'Finalizada', 'Cancelada'). |

### 3.3. Tabla: `estadias`
* **Descripción:** Ocupación real en tiempo real de una habitación vinculada al ingreso efectivo del cliente.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_estadia` | SERIAL | NO | PRIMARY KEY | Identificador único de la estancia física. |
| `id_reserva` | INT | NO | FK / UNIQUE | Vinculación única 1:1 con la reserva origen (`reservas.id_reserva`). |
| `fecha_ingreso_real` | TIMESTAMP | NO | - | Marca de tiempo exacta del Check-in real en recepción. |
| `fecha_salida_real` | TIMESTAMP | SÍ | - | Marca de tiempo exacta del Check-out real. Nulo mientras esté hospedado. |

---

## 4. Módulo de Operaciones y Mantenimiento

### 4.1. Tabla: `asignaciones_limpieza`
* **Descripción:** Órdenes de trabajo asignadas al personal de limpieza para el acondicionamiento de habitaciones sucias.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_asignacion` | SERIAL | NO | PRIMARY KEY | Identificador único de la tarea operativa. |
| `id_habitacion` | INT | NO | FOREIGN KEY | Referencia a la habitación a intervenir (`habitaciones.id_habitacion`). |
| `id_usuario` | INT | NO | FOREIGN KEY | Operario de limpieza asignado (`usuarios.id_usuario`). |
| `fecha_asignacion` | TIMESTAMP | NO | DEFAULT CurDate | Fecha y hora en la que se generó la orden de trabajo. |
| `hora_inicio` | TIMESTAMP | SÍ | - | Instante real en que el operario inicia la limpieza. |
| `hora_fin` | TIMESTAMP | SÍ | - | Instante real en que el operario culmina la higienización. |
| `estado_tarea` | VARCHAR(30) | NO | CHECK (In list) | Estado actual de la orden ('Pendiente', 'En Proceso', 'Completada'). |

### 4.2. Tabla: `auditoria_estados`
* **Descripción:** Historial de control de calidad inmutable para registrar auditorías y métricas de latencia de cambios de estado.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_auditoria` | SERIAL | NO | PRIMARY KEY | Identificador del evento registrado de forma automática. |
| `id_habitacion` | INT | NO | FOREIGN KEY | Habitación modificada (`habitaciones.id_habitacion`). |
| `id_usuario` | INT | NO | FOREIGN KEY | Empleado responsable o ejecutor del cambio (`usuarios.id_usuario`). |
| `id_estado_anterior` | INT | NO | FOREIGN KEY | Estado original de la habitación antes del evento (`estados.id_estado`). |
| `id_estado_nuevo` | INT | NO | FOREIGN KEY | Estado resultante de la habitación tras el evento (`estados.id_estado`). |
| `fecha_cambio` | TIMESTAMP | NO | DEFAULT CurDate | Timestamp exacto en que ocurrió la transición de estado. |

---

## 5. Módulo de Ventas y Finanzas

### 5.1. Tabla: `productos`
* **Descripción:** Catálogo de suministros, productos del minibar o servicios adicionales facturables.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_productos` | SERIAL | NO | PRIMARY KEY | Identificador único del consumible. |
| `nombre_producto` | VARCHAR(100) | NO | - | Nombre comercial del artículo o servicio. |
| `precio_unitario` | NUMERIC(10,2) | NO | CHECK (>= 0) | Precio de venta estándar establecido para el público. |

### 5.2. Tabla: `consumos`
* **Descripción:** Detalle de cargos extras consumidos por los huéspedes durante su estancia en el hotel.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_consumo` | SERIAL | NO | PRIMARY KEY | Identificador único de la transacción de consumo. |
| `id_estadia` | INT | NO | FOREIGN KEY | Estadía activa a la cual cargar el costo (`estadias.id_estadia`). |
| `id_productos` | INT | NO | FOREIGN KEY | Producto que fue adquirido por el cliente (`productos.id_productos`). |
| `cantidad` | INT | NO | CHECK (> 0) | Unidades consumidas por el cliente. |
| `precio_cobrado` | NUMERIC(10,2) | NO | - | Precio congelado al momento del consumo para protección histórica. |
| `fecha_consumo` | TIMESTAMP | NO | DEFAULT CurDate | Instante en que se cargó el producto a la cuenta. |

### 5.3. Tabla: `metodos_pago`
* **Descripción:** Catálogo maestro de formas de pago aceptadas en la caja del hotel.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_metodo_pago` | SERIAL | NO | PRIMARY KEY | Identificador único del medio de pago. |
| `nombre_metodo` | VARCHAR(50) | NO | UNIQUE | Nombre del medio (Efectivo, Tarjeta credito, Debito, Transferencia). |

### 5.4. Tabla: `pagos`
* **Descripción:** Transacciones financieras finales que liquidan los saldos totales de las estadías.
* **Estructura:**

| Nombre de Columna | Tipo de Datos | Nulos | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_pago` | SERIAL | NO | PRIMARY KEY | Identificador único del comprobante de pago. |
| `id_estadia` | INT | NO | FOREIGN KEY | Cuenta de estadía liquidada (`estadias.id_estadia`). |
| `id_metodo_pago` | INT | NO | FOREIGN KEY | Medio financiero utilizado (`metodos_pago.id_metodo_pago`). |
| `monto_total` | NUMERIC(10,2) | NO | - | Sumatoria total pagada por el cliente. |
| `fecha_pago` | TIMESTAMP | NO | - | Fecha y hora exacta del cierre de caja del cliente. |
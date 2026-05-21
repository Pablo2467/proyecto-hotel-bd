# 🏨 Sistema de Gestión Hotelera — Base de Datos

## Autor

**Juan Pablo Valverde Barreiro**

**Dharyn Andree Ruiz Florez**

**Nicolas Osorio Barreto**

**Vanessa Gamboa**

Sistema de base de datos relacional para la gestión operativa de un hotel, diseñado para centralizar la información de habitaciones, reservas, huéspedes, limpieza y pagos. Automatiza el ciclo de vida de los estados de las habitaciones y garantiza trazabilidad completa de cada operación.

---

## 📋 Tabla de Contenidos

- [Descripción del Problema](#-descripción-del-problema)
- [Arquitectura del Proyecto](#-arquitectura-del-proyecto)
- [Tecnologías Utilizadas](#-tecnologías-utilizadas)
- [Modelo de Datos](#-modelo-de-datos)
- [Reglas de Negocio](#-reglas-de-negocio)
- [Objetos de Base de Datos](#-objetos-de-base-de-datos)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Requisitos Previos](#-requisitos-previos)
- [Cómo Ejecutar el Proyecto](#-cómo-ejecutar-el-proyecto)
- [Consultas de Validación](#-consultas-de-validación)

---

## 🔍 Descripción del Problema

La gestión hotelera convencional sufre de **latencia de información**: cuando un huésped realiza el Check-out, existe un vacío comunicativo entre el software de recepción y el personal operativo. Sin un sistema centralizado, la disponibilidad se actualiza manualmente, provocando:

- **Cuellos de botella:** habitaciones vacías que figuran como "Ocupadas" en el sistema.
- **Fricción con el cliente:** asignación de habitaciones que aún no han sido inspeccionadas.
- **Falta de trazabilidad:** imposibilidad de medir la eficiencia del personal de limpieza o identificar demoras críticas.

### Flujo Operativo

```
Check-out → Habitación "Sucia" → Asignación de Limpieza → Ejecución → Validación → "Disponible"
                                                                              ↕
                                                                     Auditoría de Estados
```

---

## 🏗️ Arquitectura del Proyecto

El sistema se despliega con **dos contenedores Docker** que trabajan juntos:

| Contenedor | Imagen | Rol |
|---|---|---|
| `hotel_db_container` | `postgres:15` | Motor de base de datos PostgreSQL |
| `hotel_liquibase_container` | `liquibase/liquibase:4.20` | Gestor de migraciones del esquema |

---

## 🛠️ Tecnologías Utilizadas

- **PostgreSQL 15** — motor de base de datos relacional
- **Liquibase 4.20** — versionamiento y migración del esquema
- **Docker & Docker Compose** — despliegue reproducible en contenedores

---

## 📐 Modelo de Datos

El esquema está compuesto por las siguientes tablas principales:

| Tabla | Descripción |
|---|---|
| `roles` | Perfiles de acceso: Administrador, Recepcionista, Limpieza, Auditor |
| `estados_habitacion` | Estados posibles: Disponible, Sucia, Ocupada, Mantenimiento, En Limpieza |
| `tipos_habitacion` | Clasificación de habitaciones (simple, doble, suite, etc.) |
| `usuarios` | Personal del hotel vinculado a un rol |
| `habitaciones` | Unidades físicas del hotel con su estado actual |
| `huespedes` | Información de los huéspedes |
| `reservas` | Registro de reservas asociadas a habitaciones y usuarios |
| `estadias` | Estancias activas derivadas de una reserva (check-in / check-out) |
| `asignaciones_limpieza` | Órdenes de limpieza con captura de tiempos |
| `auditoria_estados` | Historial inmutable de cambios de estado de habitaciones |
| `productos` | Productos y servicios disponibles para consumo |
| `consumos` | Registro de consumos por estadía |
| `metodos_pago` | Medios de pago aceptados |
| `pagos` | Pagos realizados por estadía |

---

## 📏 Reglas de Negocio

| # | Regla |
|---|---|
| RN-01 | No se puede crear una reserva si la habitación no está en estado **"Disponible"** |
| RN-02 | Al finalizar una estadía (Check-out), la habitación pasa automáticamente a **"Sucia"** |
| RN-03 | Solo un usuario con rol **"Auditor"** o **"Admin"** puede pasar una habitación a **"Disponible"** |
| RN-04 | Un empleado de limpieza no puede tener más de una tarea en estado **"En Proceso"** simultáneamente |

---

## ⚙️ Objetos de Base de Datos

### Triggers

| Trigger | Tabla | Descripción |
|---|---|---|
| `trg_checkout_habitacion` | `estadias` | Al finalizar una estadía, cambia el estado de la habitación a `en_limpieza` |
| `trg_descuento_stock` | `consumos` | Al registrar un consumo, descuenta el stock del producto correspondiente |

### Stored Procedures

| Procedimiento | Descripción |
|---|---|
| `sp_realizar_checkin(p_reserva_id, p_huesped_id)` | Registra el ingreso del huésped y activa la estadía |
| `sp_registrar_pago(p_estadia_id, p_metodo_pago_id, p_monto, ...)` | Registra un pago asociado a una estadía activa |

### Funciones

| Función | Descripción |
|---|---|
| `fn_total_pendiente_estadia(p_estadia_id)` | Retorna el saldo pendiente de pago de una estadía |
| `fn_habitaciones_disponibles(p_tipo_id)` | Lista las habitaciones disponibles, con filtro opcional por tipo |

---

## 📁 Estructura del Proyecto

```
project-bd/
├── docker-compose.yml                  # Orquestación de contenedores
├── liquibase/
│   ├── changelog-master.xml            # Archivo maestro de migraciones
│   ├── ddl/                            # Scripts de definición de datos
│   │   ├── 01-create-roles.sql
│   │   ├── 02-create-estados.sql
│   │   ├── 03-create-tipos.sql
│   │   ├── 04-create-usuarios.sql
│   │   ├── 05-create-habitaciones.sql
│   │   ├── 06-create-reservas.sql
│   │   ├── 07-create-asignaciones-limpieza.sql
│   │   ├── 08-create-auditoria-estados.sql
│   │   ├── 09-create-huespedes.sql
│   │   ├── 10-create-estadias.sql
│   │   ├── 11-create-productos.sql
│   │   ├── 12-create-consumos.sql
│   │   ├── 13-create-metodos-pago.sql
│   │   ├── 14-create-pagos.sql
│   │   ├── 15-alter-reservas-estado.sql
│   │   ├── 16-create-triggers.xml
│   │   ├── 17-create-procedures.xml
│   │   └── 18-create-functions.xml
│   └── dml/
│       ├── canonical/                  # Datos maestros del sistema
│       │   ├── 01-insert-roles.sql
│       │   ├── 02-insert-estados.sql
│       │   ├── 03-insert-tipos.sql
│       │   ├── 04-insert-metodos-pago.sql
│       │   └── 05-insert-productos.sql
│       └── volumetric/                 # Datos de prueba
│           ├── 01-insert-test-data.sql
│           └── 02-insert-volumetric-data.sql
├── scripts/
│   └── consultas-validacion.sql        # Consultas de validación con JOINs
└── Docs/
    ├── 01-planteamiento-problema.md
    ├── 02-requerimientos.md
    ├── 03-reglas-negocio.md
    ├── 04-diagramas-iniciales.md
    └── 05-modelo-conceptual.md
```

---

## ✅ Requisitos Previos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y en ejecución
- [Docker Compose](https://docs.docker.com/compose/) (incluido en Docker Desktop)

No se requiere instalar PostgreSQL ni Liquibase de forma local.

---

## 🚀 Cómo Ejecutar el Proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/<tu-usuario>/proyecto-hotel-bd.git
cd proyecto-hotel-bd/project-bd
```

### 2. Levantar los contenedores

```bash
docker compose up
```

Esto iniciará PostgreSQL y ejecutará todas las migraciones de Liquibase automáticamente (DDL + DML).

### 3. Verificar el estado

Una vez que el contenedor de Liquibase termine (verás `UPDATE SUMMARY: Ran: X changesets`), la base de datos está lista.

### 4. Conectarse a la base de datos

Puedes conectarte con cualquier cliente SQL (DBeaver, TablePlus, psql, etc.):

| Parámetro | Valor |
|---|---|
| Host | `localhost` |
| Puerto | `5432` |
| Base de datos | `hotel_db` |
| Usuario | `admin` |
| Contraseña | `password123` |

También puedes conectarte directamente desde la terminal:

```bash
docker exec -it hotel_db_container psql -U admin -d hotel_db
```

### 5. Detener los contenedores

```bash
docker compose down
```

Para eliminar también los datos persistidos:

```bash
docker compose down -v
```

---

## 🔎 Consultas de Validación

El archivo `scripts/consultas-validacion.sql` contiene consultas con JOINs sobre 6+ tablas para validar la integridad del sistema:

**Consulta 1 — Huéspedes con estadías finalizadas:** cruza `estadias`, `huespedes`, `habitaciones`, `tipos_habitacion`, `consumos` y `pagos` para mostrar el detalle completo de hospedaje, consumos y saldo pendiente por estadía.

**Consulta 2 — Productos más consumidos por estadía:** cruza `consumos`, `productos`, `estadias`, `huespedes`, `habitaciones`, `tipos_habitacion` y `metodos_pago` para identificar los productos más facturados y el medio de pago utilizado.

Para ejecutarlas:

```bash
docker exec -it hotel_db_container psql -U admin -d hotel_db \
  -f /liquibase/changelog/scripts/consultas-validacion.sql
```

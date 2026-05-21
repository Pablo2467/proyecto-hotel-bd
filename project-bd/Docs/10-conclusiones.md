# 10. Conclusiones y Recomendaciones Futuras

Este documento presenta el balance de cierre técnico del diseño e implementación de la base de datos del sistema de gestión hotelera. Se analizan los objetivos alcanzados en términos de negocio, la viabilidad de la arquitectura tecnológica seleccionada y las pautas sugeridas para la evolución del esquema en próximas fases de desarrollo.



## 1. Conclusiones Técnicas y de Negocio

1. **Eliminación Efectiva de la Latencia Operacional:** La implementación de un flujo reactivo controlado por *Triggers* físicos en PostgreSQL solucionó con éxito el problema central de desincronización entre la recepción y el equipo operativo. Al automatizar la transición de estados de las habitaciones (`Ocupada/Disponible` $\rightarrow$ `Sucia`) inmediatamente tras el registro de salida (*Check-out*), se suprimió la dependencia de actualizaciones manuales, mitigando los cuellos de botella de disponibilidad comercial y optimizando los tiempos de respuesta del hotel.

2. **Garantía de Integridad y Calidad mediante Reglas de Negocio Robustas:** Las restricciones a nivel de servidor (tales como `CHECK constraints` para estados válidos, cláusulas `UNIQUE` para llaves alternativas y la jerarquía estricta de roles para auditorías de calidad) aseguran que los datos permanezcan íntegros, consistentes y en Tercera Forma Normal (3FN). Esto reduce significativamente la necesidad de lógica de validación duplicada en las capas de software de la aplicación (*Backend/Frontend*).

3. **Arquitectura DevOps y Mantenibilidad del Esquema:** La integración de **Liquibase** como herramienta de versionamiento del esquema DDL y DML, en sinergia con la contenedorización en **Docker**, demostró ser una solución crítica para el ciclo de vida del proyecto. Permite un despliegue inmediato, controlado y agnóstico del entorno de desarrollo. Además, la obligatoriedad de scripts de reversión (`--rollback`) inmuniza al sistema contra fallos destructivos durante las migraciones de bases de datos en entornos colaborativos o de producción.

4. **Trazabilidad Total y Auditoría inmutable:** El diseño de la tabla `auditoria_estados` cumple cabalmente con los requerimientos no funcionales de seguridad y gobernanza de datos. Al registrar marcas de tiempo automáticas (`TIMESTAMP`) e identidades inmutables de los usuarios que alteran el estado operacional de la infraestructura, la gerencia hotelera adquiere una herramienta cuantitativa para medir la eficiencia real del personal de limpieza e identificar cuellos de botella críticos en los flujos de trabajo.



## 2. Recomendaciones y Trabajo Futuro (Escalabilidad del Sistema)

Para garantizar la evolución armónica del sistema de bases de datos a medida que el hotel incremente su volumen transaccional o expanda su modelo de negocio, se proponen las siguientes implementaciones futuras:

* **Estrategia de Purga y Archivado de Históricos:** A mediano plazo, las tablas operacionales con alto crecimiento volumétrico, como `auditoria_estados` y `consumos`, acumularán millones de registros. Se recomienda implementar una estrategia de particionamiento de tablas por rangos de fechas (ej. particiones mensuales o anuales) o diseñar un proceso ETL automático para migrar registros antiguos de auditoría hacia un esquema de almacenamiento histórico en frío, manteniendo la base de datos transaccional optimizada y liviana.

* **Cifrado Avanzado de Datos Sensibles:** Aunque el campo `contraseña` en la tabla `usuarios` está diseñado para almacenar cadenas hashes complejas, se sugiere que futuras iteraciones físicas añadan cifrado a nivel de columna para datos sensibles de huéspedes (como documentos de identidad o números de contacto) utilizando extensiones nativas de PostgreSQL como `pgcrypto`, elevando los estándares de privacidad de la información.

* **Optimización mediante Índices Compuestos:** Para soportar los reportes de rendimiento y análisis cruzados en tiempo real pedidos en los requerimientos funcionales, se aconseja la creación de índices no agrupados (*B-Tree*) sobre las columnas de marcas de tiempo en las tablas `estadias` (`fecha_ingreso_real`, `fecha_salida_real`) y `asignaciones_limpieza`, evitando escaneos secuenciales completos (*Sequential Scans*) en consultas de analítica avanzadas.
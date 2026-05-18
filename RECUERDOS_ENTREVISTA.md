# 🎤 Preparación para Entrevistas: spirit-deploy86

Este es tu "machete" para explicar el proyecto. Cada respuesta dura aproximadamente 20 segundos y sigue la estructura: **Qué hice + Por qué lo hice.**

---

### 🔹 Fase 1: Imagen mínima (Python)
- **Qué hice:** Optimicé la imagen Docker mediante un build Multistage usando `python:3.11-slim` y `gunicorn`.
- **Por qué:** Para reducir la superficie de ataque, acelerar el pull de imágenes y minimizar el consumo de almacenamiento, optimizando la eficiencia del despliegue.

### 🔹 Fase 2: Infraestructura Reproducible (Terraform)
- **Qué hice:** Automaticé la creación de GKE mediante Terraform, implementando Nodos Spot (`preemptible = true`).
- **Por qué:** Para garantizar un entorno reproducible y reducir los costos operativos de infraestructura en la nube hasta en un 80%.

### 🔹 Fase 3: CI con pruebas (Actions & Jenkins)
- **Qué hice:** Implementé pipelines de CI duales con GitHub Actions y Jenkins local, incluyendo linting y pruebas unitarias con `pytest`.
- **Por qué:** Para asegurar la calidad del código antes de la construcción y demostrar versatilidad en las herramientas de CI más utilizadas del mercado.

### 🔹 Fase 4: Deploy a Dev y Smoke Tests
- **Qué hice:** Automaticé el despliegue al entorno de desarrollo y creé un script de Python para realizar validaciones de salud (Smoke Tests) post-deploy.
- **Por qué:** Para detectar fallos de conectividad o configuración de inmediato, reduciendo el tiempo de feedback tras cada cambio.

### 🔹 Fase 5: Guardias de Seguridad (Trivy)
- **Qué hice:** Integré el escáner de seguridad Trivy en el pipeline para analizar vulnerabilidades en las imágenes de contenedor.
- **Por qué:** Para implementar una cultura de "Security Left", bloqueando despliegues con CVEs críticos antes de que lleguen a producción.

### 🔹 Fase 6: Promoción con Diagnóstico y Rollback
- **Qué hice:** Gestioné fallos comunes de Kubernetes (como `CrashLoopBackOff`) y automaticé la recuperación mediante `kubectl rollout undo`.
- **Por qué:** Para demostrar capacidad de resolución de problemas bajo presión y garantizar la alta disponibilidad del servicio ante errores de configuración.

### 🔹 Fase 7: Observabilidad (Logging & Metrics)
- **Qué hice:** Instrumenté la aplicación con logs en formato JSON y métricas de Prometheus para monitorear latencia y errores.
- **Por qué:** Para permitir un diagnóstico basado en datos y obtener visibilidad completa sobre el comportamiento de la aplicación en tiempo real.

### 🔹 Fase 8: Alertas por Logs
- **Qué hice:** Configuré políticas de alertas basadas en logs que notifican automáticamente cuando se superan umbrales de error HTTP 500.
- **Por qué:** Para minimizar el tiempo medio de detección (MTTD) y responder a incidentes antes de que afecten masivamente a los usuarios.

### 🔹 Fase 9: Cierre en PR y Postmortems
- **Qué hice:** Automaticé comentarios de estado en Pull Requests y documenté postmortems de incidentes simulados en el repositorio.
- **Por qué:** Para mejorar la colaboración del equipo y generar una base de conocimiento que prevenga la recurrencia de errores técnicos.

### 🔹 Fase 10: El Pipeline End-to-End
- **Qué hice:** Integré todas las piezas en un pipeline profesional: CI -> Seguridad -> CD Dev -> Aprobación -> Producción.
- **Por qué:** Para entregar un sistema de entrega continua robusto, seguro y altamente eficiente que cumple con estándares de nivel Senior.

---
> 💡 **Tip:** En una entrevista, elige la fase que mejor responda a la pregunta del reclutador. Si preguntan por costos, ve a la Fase 2; si preguntan por calidad, ve a la Fase 3 o 5.
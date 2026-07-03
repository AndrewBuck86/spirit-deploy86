# 🕊️ Proyecto: Spirit-Deploy86 — Hoja de Ruta V2 (Especialización CI/CD y Python)

Esta hoja de ruta está diseñada para convertirte en un experto en Pipelines, enfocado en optimización de costos ("modo gasolero") y el uso avanzado de Python y Jenkins.

---

### Fase 1: Imagen mínima (Python)
- **Objetivo:** Crear imágenes ligeras para ahorrar espacio y acelerar despliegues.
- **Acciones:**
  1. Escribir un `Dockerfile` Multistage usando `python:3.11-slim`.
  2. Instalar dependencias mediante `requirements.txt`.
  3. Configurar el servidor web `gunicorn`.
  4. Probar `docker run` local y subir la imagen a Artifact Registry (0.5GB gratis).

### Fase 2: Infraestructura Reproducible (Modo Gasolero)
- **Objetivo:** Automatizar la creación y destrucción de la infraestructura.
- **Acciones:**
  1. Escribir Terraform para crear GKE Zonal, Artifact Registry y Service Accounts.
  2. **Clave de ahorro:** Usar *Nodos Spot* (`preemptible = true`).
  3. Hábito diario: `terraform apply` (al empezar) y `terraform destroy` (al terminar).

### Fase 3: CI con pruebas (Python, Actions y Jenkins)
- **Objetivo:** Dominar la integración continua en las dos herramientas más demandadas.
- **Acciones:**
  1. **Actions:** Workflow que hace checkout, setup de Python 3.11, instala dependencias y corre `pytest`.
  2. **Jenkins (Costo $0):** Levantar Jenkins local en Docker y replicar el pipeline.

### Fase 4: Deploy a Dev y Smoke Tests
- **Objetivo:** Despliegue automático y validación.
- **Acciones:**
  1. Job de CD que usa `kubectl` para aplicar el namespace de desarrollo.
  2. **Smoke test:** Script de Python en el pipeline que hace `requests.get` a `/healthz`. Si da 200 OK, sigue.

### Fase 5: Guardias de Seguridad
- **Objetivo:** Pipeline seguro antes de tocar producción.
- **Acciones:**
  1. Trivy escanea la imagen local. Si hay CVE crítico, el pipeline se pone en rojo y aborta.

### Fase 6: Promoción con Diagnóstico y Rollback
- **Objetivo:** Simular un fallo en producción y resolverlo.
- **Acciones:**
  1. Job manual despliega a Prod.
  2. Provocar un error famoso (*CrashLoopBackOff* o *ImagePullBackOff*).
  3. Usar `kubectl describe pod` y `logs` para detectar la causa.
  4. Aplicar `kubectl rollout undo` (Rollback) para salvar la situación.


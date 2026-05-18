# 🕊️ Proyecto: Spirit-Deploy86 — Hoja de Ruta V2 (Especialización CI/CD y Python)

Esta hoja de ruta está diseñada para convertirte en un experto en Pipelines, enfocado en optimización de costos ("modo gasolero") y el uso avanzado de Python y Jenkins.

---

### Fase 1: Imagen mínima (Python)
- **Objetivo:** Crear imágenes ligeras para ahorrar espacio y acelerar despliegues.
- **Acciones:**
  1. Crear `app.py` (aplicación Flask simple).
  2. Crear `requirements.txt` con `Flask` y `gunicorn`.
  3. Escribir un `Dockerfile` Multistage usando `python:3.11-slim` para instalar dependencias y configurar `gunicorn`.
  4. Probar la imagen localmente con `docker run` y subirla a Artifact Registry, etiquetándola adecuadamente.

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

### Fase 7: Observabilidad
- **Objetivo:** Ver lo que pasa por dentro de la app Python.
- **Acciones:**
  1. App Python usa `logging` en JSON (`severity`, `status`).
  2. Expone `/metrics` con `prometheus_client`.
  3. Configurar dashboard básico para ver peticiones y latencia.

### Fase 8: Alertas por logs
- **Objetivo:** Que el clúster te avise cuando algo se rompe.
- **Acciones:**
  1. Política en Cloud Logging: filtro `severity>=ERROR` y `status>=500`.
  2. Si ocurre 5 veces en 10 min, dispara una alerta (simulada por email o en consola).

### Fase 9: Cierre en PR
- **Objetivo:** Dejar todo documentado como un profesional.
- **Acciones:**
  1. El Workflow comenta en el PR de GitHub: "Deploy dev OK, prod a la espera".
  2. Documentar el Postmortem del error de la Fase 6 en el README (causa, fix, acción preventiva).

### Fase 10: Pipeline Robusto y Automatizado (El Gran Final)
- **Objetivo:** Unir todas las piezas.
- **Acciones:**
  1. Tienes un pipeline completo: CI → Guardias (Trivy) → CD Dev → Aprobación → Prod.
  2. Todo versionado, con rollback documentado y alertas activas.
  3. **Resultado:** Un proyecto nivel Senior listo para lucir en tu CV y repositorio.

---
**Comando de inicialización de proyecto:**
```bash
gcloud config set project spirit-deploy86
```
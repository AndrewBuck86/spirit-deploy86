# 🕊️ Spirit-Deploy86: Automatización de Infraestructura y Despliegue Continuo

Este proyecto demuestra la implementación de un ciclo de vida de desarrollo de software (SDLC) moderno, abarcando desde la contenedorización de microservicios hasta la orquestación en la nube mediante prácticas de **GitOps** e **Infraestructura como Código (IaC)**.

## 🚀 Stack Tecnológico
*   **Lenguaje:** Python 3.11 (Flask).
*   **Contenedorización:** Docker (imágenes optimizadas `slim`).
*   **Infraestructura como Código:** Terraform (Provisionamiento de GKE y Artifact Registry).
*   **Orquestación:** Google Kubernetes Engine (GKE).
*   **CI/CD:** GitHub Actions (Pipeline principal) & Jenkins (Validación local).
*   **Seguridad:** Workload Identity Federation (GCP + GitHub).

---

## 🏗️ Ingeniería del Proyecto (Fases 1-6)

### 1. Imagen mínima (Python)
Diseño de un `Dockerfile` multietapa utilizando imágenes base ligeras (`python:3.11-slim`) para minimizar el tamaño y acelerar los despliegues. Se gestionan las dependencias con `uv` y se configura `gunicorn` como servidor web de producción. La imagen resultante se prueba localmente y se sube a Google Artifact Registry.

### 2. Infraestructura Reproducible (Modo Gasolero)
Uso de **Terraform** para el provisionamiento declarativo y reproducible de la infraestructura en Google Cloud Platform. Esto incluye la creación de clústeres GKE zonales, repositorios en Artifact Registry y Service Accounts. Se prioriza la optimización de costos mediante el uso de *Nodos Spot* (`preemptible = true`), fomentando el hábito diario de `terraform apply` y `terraform destroy`.

### 3. CI con pruebas (Python, Actions y Jenkins)
Implementación de un pipeline de CI con **GitHub Actions** que automatiza el proceso de validación del código. Este workflow realiza el checkout del repositorio, configura Python 3.11, instala las dependencias y ejecuta la suite de pruebas unitarias con `pytest`. Adicionalmente, se replica este pipeline en una instancia local de **Jenkins** (con costo $0) para validación en entornos controlados.

### 4. Deploy a Dev y Smoke Tests
Configuración de un Job de Despliegue Continuo (CD) que utiliza `kubectl` para aplicar los manifiestos de Kubernetes en un namespace de desarrollo. Tras el despliegue, se ejecutan *Smoke Tests* automatizados mediante un script de Python que realiza una petición `requests.get` al endpoint `/healthz`, asegurando que la aplicación responda con un `200 OK` antes de proceder.

### 5. Guardias de Seguridad
Integración de medidas de seguridad proactivas en el pipeline. Se utiliza **Trivy** para escanear la imagen Docker local en busca de vulnerabilidades (CVEs). Si se detecta alguna vulnerabilidad crítica, el pipeline se detiene automáticamente, impidiendo el despliegue de imágenes inseguras.

### 6. Promoción con Diagnóstico y Rollback
Implementación de un proceso de promoción a producción que incluye un Job manual para el despliegue. Se simulan y diagnostican fallos comunes en Kubernetes, como `CrashLoopBackOff` o `ImagePullBackOff`, utilizando herramientas como `kubectl describe pod` y `kubectl logs`. Se demuestra la capacidad de realizar un `rollback` rápido y seguro con `kubectl rollout undo` para mitigar incidentes en producción.

---

## 🛠️ Guía de Uso Local

Para los desarrolladores que deseen replicar el entorno de pruebas:

1.  **Inicializar el entorno:**
    ```bash
    chmod +x run.sh
    ./run.sh  # Instala dependencias y prepara el entorno virtual
    ```
2.  **Ejecutar la suite de pruebas:**
    ```bash
    ./run.sh test
    ```

---
*Este repositorio es una muestra técnica de integración de herramientas Cloud Native, enfocada en la eficiencia operativa y la seguridad.*

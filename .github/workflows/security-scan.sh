#!/bin/bash
# Script para la Fase 5: Guardias de Seguridad
IMAGE_NAME=$1

echo "🔍 Escaneando imagen: $IMAGE_NAME con Trivy..."

# --exit-code 1: Si encuentra vulnerabilidades, el script falla (útil para CI/CD)
# --severity CRITICAL: Solo nos detenemos por fallos críticos
# --no-progress: Limpia la salida para logs de CI

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasecurity/trivy:latest image --exit-code 1 --severity CRITICAL $IMAGE_NAME
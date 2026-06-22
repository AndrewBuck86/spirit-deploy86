#!/bin/bash
# Script para la Fase 5: Guardias de Seguridad
IMAGE_NAME=$1

if [ -z "$IMAGE_NAME" ]; then
  echo "❌ Error: Debes proporcionar el nombre de una imagen."
  echo "Uso: ./security-scan.sh nombre-de-la-imagen:tag"
  exit 1
fi

echo "🔍 Escaneando imagen: $IMAGE_NAME con Trivy..."

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasecurity/trivy:latest image --exit-code 1 --severity CRITICAL "$IMAGE_NAME"
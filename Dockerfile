# Etapa 1: Builder
FROM python:3.11-slim AS builder

WORKDIR /app

# Evita que Python genere archivos .pyc y permite logs en tiempo real
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Etapa 2: Final
FROM python:3.11-slim

# Crear un usuario no privilegiado para correr la app
RUN addgroup --system appgroup && adduser --system --group --home /home/appuser appuser

WORKDIR /app

# Copiamos solo las librerías instaladas desde el builder
COPY --from=builder --chown=appuser:appgroup /root/.local /home/appuser/.local
COPY --chown=appuser:appgroup . .

# Aseguramos que los binarios instalados estén en el PATH
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONPATH=/home/appuser/.local/lib/python3.11/site-packages
USER appuser

EXPOSE 8080

CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8080", "app:app"]
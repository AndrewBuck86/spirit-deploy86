# Etapa 1: Builder
FROM python:3.11-slim AS builder

WORKDIR /app
COPY requirements.txt .

# Instalamos dependencias en un directorio específico
RUN pip install --user --no-cache-dir -r requirements.txt

# Etapa 2: Final
FROM python:3.11-slim

# Creamos un usuario para no correr como root
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

# Copiamos las librerías desde el builder al nuevo usuario
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

# Cambiamos la propiedad de los archivos
RUN chown -R appuser:appuser /app

USER appuser

ENV PATH=/home/appuser/.local/bin:$PATH

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]

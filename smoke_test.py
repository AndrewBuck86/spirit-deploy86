import requests
import sys
import time

def check_health(url):
    """
    Valida la salud de la aplicación mediante reintentos.
    """
    target = f"{url.rstrip('/')}/healthz"
    print(f"🚀 Iniciando Smoke Test en: {target}")
    
    for i in range(5):
        try:
            response = requests.get(target, timeout=5)
            if response.status_code == 200:
                print("✅ Smoke Test EXITOSO: La app está saludable.")
                sys.exit(0)
            print(f"⚠️ Intento {i+1}: Status {response.status_code}. Reintentando...")
        except Exception as e:
            print(f"⚠️ Intento {i+1}: Fallo de conexión ({e}). Reintentando...")
        time.sleep(10)

    print("❌ Smoke Test FALLIDO tras 5 intentos.")
    sys.exit(1)

if __name__ == "__main__":
    # Uso: python3 smoke_test.py http://<EXTERNAL-IP>
    app_url = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:8080"
    check_health(app_url)
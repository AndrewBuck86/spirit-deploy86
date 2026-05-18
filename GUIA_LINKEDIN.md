# 📸 Guía de Capturas y Videos para LinkedIn (Build in Public)

Esta guía es tu "machete" para recordar cómo y cuándo documentar tu proyecto **spirit-deploy86 🕊️** para brillar en LinkedIn.

---

## 🎥 Cómo Grabar Video (La magia en movimiento)
**Atajo en Windows:** Presiona `Windows + Alt + R` 
*(Esto abre la barra de juegos de Xbox y empieza a grabar tu pantalla al instante. Para detener, vuelve a presionar lo mismo o usa el botón flotante).*

> 🔇 **¡TIP DE ORO! Grabar sin audio:**
> Antes de empezar, presiona `Windows + G`. En el cuadrito de **Captura**, haz clic en el ícono del micrófono para que aparezca tachado. 
> También puedes usar `Windows + Alt + M` para mutearlo rápido. Así el video se genera mudo y no tienes que editar nada.

**Alternativa (Extensiones Web súper recomendadas):** 
Puedes instalar extensiones gratuitas en Chrome como **Loom** o **Screencastify**. Graban tu navegador, tu voz (si quieres explicar lo que haces) y te dan un link listo para pegar en LinkedIn. ¡Ideales para mostrar tu consola de Cloud Shell!

> 💡 **Tip de Emergencia (Audio y Ruido):** 
> No hace falta grabar de nuevo si el audio no es perfecto.
> 
> **Nota:** Si la terminal dice `command not found`, instálalo con:
> `sudo apt-get update && sudo apt-get install -y ffmpeg`
> 
> **Opción A: Quitar el ruido y mantener tu voz**
> `ffmpeg -i entrada.mp4 -af "afftdn" salida_limpia.mp4`
> 
> **Opción B: Limpiar ruido + Subir volumen (Recomendado para hablar a cámara)**
> `ffmpeg -i entrada.mp4 -af "afftdn, volume=1.5" salida_pro.mp4`
> 
> **Opción C: Dejar el video totalmente mudo**
> `ffmpeg -i entrada.mp4 -an -vcodec copy salida.mp4`
> 
> **Procesar todos los videos para limpiar ruido:**
> `for f in VID_*.mp4; do ffmpeg -i "$f" -af "afftdn, volume=1.5" "limpio_fuerte_${f}"; done`

> **Opción D: Unir todos los videos en uno solo (Concatenar)**
> 1. Crea la lista (asegurate de ponerlos en orden):
> `printf "file '%s'\n" limpio_fuerte_VID_1.mp4 limpio_fuerte_VID_2.mp4 limpio_fuerte_VID_3.mp4 > lista.txt`
> 2. Pegalos sin perder calidad:
> `ffmpeg -f concat -safe 0 -i lista.txt -c copy video_final_listo.mp4`
> *¡Listo! Bajás un solo archivo y ya está editado el audio.*

**📥 Cómo descargar videos de Cloud Shell:**
En el Explorer izquierdo, clic derecho al archivo `.mp4` -> **Download**.

**¿Cuándo grabar video? (Momentos Épicos)**
1. **Fase 4 (CD y Smoke Tests):** Graba la pantalla dividida: a un lado tu Jenkins o GitHub Actions corriendo en verde, y al otro lado el script de Python confirmando que `/healthz` da un 200 OK.
2. **Fase 6 (Diagnóstico y Rollback):** Graba cómo falla la app (CrashLoopBackOff), muestra cómo usas `kubectl describe pod` para hallar el error y cómo lo salvas ejecutando `kubectl rollout undo`. ¡Oro para los reclutadores!
3. **Fase 10 (Pipeline Robusto Final):** Un video corto haciendo un `git push` y mostrando el recorrido completo: CI -> Trivy -> Dev -> PR -> Prod.

---

## 🖼️ Cómo Tomar Capturas de Pantalla (Para posts rápidos)
**Atajo en Windows:** Presiona `Windows + Shift + S`
*(Esto congela la pantalla y te permite seleccionar con el mouse exactamente el cuadrito que quieres capturar. Luego vas a LinkedIn y le das "Pegar" o Ctrl+V).*

**¿Qué capturar? (Tus Trofeos)**
- **Fase 1:** Captura la terminal mostrando el tamaño diminuto de tu imagen usando `python:3.11-slim` en un Multistage.
- **Fase 2:** Captura de tu código Terraform con `preemptible = true` junto al output `Apply complete!`.
  *Títulos sugeridos:* "Infra Live", "Terraform Apply" o "Spot Nodes".
- **Fase 3:** Captura de tu pipeline pasando los tests de `pytest` con éxito.
- **Fase 5:** Captura del escáner Trivy abortando un despliegue por vulnerabilidades críticas o mostrando `0 CRITICAL`.
- **Fase 7/8:** Captura de una alerta disparada por logs (filtro `status>=500`) o de tus métricas Prometheus en acción.

---

## 💰 Alerta de Costos (El "Modo Gasolero")
Tener en cuenta para este proyecto:
1. **Artifact Registry:** Aprovecha el tier gratuito (0.5GB al mes). Limpia imágenes viejas o usa los tags de forma eficiente.
2. **GKE Zonal & Spot:** Usar Zonal en lugar de Regional y Nodos Spot (`preemptible = true`) recorta los costos enormemente (hasta un 80% más barato).
3. **Regla de Oro (Infraestructura Efímera):** Empieza el día con `terraform apply`. Termina el día obligatoriamente con `terraform destroy`. No dejes nada encendido mientras duermes.

---

## 💡 Estructura de un Buen Post en LinkedIn
Cuando subas tu video o captura, usa esta fórmula:
1. **El Gancho:** "¿Sabías que puedes reducir el costo de tu clúster GKE en un 80%?" o "Hoy automaticé mi primer despliegue a producción..."
2. **El Problema:** "Normalmente, desplegar a mano es lento y propenso a errores humanos."
3. **La Solución (Lo que hiciste):** "Armé un pipeline que testea mi código Python 3.11, construye una imagen ligera y la despliega en un clúster de Kubernetes optimizado en costos."
4. **Las Herramientas (Hashtags):** #DevOps #Kubernetes #Python #GCP #CI_CD #Jenkins #Terraform

> **Nota del Asistente (Gemini):** Durante nuestras sesiones, usaré la etiqueta **📸 ¡MOMENTO LINKEDIN!** para avisarte cuándo es un buen momento para usar estos atajos.
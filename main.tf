provider "google" {
  project = "spirit-deploy86"
  region  = "us-central1"
}

# 1. El Almacén: Donde guardaremos nuestras imágenes de Python
resource "google_artifact_registry_repository" "mi_repositorio" {
  location      = "us-central1"
  repository_id = "imagenes-proyecto"
  description   = "Repositorio para las imágenes de spirit-deploy86"
  format        = "DOCKER"
}

# 2. El Cerebro: El Clúster de Kubernetes (GKE)
# Configuramos un clúster "nativo de VPC" y le decimos que no cree nodos por defecto
# porque queremos crear nuestros propios nodos "Spot" más adelante.
resource "google_container_cluster" "primary" {
  name     = "spirit-cluster"
  location = "us-central1-a"

  # Eliminamos el pool de nodos por defecto para tener control total
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false # Permite que 'terraform destroy' funcione sin problemas
}

# 3. Los Músculos: El Pool de Nodos Spot
# Aquí es donde ocurre la magia del ahorro.
resource "google_container_node_pool" "spot_nodes" {
  name       = "pool-economico"
  location   = "us-central1-a"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    # "preemptible = true" define que son nodos Spot (baratos)
    preemptible  = true
    machine_type = "e2-medium" # Una máquina equilibrada y económica

    # Permisos mínimos para que el nodo pueda hablar con Google Cloud
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Salidas útiles: Para saber qué se creó al terminar
output "instruccion_conexion" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location}"
}
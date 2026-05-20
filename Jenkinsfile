pipeline {
    agent any

    // Define el ID de tu proyecto de GCP y el repositorio de Artifact Registry
    // Estos valores se obtienen de tu archivo main.tf
    // project = "spirit-deploy86", repository_id = "imagenes-proyecto"
    environment {
        PYTHON_VERSION = '3.11'
        // Variables para GCP basadas en main.tf
        GCP_PROJECT_ID = 'spirit-deploy86'
        GCP_REPOSITORY = 'imagenes-proyecto'
    }

    stages {
        stage('1. Clonando el código') {
            steps {
                checkout scm
            }
        }

        stage('2. Instalando Dependencias') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt pytest flake8
                '''
            }
        }

        stage('3. Linter (Flake8)') {
            steps {
                sh '''
                    . venv/bin/activate
                    # Combinamos las reglas de flake8 y eliminamos --exit-zero para que la etapa falle si hay errores.
                    flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics --max-complexity=10 --max-line-length=127
                '''
            }
        }

        stage('4. Pruebas Unitarias (Pytest)') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest
                '''
            }
        }
    }
    post {
        always {
            echo 'Limpiando el entorno...'
            deleteDir()
        }
        success {
            echo 'Pipeline completado exitosamente.'
        }
        failure {
            echo 'Pipeline falló. Revisa los logs.'
        }
    }
}
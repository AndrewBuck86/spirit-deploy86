pipeline {
    agent any

    environment {
        PYTHON_VERSION = '3.11'
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

        stage('3. Corriendo Pruebas y Linter') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest
                    flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
                '''
            }
        }
    }
}
pipeline {
    agent any

    environment {
        PYTHON_ENV = "venv"
    }

    stages {
        stage('Prepare Environment') {
            steps {
                sh "python3 -m venv ${PYTHON_ENV}"
                sh ". ${PYTHON_ENV}/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"
            }
        }

        stage('Unit Tests') {
            steps {
                sh ". ${PYTHON_ENV}/bin/activate && pytest"
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
    }
}
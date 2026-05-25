pipeline {
    agent any

    stages {
        stage('Environment & Tests') {
            steps {
                sh "chmod +x run.sh"
                sh "./run.sh test"
            }
        }
    }

    post {
        success {
            echo '✅ ¡Pruebas superadas exitosamente!'
        }
        failure {
            echo '❌ El pipeline falló. Revisa los logs de run.sh'
        }
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
    }
}
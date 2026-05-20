pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Setup Python and Dependencies') {
            steps {
                sh 'python3.11 -m ensurepip --upgrade'
                sh 'python3.11 -m pip install uv'
                sh 'uv venv'
                sh '. .venv/bin/activate && uv pip install -e .[dev]'
            }
        }
        stage('Run Ruff Checks') {
            steps {
                sh '. .venv/bin/activate && uv run ruff check .'
            }
        }
        stage('Run Pyright Checks') {
            steps {
                sh '. .venv/bin/activate && uv run pyright'
            }
        }
        stage('Run Tests') {
            steps {
                sh '. .venv/bin/activate && uv run python3 -m unittest discover'
            }
        }
    }
}
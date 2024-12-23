pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'docker buildx build --platform linux/amd64 -t angulardavidapp.azurecr.io/my-angular-app:latest .'
            }
        }
        stage('Push') {
            steps {
                sh 'docker push angulardavidapp.azurecr.io/my-angular-app:latest'
            }
        }
    }
}
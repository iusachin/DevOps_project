pipeline {
    agent { label 'maven' }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/iusachin/DevOps_project.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean deploy'
            }
        }
    }
}
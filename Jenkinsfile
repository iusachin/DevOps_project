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
                sh 'mvn clean deploy -DskipTests'
            }
        }

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'Sonar'   // SonarScanner installation name in Jenkins
            }
            steps {
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}
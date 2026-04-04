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
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('test') {
    steps {
        echo "*********** Test stage started ***********"
        sh 'mvn test'
        echo "*********** Test stage completed ***********"
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
        stage('Quality Gate') {
    steps {
        script {
            // Wait for the Quality Gate result (max 1 hour timeout just to be safe)
            timeout(time: 1, unit: 'HOURS') {
                def qg = waitForQualityGate()   // provided by SonarQube plugin
                if (qg.status != 'OK') {
                    error "Pipeline aborted due to quality gate failure: ${qg.status}"
                }
            }
        }
    }
}
       stage('Docker Build & Push') {
    steps {
        script {
            sh '''
                echo "Building Docker image..."

                docker build -t demo-workshop:latest .

                echo "Image built successfully!"
            '''
        }
    }
}
    }
}
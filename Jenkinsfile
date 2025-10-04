pipeline {
    agent any

    environment {
        IMAGE_NAME = 'sheikhitech/azure-jenkins-repo'	//Dockerhub user/repository
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/hapheej-shekh/spring-cicd-jenkins-azure.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                sh '''
                docker stop azure-jenkins-image || true
                docker rm azure-jenkins-image || true
				
                # Run the new container
                docker run -d -p 8084:8080 --name azure-jenkins-image ${IMAGE_NAME}:${BUILD_NUMBER}
                '''
            }
        }
    }

    post {
        success {
            echo '🚀 Deployment Success!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}

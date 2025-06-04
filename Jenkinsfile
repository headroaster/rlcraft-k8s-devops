pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "headroaster/rlcraft-server:latest"
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-credentials'    // Jenkins credentials ID for kubeconfig
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-credentials'      // Jenkins credentials ID for DockerHub or your registry
        NAMESPACE = 'rlcraft'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/headroaster/rlcraft-k8s-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS_ID) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                    export KUBECONFIG=$KUBECONFIG_FILE
                    kubectl apply -f k8s/ -n $NAMESPACE
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Deployment succeeded!"
        }
        failure {
            echo "Deployment failed!"
        }
    }

    triggers {
        // Daily backup trigger at 3am UTC; adjust as needed
        cron('H 3 * * *')
    }

    // Backup stage can be a separate job or inside here as a separate stage depending on design.
}


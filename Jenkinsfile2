pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "headroaster/rlcraft"
    DOCKER_TAG = "latest"
    REGISTRY_CREDENTIALS = credentials('dockerhub-credentials')
  }

  stages {
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
      }
    }

    stage('Push Docker Image') {
      steps {
        sh """
          echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin
          docker push $DOCKER_IMAGE:$DOCKER_TAG
        """
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }

  post {
    failure {
      echo "Deployment failed!"
    }
  }
}


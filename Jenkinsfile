pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
      defaultContainer 'kaniko'
      workspaceVolume emptyDirWorkspaceVolume()
    }
  }

  environment {
    DOCKER_IMAGE = "docker.io/headroaster/rlcraft-server"
    DOCKER_TAG = "latest"
  }

  stages {
    stage('Build and Push with Kaniko') {
      steps {
        container('kaniko') {}
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


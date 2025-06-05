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
    stage('Build Image') {
      steps {
        echo 'Kaniko container should build and push automatically on startup.'
      }
    }

    stage('Deploy') {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }

  post {
    failure {
      echo "Pipeline failed."
    }
  }
}


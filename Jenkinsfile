pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
      defaultContainer 'kaniko'
      workspaceVolume hostPathWorkspaceVolume('/home/jenkins/agent')
    }
  }

  environment {
    DOCKER_IMAGE = "docker.io/headroaster/rlcraft-server"
    DOCKER_TAG = "latest"
  }

  stages {
    stage('Build and Push with Kaniko') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --dockerfile=/workspace/Dockerfile \
              --context=dir:///workspace \
              --destination=$DOCKER_IMAGE:$DOCKER_TAG \
              --verbosity=info
          '''
        }
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


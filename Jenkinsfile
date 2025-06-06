pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
      defaultContainer 'jnlp'
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
              --dockerfile=/home/jenkins/agent/workspace/rlcraft-deploy/Dockerfile \
              --context=dir:///home/jenkins/agent/workspace/rlcraft-deploy \
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


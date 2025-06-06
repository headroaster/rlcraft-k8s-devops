pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
    }
  }

  stages {
    stage('Build and Push Image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --dockerfile=/home/jenkins/agent/workspace/rlcraft-deploy/Dockerfile \
              --context=dir:///home/jenkins/agent/workspace/rlcraft-deploy \
              --destination=docker.io/headroaster/rlcraft-server:latest \
              --verbosity=info
          '''
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        container('kubectl') {
          sh 'kubectl apply -f /home/jenkins/agent/workspace/rlcraft-deploy/k8s/'
        }
      }
    }
  }
}


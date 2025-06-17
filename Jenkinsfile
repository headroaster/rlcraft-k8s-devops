pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
    }
  }

  stages {
    stage('Debug Workspace') {
      steps {
        container('kaniko') {
          sh '''
            echo "WORKSPACE:"
            ls -alh /home/jenkins/agent/workspace
            echo "Search for Dockerfile:"
            find /home/jenkins/agent/workspace -name Dockerfile
          '''
        }
      }
    }

    stage('Build and Push Image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --dockerfile=/home/jenkins/agent/workspace/roastcraft rlcraft/Dockerfile \
              --context=dir:///home/jenkins/agent/workspace \
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


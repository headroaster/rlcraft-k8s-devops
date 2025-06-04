pipeline {
  agent {
    kubernetes {
      yamlFile 'kaniko-pod.yaml'
    }
  }
  environment {
    IMAGE_NAME = 'headroaster/rlcraft:latest'
  }
  stages {
    stage('Build and Push with Kaniko') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --dockerfile=Dockerfile \
              --context=`pwd` \
              --destination=${IMAGE_NAME} \
              --insecure \
              --skip-tls-verify
          '''
        }
      }
    }
  }
}


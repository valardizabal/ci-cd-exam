pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ci-exam-docker-image'
        IMAGE_TAG = ${env.BUILD_ID}
        HELM_RELEASE_NAME = 'ci-exam-helm-release'
        HELM_CHART_DIR = 'helm-chart'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/valardizabal/ci-cd-exam']])
                }
            }
        }
        // stage('Use Minikube Docker Daemon') {
        //     steps {
        //         script {
        //             sh 'eval "$(minikube docker-env)"'
        //         }
        //     }
        // }
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
        //         }
        //     }
        // }
        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
        //         }
        //     }
        // }
        // stage('Deploy with Helm') {
        //     steps {
        //         script {
        //             sh "helm upgrade --install ${HELM_RELEASE_NAME} ./${HELM_CHART_DIR}"
        //         }
        //     }
        // }
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             sh 'kubectl get pods'
        //             sh 'kubectl get deployments'
        //             // sh 'kubectl wait --for=condition=available --timeout=60s deployment/ci-exam-deployment'
        //             // sh 'kubectl run test-pod --image=${IMAGE_NAME}:${IMAGE_TAG} --restart=Never --command -- /bin/sh -c "echo Hello World"'
        //             // sh 'kubectl wait --for=condition=ready pod/test-pod --timeout=60s'
        //             // sh 'kubectl logs test-pod'
        //         }
        //     }
        // }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully! Access main.html via Minikube service or port-forward.'
        }
        failure {
            echo '❌ Pipeline failed! Check logs and try again'
        }
    }
}
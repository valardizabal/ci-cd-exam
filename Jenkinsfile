pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ci-exam-docker-image'
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
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                    sh "echo 'Docker image built: ${IMAGE_NAME}:${env.BUILD_ID}'"
                }
            }
        }
        stage('Deploy with Helm') {
            steps {
                script {
                    kubeconfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCakNDQWU2Z0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJMU1EY3lNREF6TkRReE9Gb1hEVE0xTURjeE9UQXpORFF4T0Zvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTWY0Cm1iRDR3MDJKZnptdVRNS0VZU20zWnpQOWFMS2t1eGhKTkZXaVRaMGt5N3lrNGdNeStDeDZwNGVFUVhReGFKMGwKZUgwOFhuZ01EQ1BiUHFZaWowRENaUzdwYzhCdXdqZzA0SHhGTnQ4WFU0TEhZVVRkME1vd0g0ajczTit4VzRsUgp4dEw3c2xRNWR0U1ArRVIvMkpERC92cjJMYTU0cWRkZkRjUHJ5QTUzU1RoR3N5a2tDWXZhb1lOQXRBYkk5aVBqCkhhTXJUbFVDTm1lZHV2UGlkK1lGdEhYK215ZjBNT1VyMFd6a2pSUXg3Ym5VRllRRk5yYmJ4MzBkanBKVExSSGEKdUQ5dkxCZlNhS0pjd1hXVDFzVnE0M1RYai9EWUw0U3AyZG1rMjhPVzdHcGc1NzhhRitiRUZhSnpQUEx5VUlMWApoRnJzN1YvaWtKRlI0Qno3OEQwQ0F3RUFBYU5oTUY4d0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVcKQkJRTzAwbGdnMW9zUXJDMkVhN01zbHA2WFNmbml6QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUF0L3VBKzZQaApPaEgwTkJ2QkdmVHNMcXlFc3pJUG9TR3NUY1Yvb2VvSXRxOFJEYkFYc2NIM0VXbm80RVhKN0ZscVo4SU1KZFcyClJPbnVpc2o4dDY5TE9jT3NQUDE1Nk9oOEdJeS9FYU84UmFNMzVKZVlXS25CL1BIdmxtQzZoY253VDdEUzYxSTgKYkJVOVJWalVQdEF5aVhjUUFGY2hZZkFwTDk5OWdBVVBWbmFxQlI2aUNWUmxzS21rOGlqMjZWNldaTHhEZk03UQo0cjI2RlJMT2piWmx5QlNxSE44dHJuT212TFFTNW9kQi9JZnlKVXdNMW1tSE9MS0w3MXlDd1g0SmpZR3NRQTF0Cks4VnRvcmhWZEpWdFBFUzlsRFQ2WThlb1dyOVR2NDR0RzJNcUk5SXJvemtrMk5WbVpsWWNvcjllNUgva2N0ZWIKaE5kUEhUT056NUNlVXc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==', credentialsId: 'minikube', serverUrl: 'https://192.168.49.2:8443') {
                        sh "minikube image load ${IMAGE_NAME}:${env.BUILD_ID}"
                        sh "echo 'Docker image loaded into Minikube: ci-exam-docker-image:${env.BUILD_ID}'"
                        
                        sh "helm install ${HELM_RELEASE_NAME} ./${HELM_CHART_DIR} --set image.tag=${env.BUILD_ID}"
                        sh "echo 'Helm release ${HELM_RELEASE_NAME} deployed with image tag ${env.BUILD_ID}'"
                    }
                }
            }
        }
        stage('Validate Deployment') {
            steps {
                script {
                    kubeconfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCakNDQWU2Z0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJMU1EY3lNREF6TkRReE9Gb1hEVE0xTURjeE9UQXpORFF4T0Zvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTWY0Cm1iRDR3MDJKZnptdVRNS0VZU20zWnpQOWFMS2t1eGhKTkZXaVRaMGt5N3lrNGdNeStDeDZwNGVFUVhReGFKMGwKZUgwOFhuZ01EQ1BiUHFZaWowRENaUzdwYzhCdXdqZzA0SHhGTnQ4WFU0TEhZVVRkME1vd0g0ajczTit4VzRsUgp4dEw3c2xRNWR0U1ArRVIvMkpERC92cjJMYTU0cWRkZkRjUHJ5QTUzU1RoR3N5a2tDWXZhb1lOQXRBYkk5aVBqCkhhTXJUbFVDTm1lZHV2UGlkK1lGdEhYK215ZjBNT1VyMFd6a2pSUXg3Ym5VRllRRk5yYmJ4MzBkanBKVExSSGEKdUQ5dkxCZlNhS0pjd1hXVDFzVnE0M1RYai9EWUw0U3AyZG1rMjhPVzdHcGc1NzhhRitiRUZhSnpQUEx5VUlMWApoRnJzN1YvaWtKRlI0Qno3OEQwQ0F3RUFBYU5oTUY4d0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVcKQkJRTzAwbGdnMW9zUXJDMkVhN01zbHA2WFNmbml6QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUF0L3VBKzZQaApPaEgwTkJ2QkdmVHNMcXlFc3pJUG9TR3NUY1Yvb2VvSXRxOFJEYkFYc2NIM0VXbm80RVhKN0ZscVo4SU1KZFcyClJPbnVpc2o4dDY5TE9jT3NQUDE1Nk9oOEdJeS9FYU84UmFNMzVKZVlXS25CL1BIdmxtQzZoY253VDdEUzYxSTgKYkJVOVJWalVQdEF5aVhjUUFGY2hZZkFwTDk5OWdBVVBWbmFxQlI2aUNWUmxzS21rOGlqMjZWNldaTHhEZk03UQo0cjI2RlJMT2piWmx5QlNxSE44dHJuT212TFFTNW9kQi9JZnlKVXdNMW1tSE9MS0w3MXlDd1g0SmpZR3NRQTF0Cks4VnRvcmhWZEpWdFBFUzlsRFQ2WThlb1dyOVR2NDR0RzJNcUk5SXJvemtrMk5WbVpsWWNvcjllNUgva2N0ZWIKaE5kUEhUT056NUNlVXc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==', credentialsId: 'minikube', serverUrl: 'https://192.168.49.2:8443') {
                        sh 'kubectl get nodes'
                        sh 'kubectl get pods'
                        sh 'kubectl get deployments'
                    }
                }
            }
        }
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
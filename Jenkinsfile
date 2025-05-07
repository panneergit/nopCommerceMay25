pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {

        stage("Git Checkout") {
            steps {
                git url: 'https://github.com/panneergit/nopCommerceMay25.git',
                branch: 'develop'
            }
        }

        stage("Build Docker Image") {
            steps {
                sh 'docker image build -t panneercts/nopcommerce:latest .'
            }
        }

        stage("Push Docker Image") {
            steps {
                sh 'docker image push panneercts/nopcommerce:latest'
            }
        }

        stage("Infra Povisioning") {
            steps {
                sh 'cd infra/terraform && terraform init' 
                sh 'cd infra/terraform && terraform workspace new dev && terraform workspace select dev' 
                sh 'cd infra/terraform && terraform apply -var-file="dev.tfvars" -var "build_number=${BUILD_ID}" -auto-approve' 
            }
        }

        stage("Deploy") {
            steps {
                sh 'kubectl apply -f infra/k8s' 
            }
        }
    }
}
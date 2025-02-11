pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AccessKey')   // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('SecretKey')   // Jenkins credential ID
        PATH = "/opt/homebrew/bin/:$PATH"
        
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        

        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                //input message: "Do you want to apply the Terraform changes?", ok: "Apply"
                script {
                    sh 'terraform apply --auto-approve tfplan'
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                //input message: "Do you want to apply the Terraform changes?", ok: "Apply"
                Destroy(){
                
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed"
        }
        success {
            echo "Infrastructure provisioned successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}

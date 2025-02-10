pipeline {
    agent any

    //environment {
     //   AWS_ACCESS_KEY_ID     = credentials('36741095-3c68-4b7d-af2b-e85783cba98d')   // Jenkins credential ID
       // AWS_SECRET_ACCESS_KEY = credentials('36741095-3c68-4b7d-af2b-e85783cba98d')   // Jenkins credential ID
        
    //}

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

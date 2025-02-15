pipeline {
    agent any
    parameters {
        string(name: 'BRANCH_NAME',defaultValue:'parameterized-pipeline ')
        choice(name: 'Actions', choices: ['Plan', 'Apply','Destroy'], description: 'Terraform Actions')
        
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AccessKey')   // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('SecretKey')   // Jenkins credential ID
        PATH = "/opt/homebrew/bin/:$PATH"
        
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    try {

                        // Attempt to checkout the specified branch
                        git branch: "${params.BRANCH_NAME}",
                        url: 'https://github.com/sanashaikh123/terraform-repo-2nd.git'
                    
                    }catch (Exception e) {
                        // Handle the error, e.g., notify the user or fallback to a default branch
                        echo "Branch '${params.BRANCH_NAME}' not found. Please verify the branch name."
                        currentBuild.result = 'FAILURE'
                        error("Stopping pipeline due to invalid branch.")
                    }
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

        stage('Terraform Actions') {
            steps {
                script {
                    if (params.Actions == "Plan"){
                        sh 'terraform plan -out=tfplan'
                    }else if (params.Actions == 'Apply'){
                        sh 'terraform apply -auto-approve tfplan'
                    }else if (params.Actions == 'Apply'){
                        sh 'terraform destroy -auto-approve tfplan'
                    }

                    
                }
            }
        }   
    }

    post {
        always {
            echo "Pipeline execution completed"
            archiveArtifacts artifacts: 'tfplan'
        }
        success {
            echo "Infrastructure provisioned successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
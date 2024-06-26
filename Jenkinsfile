pipeline{
    agent any
    environment{
        terraform = "terraform 1.6.3"
    }
   parameters {
        choice(
            name: 'apply_or_destroy',
            choices: ['apply', 'destroy']
        )
    }
    
    stages{

    stage('tf init'){
        steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform init -upgrade -reconfigure"
          }
        }
    }

    stage('terraform apply or destroy'){
        steps {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform ${params.apply_or_destroy} -auto-approve"
        }
      }
    }

    stage('delete state file'){
        steps{
          script{
            if (params.apply_or_destroy == 'destroy'){
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: 'aws_creds', 
              secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                sh "python3 delete_state_file.py"
            }
          } 
        }
      }
    }  
  }

  post {
    failure {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            credentialsId: 'aws_creds', 
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh "terraform destroy -auto-approve"
          }
        }
    }
}
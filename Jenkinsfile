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
    
    stage('get public ip and inject to sg in tf'){
      steps{
        script{
                def ip = sh(script: 'curl -s ipinfo.io/ip', returnStdout: true).trim()
                env.IP_ADDRESS = ip
                sh "sed -i 's/\"cidr_blocks\" = \[\".*\\/32\"\]/\"cidr_blocks\" = [\"${env.IP_ADDRESS}\\/32\"]/' tf_module/main.tf"
              }
            }
          }

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
node {
    
    properties([
    buildDiscarder(logRotator(daysToKeepStr: '1', numToKeepStr: '1')),
])
        stage('Source Code Download') {
    git 'https://github.com/AkhilNair004/kubernetes-roshambo.git'
}
  stage('Source Build') {
    sh 'mvn package'
}
    stage('Docker Image') {
    sh 'docker build -t akhilnair004/roshambo:latest .'
}
   stage('Docker Login & Push') {
 withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerpwd')]) {
    sh 'docker login -u akhilnair004 -p ${dockerpwd}'
}
   sh 'docker push akhilnair004/roshambo:latest '
}
    stage('Approval ') {
         
        echo 'Publishing SNS message to AWS'
        withAWS(credentials:'AWSCredentialsForSnsPublish'){
                snsPublish(
                    topicArn:'arn:aws:sns:ap-south-1:312519541424:Approval-Pending-Request', 
                    subject:"Approval Pending for $JOB_NAME & build-id $BUILD_ID ", 
                    message: "Hi Team , Please approve the request for Job Name $JOB_NAME & build-id $BUILD_ID  "
                    )
      }
        input message: 'Approval Pending ', submitter: 'Admin'
  }
    stage('Deployment Kubernetes cluster ') {
            sshagent(['ubuntu']) {
     sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.232.60.177 kubectl apply -f roshambo.yml '
     
}
  stage('Publish SNS') {
         
            echo 'Publishing SNS message to AWS'
      withAWS(credentials:'AWSCredentialsForSnsPublish'){
                snsPublish(
                    topicArn:'arn:aws:sns:ap-south-1:312519541424:Sucessfully-deployed', 
                    subject:"Sucessfully deployed $JOB_NAME on Kubernetes cluster  ", 
                    message: "Hi Team , We have sucessfully deployed $JOB_NAME on Kubernetes cluster   "
                    )
      }
  }
    }   
}

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
    stage('Deployment Kubernetes cluster ') {
            sshagent(['ubuntu']) {
     sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.232.60.177 kubectl apply -f roshambo.yaml '
     
}
  stage('Publish SNS') {
         
            echo 'Publishing SNS message to AWS'
            withAWS(credentials:'AWSCredentialsForSnsPublish') {
                snsPublish(
                    topicArn:'arn:aws:sns:ap-south-1:312519541424:Approval-Pending-Request', 
                    subject:"Approval Pending with Atish Kulkarni", 
                    message: "Hi Atish Kulkarni , Please approve the request for deployment into Kubernetes cluster"
                    )           
         }
      }
   }
    }   

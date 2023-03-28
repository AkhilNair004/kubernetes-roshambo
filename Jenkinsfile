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
    sh 'docker build -t vyomlabs/roshambo:latest .'
}
    stage('Docker Login & Push') {
  withCredentials([string(credentialsId: 'DockerHub_Credentials', variable: 'Dockerhub')]) {
   sh 'docker login -u vyomlabs -p ${DockerHub_Credentials}'
}
    sh 'docker push vyomlabs/roshambo:latest '   
}
    stage('Deployment Kubernetes cluster ') {
            sshagent(['ubuntu']) {
     sh 'ssh -o StrictHostKeyChecking=no ubuntu@65.0.133.60 kubectl apply -f roshambo.yml '
     
}
    }
  stage('Publish SNS') {
            echo 'Publishing SNS message to AWS'
      withAWS(credentials:'AWSCredentialsForSnsPublish'){
                snsPublish(
                    topicArn:'arn:aws:sns:ap-south-1:312519541424:Sucessfully-deployed', 
                    subject:"Sucessfully deployed $JOB_NAME on Kubernetes cluster  ", 
                    message: "Hi Team , We have sucessfully deployed $JOB_NAME on Kubernetes cluster"
                    )
      }
}

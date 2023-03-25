node {
    
        stage('Source Code Download') {
    git 'https://github.com/AkhilNair004/roshambo.git'
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
stage ('Send Email') {
        echo "Mail Stage";

         mail to: "agheel.nair@vyomlabs.com",
         subject: "Please apporve",
         body: "This is body";
    }
     stage('Deployment to Test Env ') {
                  slackSend channel: 'aws', message: 'Please Approve'
         input message: 'Waiting For Approval ', submitter: 'Admin'
         slackSend channel: 'aws', message: 'Sucessfully Deployed'
                  sshagent(['ec2-user']) {
     sh 'ssh -o StrictHostKeyChecking=no ec2-user@13.235.17.205 docker rm -f roshambo-container || true '
     sh 'ssh -o StrictHostKeyChecking=no ec2-user@13.235.17.205 docker run -d -p 8080:8080 --name roshambo-container akhilnair004/roshambo:latest '
    
}

}
}

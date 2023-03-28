node {
    properties([
    buildDiscarder(logRotator(daysToKeepStr: '1', numToKeepStr: '1')),
])
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

    stage('Continuous Deployment') {
                  sshagent(['ec2-user']) {
     sh 'ssh -o StrictHostKeyChecking=no ec2-user@65.2.129.116 docker rm -f roshambo-container || true '
     sh 'ssh -o StrictHostKeyChecking=no ec2-user@65.2.129.116 docker run -d -p 8080:8080 --name roshambo-container akhilnair004/roshambo:latest '
                    
}

}
}

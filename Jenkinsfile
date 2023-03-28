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
    }
}

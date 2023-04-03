node { 
     properties([
    buildDiscarder(logRotator(daysToKeepStr: '1', numToKeepStr: '1')),
])
     stage('Continuous Download') {
          git branch: 'master', url: 'https://github.com/AkhilNair004/kubernetes-roshambo.git'
           }
   stage('Build') {
    sh 'mvn clean package'
}
   stage ('Build Docker Image'){
        sh 'docker build -t vyomlabs/roshambo:latest . '
        }

 stage('Deployment Kubernetes cluster ') {
            sshagent(['ubuntu-ssh-login']) {
              script {
            if (fileExists('home/ubuntu/roshambo.yaml')) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.126.119.211 kubectl delete -f roshambo.yaml '
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.126.119.211 rm -rf roshambo.yaml '
                sh 'scp -o StrictHostKeyChecking=no roshambo.yaml ubuntu@13.126.119.211:/home/ubuntu/'
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.126.119.211 kubectl apply -f roshambo.yaml '
            }
            else
            {
                 sh 'scp -o StrictHostKeyChecking=no roshambo.yaml ubuntu@13.126.119.211:/home/ubuntu/'
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.126.119.211 kubectl apply -f roshambo.yaml '
            }
        }
}
}
}


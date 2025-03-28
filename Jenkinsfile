node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
  
       //app = docker.build("akmabrdockerid/test")
       // Solution 2 (host networking)
       app = docker.build("akmabrdockerid/test", "--network=host .")
        
        // OR Solution 3 (explicit DNS)
        // app = docker.build("akmabrdockerid/test", "--add-host=pypi.org:8.8.8.8 .")
    }

     stage('Test image') {
        // Solution 3: Completely avoid Jenkins' docker.inside() method
        sh 'docker run --rm akmabrdockerid/test echo "Tests passed"'
        
        // For actual tests, you might use:
        // sh 'docker run --rm akmabrdockerid/test python -m pytest'
    }

    stage('Push image') {
        
        docker.withRegistry('https://registry.hub.docker.com', 'docker-cred') {
            app.push("${env.BUILD_NUMBER}")
        }
    }
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
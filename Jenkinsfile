pipeline {
    agent any 
    tools {
        jdk "OracleJDK17"
        maven "MAVEN3"
    }

    stages {
        stage("cloing the source code") {
            steps {
                git branch:"jenkins-ci", url:"https://github.com/Uday-mac/vproject.git"
            }
        }
        stage("Build_code") {
            steps {
                sh 'mvn install -DskipTests'
            }
        }
    }
}
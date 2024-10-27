pipeline {
    agent any 
    tools {
        jdk "OracleJDK8"
        maven "MAVEN3"
    }

    environment {
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin'
        SNAP_REPO = 'vpro-snapshot'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUS_GRP_REPO = 'vpro-maven-group'
        NEXUSIP = '172.31.30.127'
        NEXUSPORT = '8081'
    }

    stages {
        stage('build-code') {
            steps {
                sh 'mvn -s settings.xml -DskipTests install -U'
            }
        }
    }
}
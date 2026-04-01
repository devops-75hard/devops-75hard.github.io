import groovy.json.JsonSlurper

def configFile = readFileFromWorkspace('applications/config.json')
def config     = new JsonSlurper().parseText(configFile)

config.applications.each { app ->

    pipelineJob("${app.name}-docker-pipeline") {

        description("Docker CI/CD pipeline for ${app.name}")

        definition {
            cps {
                script("""
@Library('75hardevops') _

pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                cloneRepo('${app.repo}', '${app.branch}')
            }
        }
        stage('Docker Build') {
            steps {
                dockerBuild('${app.name}')
            }
        }
        stage('Trivy Scan') {
            steps {
                trivyScan('${app.name}')
            }
        }
    }
}
""")
                sandbox(true)
            }
        }
    }

}

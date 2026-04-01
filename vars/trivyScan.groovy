def call(String applicationName) {
    sh "trivy image ${applicationName}"
}

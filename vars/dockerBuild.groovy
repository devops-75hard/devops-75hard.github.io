def call(String applicationName) {
    sh "docker build -t ${applicationName} ."
}

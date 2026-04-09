def call(String applicationName) {
      sh """
          docker run --rm \
              -v /var/run/docker.sock:/var/run/docker.sock \
              -v trivy-cache:/root/.cache/trivy \
              ghcr.io/aquasecurity/trivy:latest \
              image ${applicationName}
      """
  }

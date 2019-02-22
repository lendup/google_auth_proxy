def imageName
def imageVersion

builderNode {
  def cacheImageTag

  if (env.CHANGE_ID) {
    // Pull request, use target branch as cache image
    cacheImageTag = env.CHANGE_TARGET
  } else {
    // Branch, use its last built thing as cache
    cacheImageTag = env.BRANCH_NAME
  }

  // Special case for master branch, use 'latest' for tag name.
  if (cacheImageTag == "master") {
    cacheImageTag = "latest"
  }

  checkout scm
  imageVersion = projectVersion()
  stage("build image") {
    imageName = buildDockerImage(repository: "ci-tool-ops/google-auth-proxy", cacheImageTag: cacheImageTag)
  }

  if (!env.CHANGE_ID) {
    stage("promote to ${cacheImageTag}") {
      // Branch- promote to its name for caching, and also to its imageVersion for posterity.
      promoteDockerImage(imageName: imageName, toTags: [imageVersion, cacheImageTag])
    }
    if (env.BRANCH_NAME == 'master') {
      deployNomadService(group: "ci-tool-ops", service: "google-auth-proxy", stack: "dev-us-east-1", version: imageVersion)
    }
  }
}

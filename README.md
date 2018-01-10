# dwolla/sbt-version-cache

A Docker image containing [`sbt`](https://www.scala-sbt.org/index.html) artifacts for multiple sbt and Scala versions, to be included in downstream Docker images of various architectures.

Breaking these artifacts into a separate Docker image lets us take advantage of [multi-stage builds](https://docs.docker.com/engine/userguide/eng-image/multistage-build/#use-multi-stage-builds) to separate the downloading of sbt, compiling Scala versions, etc., from whatever other environment setup is required to support architectures like Alpine Linux, Ubuntu, etc.

This image gets included in Dwolla's Jenkins Agent images for [sbt](https://github.com/Dwolla/jenkins-agent-docker-sbt) and [nvm and sbt](https://github.com/Dwolla/jenkins-agent-docker-nvm-sbt).

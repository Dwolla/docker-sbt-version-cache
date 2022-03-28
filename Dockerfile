FROM eclipse-temurin:11 AS downloader
LABEL maintainer="Dwolla Dev <dev+sbt@dwolla.com>"
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/docker-sbt-version-cache"

USER root
ENV SBT_VERSION=1.6.2 \
    SBT_HOME=/usr/local/sbt
ENV PATH=${SBT_HOME}/bin:${PATH}

COPY fake-project /fake-project

RUN apt-get update &&\
    apt-get install -y \
      curl \
      ca-certificates \
      bash

SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

RUN cd /tmp && \
    curl --silent --verbose --location --output "sbt-${SBT_VERSION}.sha256" "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz.sha256" && \
    curl --silent --verbose --location --output "sbt-${SBT_VERSION}.tgz" "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" && \
    sha256sum -c "sbt-${SBT_VERSION}.sha256" && \
    gunzip --stdout "sbt-${SBT_VERSION}.tgz" | \
    tar --extract --directory="$(dirname "${SBT_HOME}")" \
      sbt/bin/sbt \
      sbt/bin/sbt-launch.jar \
      sbt/conf/sbtopts \
      sbt/LICENSE \
      sbt/NOTICE && \
    chmod 0444 "${SBT_HOME}/bin/sbt-launch.jar"

RUN cd /fake-project && \
    for version in ${SBT_VERSION} 1.5.5; do \
        echo sbt.version=${version} > project/build.properties && \
        sbt -Dsbt.log.noformat=true clean +compile; \
    done

FROM scratch
COPY --from=downloader /usr/local/sbt /usr/local/sbt
COPY --from=downloader /root/.cache/coursier /root/.cache/coursier
COPY --from=downloader /root/.ivy2 /root/.ivy2
COPY --from=downloader /root/.sbt /root/.sbt

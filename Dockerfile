FROM debian:buster-slim
LABEL Description="Use the Balena CLI to perform actions"


# Get the latest Balena release using
# curl -s https://api.github.com/repos/balena-io/balena-cli/releases/latest | jq -r .tag_name)

# Install the standalone balena-cli package
RUN apt-get update && apt-get install -y \
    curl && \
  cd /opt/ && \
  export BALENA_RELEASE="v22.1.4" && \
  echo "Uses Balena CLI version: $BALENA_RELEASE" && \
  curl -O -sSL "https://github.com/balena-io/balena-cli/releases/download/$BALENA_RELEASE/balena-cli-$BALENA_RELEASE-linux-x64-standalone.tar.gz" && \
  tar -xzf balena-cli-*-linux-x64-standalone.tar.gz && \
  ln -s /opt/balena/bin/balena /usr/bin/ && \
  apt-get purge -y \
    curl && \
  apt-get autoremove -y && \
  rm -rf \
    balena-cli-*-linux-x64-standalone.tar.gz \
    /var/lib/apt/lists/*

# Copy entrypoint into `/opt`
COPY entrypoint.sh /opt/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/opt/entrypoint.sh"]

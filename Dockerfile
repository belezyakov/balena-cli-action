FROM debian:bookworm
LABEL Description="Use the Balena CLI to perform actions"


# Get the latest Balena release using
# curl -s https://api.github.com/repos/balena-io/balena-cli/releases/latest | jq -r .tag_name)

# Install the standalone balena-cli package
RUN apt-get update && apt-get install -y \
    curl \
    unzip && \
  cd /opt/ && \
  export BALENA_RELEASE="v21.1.9" && \
  echo "Uses Balena CLI version: $BALENA_RELEASE" && \
  curl -O -sSL "https://github.com/balena-io/balena-cli/releases/download/$BALENA_RELEASE/balena-cli-$BALENA_RELEASE-linux-x64-standalone.zip" && \
  unzip balena-cli-*-linux-x64-standalone.zip && \
  ln -s /opt/balena-cli/balena /usr/bin/ && \
  apt-get purge -y \
    curl \
    unzip && \
  apt-get autoremove -y && \
  rm -rf \
    balena-cli-*-linux-x64-standalone.zip \
    /var/lib/apt/lists/*

# Copy entrypoint into `/opt`
COPY entrypoint.sh /opt/entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/opt/entrypoint.sh"]

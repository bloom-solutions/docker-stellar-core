FROM satoshipay/stellar-core:13.0.0

RUN apt-get update -qq && \
  apt-get install lsb-release curl jq -y

# install gcloud and gsutil
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "CLOUD_SDK_REPO: $CLOUD_SDK_REPO" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update -qq && \
  apt-get install google-cloud-sdk -qqy

# Add check-synced.sh script that can be used in Kubernetes livenessProbe
ADD scripts/liveness/check /liveness/check
RUN chmod +x /liveness/check

# Overwrite their entry.sh script for now, but ensure it stays
# the same + our changes. Find a way to properly override the
# ENTRYPOINT of a base image
# See https://stackoverflow.com/q/41207522
ADD scripts/entrypoint.sh /entry.sh

FROM satoshipay/stellar-core:15.0.0-gcloud

# Add check-synced.sh script that can be used in Kubernetes livenessProbe
ADD scripts/liveness/check /liveness/check
RUN chmod +x /liveness/check

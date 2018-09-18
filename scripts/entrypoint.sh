#!/usr/bin/env bash

set -ue

function setup_gsutil() {
  if [ -z "$GS_SERVICE_ACCOUNT_KEY" ]; then
    echo "GS_SERVICE_ACCOUNT_KEY not configured. Skipping setup."
    return 0
  fi

  echo "Setting up gsutil: writing contents of GS_SERVICE_ACCOUNT_KEY into /tmp/gcloud-key.json..."
  echo $GS_SERVICE_ACCOUNT_KEY > /tmp/gcloud-key.json
  gcloud auth activate-service-account --key-file /tmp/gcloud-key.json
  echo "gsutil configured"
}

function stellar_core_init_db() {
  local DB_INITIALIZED="/data/.db-initialized"

  if [ -f $DB_INITIALIZED ]; then
    echo "core db already initialized. continuing on..."
    return 0
  fi

  echo "initializing core db..."

  stellar-core --conf /stellar-core.cfg -newdb

  echo "finished initializing core db"

  touch $DB_INITIALIZED
}

confd -onetime -backend env -log-level error

setup_gsutil
stellar_core_init_db

exec "$@"

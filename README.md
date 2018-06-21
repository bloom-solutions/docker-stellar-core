# Stellar Core on Docker

Refer to SatoshiPay's [README](https://github.com/satoshipay/docker-stellar-core) since this is based on that with a few additions:

- installation of gcloud and gsutil to allow reading and writing into Google Storage buckets
- including a script to check for liveness

## Extra Environment Variables:

* `GS_SERVICE_ACCOUNT_KEY`: if you use Google Storage to write history, set this environment variable to your service account key:
  ```json
  {
    "type": "service_account",
    "project_id": "project-name",
    "private_key_id": "0n7n7cnqp84489",
    "private_key": "-----BEGIN PRIVATE KEY-----..."
  }
  ```

  Your history can then have something like this for read/write:

  ```json
  {
    "local": {
      "get": "/gsutil cp gs://bucket-name/prod/01/{0} {1}",
      "put": "/gsutil cp {0} gs://bucket-name/prod/01/{1}"
  }
  ```

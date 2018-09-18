# Stellar Core on Docker

Refer to SatoshiPay's [README](https://github.com/satoshipay/docker-stellar-core) since this is based on that with a few additions:

- installation of gcloud and gsutil to allow reading and writing into Google Storage buckets
- including a script to check for liveness (for Kubernetes)

# Examples

## Checking Liveness

```yaml
livenessProbe:
  exec:
    command:
      - /liveness/check
      - http://localhost:11626
  initialDelaySeconds: 180
  periodSeconds: 180
  failureThreshold: 10
```

# Enabling History Archive

Set the env `ARCHIVE_HISTORY` to be the name of the history archive that has the `put` command. If you started core without this, [Stellar recommends](https://github.com/stellar/stellar-core/blob/master/docs/software/admin.md#configuring-to-publish-to-an-archive) that you delete everything -- the database, horizon, and redeploy.

# Read/write history in Google Storage

Ensure that you have set `ARCHIVE_HISTORY` correctly.

`GS_SERVICE_ACCOUNT_KEY`: if you use Google Storage to write history, set this environment variable to your service account key:

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

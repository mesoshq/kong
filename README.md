# Kong clusters on Mesos

This [Docker image](https://hub.docker.com/r/mesoshq/kong/) allows to deploy Kong (v0.8.3) clusters in Mesos via Marathon. 

## Configuration

Configuration can be done via passing environment variables in the Marathon app JSON.

### List of possible environment variables

**Host/Port-related**  

* `HOST`: The ip address of the host the Kong instance is running on (provided by Marathon).
* `PORT0`: The `proxy_listen` port (provided by Marathon).
* `PORT1`: The `proxy_listen_ssl` port (provided by Marathon).
* `PORT2`: The `admin_api_listen` port (provided by Marathon).
* `PORT3`: The `cluster_listen` port (provided by Marathon).
* `PORT4`: The `cluster_listen_rpc` port (provided by Marathon).

**Database overall**  

The minimal configuration (all variables are **mandatory**!) can be established by passing the following variables:

* `DATABASE_TYPE`: The database type to use (can either be `postgres` or `cassandra`). 
* `DATABASE_HOST`: The host (ip address) the database is running on.
* `DATABASE_PORT`: The port the database is running on.
* `DATABASE_NAME`: The database name (for Cassandra, this is the `keyspace` name).
* `DATABASE_USER`: The user Kong can use to connect to the database.
* `DATABASE_PASSWORD`: The password Kong can use to connect to the database. 

**Cassandra specific**  

* `DATABASE_HOSTn`: Additional Cassandra hosts (contact points), `n` is `{1..4}`. The hosts are matched to the ports via the `n` ennumeration.
* `DATABASE_PORTn`: Additional Cassandra ports (contact points), `n` is `{1..4}`.
* `DATABASE_CONSISTENCY`: Consistency setting to use when reading/writing.
* `DATABASE_REPLICATION_STRATEGY`: If creating the keyspace for the first time, specify a replication strategy.
* `DATABASE_REPLICATION_FACTOR`: Specify a replication factor for the SimpleStrategy.
* `DATABASE_DATA_CENTERS`: Specify data centers for the NetworkTopologyStrategy.
* `DATABASE_SSL_CERTIFICATE_AUTHORITY`: The certificate authority for the SSL certificates.
* `DATABASE_SSL_ENABLED`: Enable SSL connections to the nodes (`true` or `false`, default `false`).
* `DATABASE_SSL_VERIFY`: If cassandra_ssl is enabled, toggle server certificate verification. 

## Marathon application definition

```
{
  "id": "kong-api-gateway",
  "container": {
    "docker": {
      "image": "mesoshq/kong:latest",
      "network": "HOST",
      "forcePullImage": true
    },
    "type": "DOCKER"
  },
  "cpus": 0.3,
  "mem": 1024,
  "instances": 3,
  "healthChecks": [
    {
      "protocol": "TCP",
      "gracePeriodSeconds": 30,
      "intervalSeconds": 10,
      "timeoutSeconds": 20,
      "maxConsecutiveFailures": 3,
      "ignoreHttp1xx": false,
      "portIndex": 0
    }
  ],
  "ports": [0, 0, 0, 0, 0],
  "env": {
    "DATABASE_TYPE": "postgres",
    "DATABASE_HOST": "192.168.0.111",
    "DATABASE_PORT": "5432",
    "DATABASE_NAME": "kong",
    "DATABASE_USER": "kong",
    "DATABASE_PASSWORD": "kong"
  }
}
```
# Kong clusters on Mesos

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
    "DATABASE_PORT": "4615",
    "DATABASE_NAME": "kong",
    "DATABASE_USER": "kong",
    "DATABASE_PASSWORD": "kong"
  }
}
```
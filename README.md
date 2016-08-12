# Kong clusters on Mesos

## Marathon application definition
```
{
  "id": "kong-apigateway",
  "container": {
    "docker": {
      "image": "coreos-hw-node-1.aic-group.local:5000/kong:latest",
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
    "DATABASE_HOST": "192.168.200.168",
    "DATABASE_PORT": "4615",
    "DATABASE_NAME": "kong",
    "DATABASE_USER": "kong",
    "DATABASE_PASSWORD": "kong"
  },
  "labels": {
    "HAPROXY_GROUP": "external",
    "HAPROXY_0_VHOST": "dcos-public-agent-1.aic-group.local",
    "HAPROXY_0_PATH": "/api"
  }
}
```

```
{
  "id": "kong-apigateway",
  "container": {
    "docker": {
      "image": "coreos-hw-node-1.aic-group.local:5000/kong:latest",
      "network": "HOST",
      "forcePullImage": true
    },
    "type": "DOCKER"
  },
  "cpus": 0.5,
  "mem": 1024,
  "instances": 2,
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
  "ports": [0, 0, 0, 0, 0, 0],
  "env": {
    "DATABASE_TYPE": "cassandra",
    "DATABASE_HOST": "192.168.200.166",
    "DATABASE_PORT": "9042",
    "DATABASE_NAME": "kong"
  }
}
```

```
{
  "id": "kong-apigateway",
  "container": {
    "docker": {
      "image": "coreos-hw-node-1.aic-group.local:5000/kong:latest",
      "network": "BRIDGE",
      "forcePullImage": true,
      "portMappings": [
        { "containerPort": 8000, "protocol": "tcp" },
        { "containerPort": 8001, "protocol": "tcp" },
        { "containerPort": 7946, "protocol": "tcp" },
        { "containerPort": 7946, "protocol": "udp" },
        { "containerPort": 7947, "protocol": "tcp" },
        { "containerPort": 7947, "protocol": "udp" }
      ]
    },
    "type": "DOCKER"
  },
  "cpus": 0.5,
  "mem": 1024,
  "instances": 2,
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
  "env": {
    "DATABASE_TYPE": "cassandra",
    "DATABASE_HOST": "192.168.200.166",
    "DATABASE_PORT": "9042",
    "DATABASE_NAME": "kong"
  }
}
```

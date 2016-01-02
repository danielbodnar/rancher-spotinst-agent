The [instructions](http://blog.spotinst.com/2015/11/26/rancher-spotinst-how-integration-works/) spotinst provides is for a shell-based user-data file. I was unable to add a CATTLE_HOST_LABELS environment variable for "spotinst.instanceId", using cloud-config / docker-compose yaml syntax on RancherOS.

This image extends the rancher/agent image and

### Usage

If your EC2 AMI ID is a RancherOS AMI, then insert the following into the "User data" box on SpotInst's "3. Compute" tab.

```
#cloud-config
rancher:
  services:
    rancher-agent1:
      image: danielbodnar/rancher-spotinst-agent:v0.8.2
      command: [insert agent string here. e.g.: http://rancher.domain.com:8080/v1/scripts/[token]]
      privileged: true
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
```



### Building

```
./build-image.sh v0.8.2 && docker push rancher-spotinst-agent [registry]/[username]/rancher-spot-inst-agent:v0.8.2
```



### Dockerfile

```
FROM rancher/agent:${AGENT_VERSION}
MAINTAINER Daniel Bodnar daniel.bodnar@gmail.com
COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]

```



### start.sh

```
#! /bin/bash
export CATTLE_HOST_LABELS="spotinst.instanceId=`curl http://169.254.169.254/latest/meta-data/instance-id`"
./run.sh "$@"

```



### build-image.sh

```
#!/bin/bash

AGENT_VERSION=$1

if [ -z "$AGENT_VERSION" ]; then
    AGENT_VERSION=latest
fi

eval "cat <<EOF
$(<Dockerfile.tmpl)
EOF
" 1>Dockerfile 2> /dev/null


IMAGE=rancher-spotinst-agent:${AGENT_VERSION}

echo Building $IMAGE
docker build -t ${IMAGE} .
```

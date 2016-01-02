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
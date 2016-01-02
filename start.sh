#! /bin/bash
export CATTLE_HOST_LABELS="spotinst.instanceId=`curl http://169.254.169.254/latest/meta-data/instance-id`"
./run.sh "$@"
FROM rancher/agent:v0.8.2
MAINTAINER Daniel Bodnar daniel.bodnar@gmail.com
COPY start.sh /start.sh
ENTRYPOINT export CATTLE_HOST_LABELS="spotinst.instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)" && echo $CATTLE_HOST_LABELS && /run.sh

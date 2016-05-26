FROM rancher/agent:v1.0.1
MAINTAINER Daniel Bodnar daniel.bodnar@gmail.com
COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]

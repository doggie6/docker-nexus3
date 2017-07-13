FROM sonatype/nexus3:3.4.0

MAINTAINER youhouhouhou

ARG buildno

USER root

#https://github.com/maxcnunes/waitforit
#ADD install_waitforit.sh /root/
#RUN /root/install_waitforit.sh
# version 1.4.0
COPY waitforit-linux_amd64 /usr/local/bin/waitforit
RUN chmod +x /usr/local/bin/waitforit


RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD entrypoint.sh /opt/sonatype/nexus/entrypoint.sh
ADD init/*.sh /opt/sonatype/nexus/init/
ADD init/json/*.json /opt/sonatype/nexus/init/json/
RUN chmod +755 /opt/sonatype/nexus/*.sh
RUN chmod +755 /opt/sonatype/nexus/init/*.sh

USER nexus

ENTRYPOINT ["/opt/sonatype/nexus/entrypoint.sh"]
CMD ["bin/nexus", "run"]
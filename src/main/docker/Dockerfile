FROM sonatype/nexus3:3.4.0

MAINTAINER youhouhouhou

USER root

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD entrypoint.sh /opt/sonatype/nexus/entrypoint.sh
RUN chmod +755 /opt/sonatype/nexus/entrypoint.sh

USER nexus

ENTRYPOINT ["/opt/sonatype/nexus/entrypoint.sh"]
CMD ["bin/nexus", "run"]
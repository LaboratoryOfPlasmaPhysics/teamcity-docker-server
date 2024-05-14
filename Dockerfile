FROM fedora:39
LABEL maintainer "Kateryna Shlyakhovetska <shkate@jetbrains.com>"
LABEL modified "Alexis Jeandet <alexis.jeandet@member.fsf.org>"

RUN dnf install -y java-11-openjdk mercurial git tar gzip tomcat apr


ENV TEAMCITY_DATA_PATH=/data/teamcity_server/datadir \
    TEAMCITY_DIST=/opt/teamcity \
    TEAMCITY_LOGS=/opt/teamcity/logs \
    TEAMCITY_SERVER_OPTS="-Dmail.imaps.ssl.protocols=TLSv1.2 -Dmail.smtp.ssl.protocols=TLSv1.2 -Dmail.smtp.starttls.enable=true -Dmail.smtps.ssl.protocols=TLSv1.2"
    
ADD https://download.jetbrains.com/teamcity/TeamCity-2024.03.1.tar.gz $TEAMCITY_DIST/
RUN tar -xf $TEAMCITY_DIST/TeamCity-*.tar.gz -C $TEAMCITY_DIST/
RUN rm $TEAMCITY_DIST/TeamCity-*.tar.gz
RUN mv $TEAMCITY_DIST/TeamCity/* $TEAMCITY_DIST

EXPOSE 8111
LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

COPY run-server.sh /run-server.sh
COPY run-services.sh /run-services.sh
COPY server.xml  $TEAMCITY_DIST/conf/server.xml
RUN chmod +x /run-server.sh /run-services.sh && sync

ADD https://jdbc.postgresql.org/download/postgresql-42.7.2.jar /data/teamcity_server/datadir/lib/jdbc/

RUN mv $TEAMCITY_DIST/webapps/ROOT $TEAMCITY_DIST/webapps/teamcity

VOLUME $TEAMCITY_DATA_PATH \
       $TEAMCITY_LOGS

CMD ["/run-services.sh"]

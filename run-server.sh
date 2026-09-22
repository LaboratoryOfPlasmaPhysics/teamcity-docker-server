#!/bin/bash

# Setting default values if variables not present
: ${TEAMCITY_DIST:=/opt/teamcity}
: ${TEAMCITY_LOGS:=${TEAMCITY_DIST}/logs}
: ${TEAMCITY_CONTEXT:=ROOT}

rm -f "${TEAMCITY_LOGS}/*.pid"

if [[ "$TEAMCITY_CONTEXT" != "ROOT" ]]; then
    current="$(ls ${TEAMCITY_DIST}/webapps | head -1)"
    [[ "$current" != "$TEAMCITY_CONTEXT" ]] && mv "${TEAMCITY_DIST}/webapps/$current" "${TEAMCITY_DIST}/webapps/$TEAMCITY_CONTEXT"
fi

install_bundled_jdbc_driver() {
    local target="${TEAMCITY_DATA_PATH}/lib/jdbc"
    mkdir -p "$target"
    rm -f "$target"/postgresql-*.jar
    cp "${TEAMCITY_DIST}"/jdbc/postgresql-*.jar "$target"/
}

install_bundled_jdbc_driver

export TEAMCITY_SERVER_MEM_OPTS='-Xmx4g -XX:ReservedCodeCacheSize=350m'

trap "'${TEAMCITY_DIST}/bin/teamcity-server.sh' stop; exit 0;" SIGTERM SIGINT SIGHUP

"${TEAMCITY_DIST}/bin/teamcity-server.sh" start

while [ ! -f "${TEAMCITY_DIST}/logs/teamcity-server.log" ];
do
   echo -n "."
   sleep 1
done

tail -F "${TEAMCITY_DIST}/logs/teamcity-server.log" &
wait


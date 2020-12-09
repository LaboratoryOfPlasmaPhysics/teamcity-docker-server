#!/usr/bin/sh

docker build -t  129.104.6.165:32219/lpp/teamcity-server .
docker push 129.104.6.165:32219/lpp/teamcity-server
cd postgresql && build_and_push.sh

#!/usr/bin/sh

docker build -t  129.104.6.172:32219/lpp/teamcity-server .
docker push 129.104.6.172:32219/lpp/teamcity-server
cd postgresql && sh ./build_and_push.sh

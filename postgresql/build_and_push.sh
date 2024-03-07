#!/usr/bin/sh

docker build -t 129.104.6.172:32219/lpp/postgres_fr:12 .
docker push 129.104.6.172:32219/lpp/postgres_fr:12

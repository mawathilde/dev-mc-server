FROM openjdk:8u342-jre

RUN apt-get update -y \
 	&& apt-get install -y lsof curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
 	&& useradd -d /home/server -m server

USER server
WORKDIR /home/server

COPY files/CatServer.jar /home/server/CatServer.jar
COPY files/entrypoint.sh /home/server/entrypoint.sh

CMD [ "/bin/bash", "/home/server/entrypoint.sh" ]
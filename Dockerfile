FROM debian:12

RUN apt-get update -y \
 	&& apt-get install -y ca-certificates curl gnupg dirmngr netbase wget lsof openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
 	&& useradd -d /home/server -m server

RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc \
    && echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list \
    && apt update \
    && apt install -y temurin-8-jdk

USER server
WORKDIR /home/server

COPY files/CatServer.jar /home/server/CatServer.jar
COPY files/entrypoint.sh /home/server/entrypoint.sh

CMD [ "/bin/bash", "/home/server/entrypoint.sh" ]
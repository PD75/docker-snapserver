FROM debian:testing-slim

RUN apt-get update && apt-get upgrade -y && apt-get install wget -y

ARG SNAPCASTVERSION=0.20.0

RUN wget 'https://github.com/badaix/snapcast/releases/download/v'$SNAPCASTVERSION'/snapserver_'$SNAPCASTVERSION'-1_amd64.deb'

RUN dpkg -i --force-all 'snapserver_'$SNAPCASTVERSION'-1_amd64.deb' && apt-get -f install -y 

RUN apt-get purge wget -y && apt-get autoremove -y && apt-get clean -y && rm -fR /var/lib/apt/lists

RUN rm 'snapserver_'$SNAPCASTVERSION'-1_amd64.deb'

RUN snapserver -v

EXPOSE 1704 1705

ENTRYPOINT ["snapserver"]
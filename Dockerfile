FROM joplin/server:2.13.5-beta

USER root

RUN apt-get update \
    && apt-get install -y \
    sudo \
    && rm -rf /var/lib/apt/lists/*

ENV PUID=1000
ENV PGID=1000
ENV PUNAME=app_services

ENV DATA_DIR=/data
VOLUME $DATA_DIR

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

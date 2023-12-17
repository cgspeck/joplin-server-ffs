# Joplin Server Fast Fixes and Solutions

Duct-tape, glue and WD-40 which is required for the Joplin server to actually start.

The upsream container has a fixed user, user id and group id that will cause it to fail when running on another system that does not have the matching user id.

The glue in this container works around it.

For use with [LinuxServer SWAG](https://docs.linuxserver.io/general/swag/) container, run via docker-compose with following:

```yaml
version: '3'

services:
    joplin:
        image: ghcr.io/cgspeck/joplin-server-ffs:main
        restart: always
        environment:
            - APP_PORT=22300
            - APP_BASE_URL=https://joplin.your.domain
            - DB_CLIENT=pg
            - POSTGRES_PASSWORD=postgres_password
            - POSTGRES_DATABASE=postgres_db
            - POSTGRES_USER=postgres_joplin
            - POSTGRES_HOST=postgres_host
            - "STORAGE_DRIVER=Type=Filesystem; Path=/data"
            - "PUID=${PROCESS_USER_ID}"
            - "PUNAME=${PROCESS_USER_NAME}"
            - "PGID=${PROCESS_GROUP_ID}"
        volumes:
          - /srv/apps/joplin:/data
          - /etc/passwd:/etc/passwd:ro
        networks:
          - your-docker-network

networks:
  your-docker-network:
    name: your-docker-network
    external: true
```

Run the container as root but pass in the user id, user name and group id that you want the joplin server to run as.

Once up, login using [default admin account](https://github.com/laurent22/joplin/blob/dev/packages/server/README.md#update-the-admin-user-credentials) `admin@localhost` / `admin`, change the admin password then create your sync users.

It would be nice to use `runuser` instead of `sudo` but I needed this container in a hurry.


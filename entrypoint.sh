#! /bin/bash -eux
id
sudo chown -R $PUID:$PGID /home/joplin
if [ ! -d "/home/$PUNAME" ]; then
  sudo mkdir -p "/home/$PUNAME"
  sudo chown -R $PUID:$PGID "/home/$PUNAME"
fi

stat /data

sudo -E -u $PUNAME -H -- /usr/local/bin/tini -s -- yarn start-prod

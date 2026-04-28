#!/bin/bash

set -e

read -p "Local (/mnt/server/dir): " local

echo """
Local: $local
"""

echo """
=== Creating local directory ===
"""

sudo mkdir -p $local

echo """
=== Setting local directory permissiong ===
"""

sudo chown -R $USER:$USER $local

read -p "Credentials file (/mnt/server/.creds.user): " credsfile

echo """
Credentials file: $credsfile
"""

if [ -f $credsfile ]; then
  echo -e "\n=== Found existing Credentials file ===\n"
else
  echo -e "\n=== Creating credentials file ===\n"

  read -p "Username: " username
  read -sp "Password: " password
  echo ""

  echo -e "username=$username\npassword=$password" | sudo tee $credsfile
fi

echo """
=== Setting Credentials file permissions ===
"""

sudo chmod 700 $credsfile
sudo chown $USER:$USER $credsfile

read -p "Remote (//server/Dir): " remote

echo """
Remote: $remote
"""

echo """
=== Trying to mount ===
"""

sudo mount -t cifs -o "credentials=$credsfile,iocharset=utf8,nofail,_netdev,vers=3.0,uid=$USER,gid=$USER" $remote $local

echo """
=== Trying to unmount ===
"""

sudo umount $local

unit_name=$(systemd-escape -p $local)

echo """
=== Creating ${unit_name}.mount ===
"""

echo """[Unit]
Description=Samba Share - $local
Documentation=man:mount.cifs(8)
After=network-online.target
Wants=network-online.target
Requires=remote-fs-pre.target
Before=remote-fs.target

[Mount]
What=$remote
Where=$local
Type=cifs
Options=credentials=$credsfile,iocharset=utf8,nofail,_netdev,vers=3.0,uid=$USER,gid=$USER
TimeoutSec=15

[Install]
WantedBy=multi-user.target
""" | sudo tee /etc/systemd/system/${unit_name}.mount

echo """
=== Creating ${unit_name}.automount ===
"""

echo """ [Unit]
Description=Automount Samba Share - $local

[Automount]
Where=$local

[Install]
WantedBy=multi-user.target
""" | sudo tee /etc/systemd/system/${unit_name}.automount

echo """
=== Enabling ${unit_name}.automount now ===
"""

sudo systemctl daemon-reload
sudo systemctl enable --now ${unit_name}.automount


#!/bin/bash

echo """
=== Installing docker and docker-compose ===
"""

paru -Sy docker docker-compose

echo """
=== Adding current user to 'docker' group ===
"""

sudo usermod -aG docker $USER

echo """
=== Enabling 'docker.socket' service ===
"""

sudo systemctl enable docker.socket

echo """
'docker.socket' runs docker on first use.
Enable 'docker' to run on boot
"""

echo """
Reboot or restart service + relog
Then run 'docker info'
"""

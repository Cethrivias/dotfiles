#!/bin/bash

echo """
=== Creating directory for temporary files ===
"""

mkdir install.tmp

echo """
=== Importing 1password GPG keys ===
"""

curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

echo """
=== Cloning 1password repository ===
"""

git clone https://aur.archlinux.org/1password.git install.tmp/1password

echo """
=== Building and installing 1password ===
"""

(cd install.tmp/1password && makepkg -si)

echo """
=== Removing temporary files ===
"""

rm -rf install.tmp

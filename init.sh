#!/bin/bash

cd ~/dotfiles
./push.sh
pacman -Qs > packages-with-info.txt
pacman -Qq > current-packages-dump.txt

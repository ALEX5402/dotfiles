#!/bin/bash

cd ~/dotfiles
pacman -Qs > packages-with-info.txt
pacman -Qq > current-packages-dump.txt
./push.sh

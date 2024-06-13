#!/bin/bash
git add .
git commit -m "update : $(date)"
./changelog.sh > README.md
git push origin master
git push --tags

#!/bin/bash
deploy=~/Documents/Promotion/code/modelica-deploy/SHM
if [ -d "$deploy" ]; then
  echo Removing $deploy ...
  rm -rf "$deploy"
fi
echo Copying files from ../SHM to $deploy
mkdir "$deploy"
cp -R ../SHM/* "$deploy"
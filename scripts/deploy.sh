#!/bin/bash
deploy=~/Documents/Promotion/code/modelica-deploy
if [ -d "$deploy/SHM" ]; then
  echo Removing $deploy/SHM ...
  rm -rf "$deploy/SHM"
fi
if [ -d "$deploy/SHMConduction" ]; then
  echo Removing $deploy/SHMConduction ...
  rm -rf "$deploy/SHMConduction"
fi
echo Copying files from ../SHM to $deploy
cp -R ../SHM "$deploy/"
cp -R ../subprojects/shm-conduction/SHMConduction "$deploy/"

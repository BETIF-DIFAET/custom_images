#!/bin/sh

REPO_LIST=${REPO_LIST//,/ }
while true; do
  for repo in $REPO_LIST; do
    echo "[Idler] Scanning CVMFS..."
    cd /cvmfs/$repo
    cd ../..
  done
  sleep 530
done

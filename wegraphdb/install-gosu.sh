#!/bin/bash
set -ex

# gosu
curl -o /usr/local/bin/gosu  --insecure --retry 12 --retry-max-time 0 -C - -SL https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64
chmod +x /usr/local/bin/gosu
gosu nobody true

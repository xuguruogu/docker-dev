#!/usr/bin/env bash
set -ex
cd "$(dirname "${BASH_SOURCE[0]}")"
TAG="wegraphdb/ci:centos8-dev-clang15"
docker build --force-rm --tag "$TAG" --network host -f centos8-dev-clang.Dockerfile .
docker push "$TAG"

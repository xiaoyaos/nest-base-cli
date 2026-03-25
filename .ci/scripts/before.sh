#!/bin/sh
set -eu

mkdir -p ~/.ssh
chmod 700 ~/.ssh

cp .ci/gitlab_ci ~/.ssh/gitlab_ci
chmod 600 ~/.ssh/gitlab_ci

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/gitlab_ci

touch ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts
ssh-keyscan -H 172.16.150.150 >> ~/.ssh/known_hosts
ssh -T git@172.16.150.150 || true

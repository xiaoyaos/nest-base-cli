#!/usr/bin/env bash
set -euo pipefail

required_files=(
  "Dockerfile"
  "docker-compose.yml"
  "config.${CI_ENVIRONMENT_SLUG}.json"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "required file not found: $file"
    exit 1
  fi
done

docker build --ssh default --build-arg NODE_ENV="${CI_ENVIRONMENT_SLUG}" -t "${IMAGE_NAME}" -f ./Dockerfile .

echo "${DEPLOY_DIR}"
mkdir -p "${DEPLOY_DIR}"
cp docker-compose.yml "${DEPLOY_DIR}"
cp "./config.${CI_ENVIRONMENT_SLUG}.json" "${DEPLOY_DIR}"
docker compose -p "${CI_ENVIRONMENT_SLUG}" -f "${DEPLOY_DIR}/docker-compose.yml" up -d --force-recreate

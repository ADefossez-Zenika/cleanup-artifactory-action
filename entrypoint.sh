#!/bin/bash -l
set -euo pipefail

ARTIFACTORY_URL=${1:-} # If $1 exists, ARTIFACTORY_URL=$1, else ARTIFACTORY_URL=""
if [[ -z "$ARTIFACTORY_URL" ]]; then # Test if $ARTIFACTORY_URL is an empty string
  echo "You need to specify the Artifactory URL"
  exit 1
fi

TOKEN=${2:-}
if [[ -z "$TOKEN" ]]; then
  echo "You need to specify the API key"
  exit 1
fi

echo "::add-mask::$TOKEN" # Replace the token value with *** in the logs

REPOSITORY=${3:-}
if [[ -z "$REPOSITORY" ]]; then
  echo "You need to specify the repository to clean"
  exit 1
fi

ARTIFACTS_PATH=${4:-}
if [[ -z "$ARTIFACTS_PATH" ]]; then
  echo "You need to specify the path of your images"
  exit 1
fi

PATTERN=${5:-}
if [[ -z "$PATTERN" ]]; then
  echo "You need to specify the pattern to delete"
  exit 1
fi

DRYRUN=${6:-"true"}
if [[ -z "$DRYRUN" ]]; then
  echo "You need to specify if the images must be really deleted"
  exit 1
fi

JFROG_CLI_OFFER_CONFIG="false"
export JFROG_CLI_OFFER_CONFIG

jfrog rt delete \
  --url="${ARTIFACTORY_URL}" \
  --apikey="${TOKEN}" \
  --dry-run="${DRYRUN}" \
  --quiet \
  "${REPOSITORY}/${ARTIFACTS_PATH}/${PATTERN}"

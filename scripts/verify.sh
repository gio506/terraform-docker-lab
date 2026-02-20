#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080}"
EXPECTED_TEXT="${2:-Hello from Terraform Docker Lab}"

echo "Checking ${URL}"
response="$(curl --silent --show-error --fail "${URL}")"

if [[ "${response}" == *"${EXPECTED_TEXT}"* ]]; then
  echo "Verification successful: found expected text '${EXPECTED_TEXT}'."
else
  echo "Verification failed: expected text '${EXPECTED_TEXT}' not found."
  exit 1
fi

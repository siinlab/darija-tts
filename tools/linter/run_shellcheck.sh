#!/bin/bash
set -e

cd "$(dirname "$0")"
cd ../../

# Loop through each found shell script path and run shellcheck
find . -name '*.sh' | while IFS= read -r file; do
    shellcheck "$file"
done
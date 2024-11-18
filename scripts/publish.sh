#!/bin/bash

# needs to happen in this order because we bundle version number
# - update version
# - build js
# - publush

# Stop on error
set -e

dryrun=false
# Check if dryrun is set
for arg in "$@"; do
  if [ "$arg" == "--dryrun" ] || [ "$arg" == "--dry-run" ]; then
    dryrun=true
  fi
done

# Check if on main branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
  echo "You are not on the main branch. Please switch to the main branch to publish."
  exit 1
fi

# Check if there are uncommitted changes
if ! git diff --quiet; then
  echo "You have uncommitted changes. Please commit or stash them before publishing."
  exit 1
fi

# Read version type
echo "Enter version type (major, minor, patch):"
read bump

# Run update
npm run update

# Run tests
npm run test

npm --no-git-tag-version version $bump

# Run update again
npm run update

if [ "$dryrun" = false ]; then
  # Publish
  npm publish
else
  echo "Dry run mode: Skipping npm publish"
fi

# get the version from pacakge json
version=$(node -p "require('./package.json').version")

if [ "$dryrun" = false ]; then
  git add -A
  git commit -m "chore: publish $version"
  git push origin main
else
  echo "Dry run mode: Skipping git commit and push"
fi

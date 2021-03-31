#!/bin/sh
set -e

INPUT_BRANCH=${INPUT_BRANCH:-gh-pages}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'website/build/documentation'}
OUTPUT_DIRECTORY=${OUTPUT_DIRECTORY:-'gh-pages'}

echo "Push to branch $INPUT_BRANCH";
[ -z "${GITHUB_TOKEN}" ] && {
    echo 'Missing input "GITHUB_TOKEN=${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

rm -rf "${OUTPUT_DIRECTORY}"
cp -r "${INPUT_DIRECTORY}" "${OUTPUT_DIRECTORY}"

cd "${OUTPUT_DIRECTORY}"
git init
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
git add .
git commit -m "Push to Github Pages"

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git push "${remote_repo}" HEAD:${INPUT_BRANCH} --follow-tags --force

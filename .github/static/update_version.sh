#!/usr/bin/env bash
set -e

echo -e "\n### Setting commit user ###"
git config --local user.email "casper+github@welzel.nu"
git config --local user.name "Casper Welzel Andersen"

echo -e "\n### Update version in README if needed ###"
MAJOR_VERSION=$( echo ${GITHUB_REF#refs/tags/v} | cut -d "." -f 1 )
sed -i -r "s|check-sdist-action@v[0-9]+|check-sdist-action@v${MAJOR_VERSION}|g" README.md
git add README.md

if [ -n "$(git status --porcelain --untracked-files=no --ignored=no)" ]; then
    echo -e "\n### Commit update ###"
    git commit -m "Update README with v${MAJOR_VERSION}"

    echo -e "\n### Update new full version (v<MAJOR>.<MINOR>.<PATCH>) tag ###"
    TAG_MSG=.github/static/release_tag_msg.txt
    sed -i "s|TAG_NAME|${GITHUB_REF#refs/tags/}|g" "${TAG_MSG}"
    git tag -af -F "${TAG_MSG}" ${GITHUB_REF#refs/tags/}
fi

echo -e "\n### Update v<MAJOR> tag ###"
TAG_MSG=.github/static/major_version_tag_msg.txt
sed -i "s|MAJOR|${MAJOR_VERSION}|g" "${TAG_MSG}"

git tag -af -F "${TAG_MSG}" v${MAJOR_VERSION}

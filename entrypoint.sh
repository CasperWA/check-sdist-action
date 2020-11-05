#!/bin/sh
set -e

# (Option 2) Retrieve specified repository
if [ -n "${INPUT_REPOSITORY}" ]; then
    if [ -n "${INPUT_TOKEN}" ]; then
        # A token was also specified, retrieve using this token
        echo "Retrieving ${INPUT_REPOSITORY} using the supplied token ..."
        git clone https://${GITHUB_ACTOR}:${INPUT_TOKEN}@github.com/${INPUT_REPOSITORY}.git target_repo/
        echo "Retrieving ${INPUT_REPOSITORY} using the supplied token ... DONE!"
    else
        # No token specified
        echo "Retrieving ${INPUT_REPOSITORY} (without a token) ..."
        git clone https://github.com/${INPUT_REPOSITORY}.git target_repo/
        echo "Retrieving ${INPUT_REPOSITORY} (without a token) ... DONE!"
    fi
    cd target_repo

    if [ -n "${INPUT_BRANCH}" ]; then
        echo "Checking out the '${INPUT_BRANCH}' branch ..."
        git checkout -f ${INPUT_BRANCH}
        echo "Checking out the '${INPUT_BRANCH}' branch ... DONE!"
    fi
fi

# Build source distribution
SDIST_DIR=dist_action
python setup.py -v sdist -d ${SDIST_DIR}
SDIST_FILE=$( ls ${SDIST_DIR}/ )

# Save absolute path to checked out repository
ORIGINAL_PWD=$(pwd)

# Move to root directory to ensure we're not in a place where checked out files
# may be sourced
mkdir -p /tmp/installation_dir
cd /tmp/installation_dir
if [ "$(pwd)" = "${ORIGINAL_PWD}" ]; then
    echo "In original pwd: $(pwd)"
    echo "The installation should be run in a separate directory to avoid sourcing repository files!"
    exit 1;
fi

# pip install source distribution (archive)
pip install ${ORIGINAL_PWD}/${SDIST_DIR}/${SDIST_FILE}

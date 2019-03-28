#!/bin/bash
set -e

echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > .npmrc

if [[ "$TRAVIS_BRANCH" =~ ^feature\/.*$ ]]; then
    BRANCH_NAME=$(echo $TRAVIS_BRANCH | sed "s/[/]/-/g")
    TIMESTAMP=$(date +"%s")
    echo "--------------------------------------------"
    echo "|    Deploying snapshot on npm registry    |"
    echo "--------------------------------------------"
    npm version prerelease --preid=$BRANCH_NAME
    echo "++++++++++++++++++++++++++++++++++++++++++++"
    npm version
    echo "++++++++++++++++++++++++++++++++++++++++++++"
    npm publish --tag pull-request --access public
elif [[ "$TRAVIS_BRANCH" == "develop" ]] && [[ "$TRAVIS_PULL_REQUEST" == "false" ]]; then
    echo "--------------------------------------------"
    echo "|     Deploying latest on npm registry     |"
    echo "--------------------------------------------"
    npm version prepatch
    npm publish --tag next --access public
else
    echo "*************************************************"
    echo "*   Not a pull request, npm publish skipped !   *"
    echo "*************************************************"
fi

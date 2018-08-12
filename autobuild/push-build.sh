#!/bin/sh

# Checkout autobuild branch
cd $TRAVIS_BUILD_DIR
git clone https://github.com/goacoincore/goacoin.git --branch autobuild --single-branch repo_autobuild
cd repo_autobuild

# Copy newly created buila into the target directory
mkdir -p ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoind ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoin-cli ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoin-tx ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoind.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoin-cli.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/goacoin-tx.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/qt/goacoin-qt ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/src/qt/goacoin-qt.exe ./autobuild/$HOST/

# Setup git for commit and push
git config --global user.email "goacoincore@gmail.com"
git config --global user.name "Rama"
git remote add autobuild https://${AUTOBUILD_TOKEN}@github.com/goacoincore/goacoin.git > /dev/null 2>&1
git add ./autobuild/

# We don't want to run a build for a this commit in order to avoid circular builds: 
# add [ci skip] to the git commit message
git commit --message "Snapshot autobuild N.$TRAVIS_BUILD_NUMBER [ci skip]"
git push autobuild
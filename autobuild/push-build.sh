#!/bin/sh

# Checkout autobuild branch
cd $TRAVIS_BUILD_DIR
git clone https://github.com/goacoincore/goacoin.git --branch autobuild --single-branch repo_autobuild
cd repo_autobuild
#ls ..
#ls ../..
#ls goacoin

# Copy newly created buila into the target directory
#rm -r ./autobuild/$HOST/
mkdir -p ./autobuild/$HOST/

mv -f /home/travis/build/goacoincore/goacoin/goacoin-arm-linux-gnueabihf/src/goacoind ./autobuild/$HOST/
mv -f /home/travis/build/goacoincore/goacoin/goacoin-arm-linux-gnueabihf/src/goacoin-cli ./autobuild/$HOST/
mv -f /home/travis/build/goacoincore/goacoin/goacoin-arm-linux-gnueabihf/src/goacoin-tx ./autobuild/$HOST/


mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoin-tx ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoind ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoin-cli ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/qt/goacoin-qt ./autobuild/$HOST/

mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/qt/goacoin-qt.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoind.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoin-cli.exe ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/goacoin-tx.exe ./autobuild/$HOST/

mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/src/GoaCoin-Core.dmg ./autobuild/$HOST/
mv -f $TRAVIS_BUILD_DIR/goacoin-$HOST/GoaCoin-Core.dmg ./autobuild/$HOST/


# Setup git for commit and push
git config --global user.email "goacoincore@gmail.com"
git config --global user.name "Rama"
git remote add autobuild https://${AUTOBUILD_TOKEN}@github.com/goacoincore/goacoin.git > /dev/null 2>&1
git add ./autobuild/

# We don't want to run a build for a this commit in order to avoid circular builds: 
# add [ci skip] to the git commit message
git commit --message "Snapshot autobuild N.$TRAVIS_BUILD_NUMBER [ci skip]"
git push autobuild
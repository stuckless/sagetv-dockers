#!/usr/bin/env bash

# Steps
# 1. git clone sagetv into SOURCES
# 2. Edit CHANGELOG.md (set the date)
# 3. Edit Version.java (set the version)
# 4. Run this script
# 5. commit changes
#  (note if you have some modified files that you didn't modify)
#  (git checkout -f third_party/codecs/giflib/config.h.in third_party/codecs/giflib/configure)
# 6. git tag <tag_name> (usually the version V9.0.14)
# 7. git push origin <tag_name> (push the tag)
# 8. ./gradlew bintrayUpload

docker rm sagetv-build
docker run --name sagetv-build -t -v `pwd`/SOURCES/sagetv:/build stuckless/sagetv-build

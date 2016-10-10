#!/usr/bin/env bash

docker run --name sagetv-build -t -v `pwd`/SOURCES:/build stuckless/sagetv-build
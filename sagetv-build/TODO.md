Build unRAID template for rebuilding sagetv

OPT_BUILD_NATIVES=Y|N (if N then only build jar)
SAGETV_BRANCH=master (can use a )
SAGETV_REPO=main repo
SAGETV_OUTPUT= (dir where Sage.jar and .rpm and .tgz packages will be copied)

Advanced
SAGETV_SOURCES= (if set uses that dir, never fetches)
OPT_TAG=Y (only push tags if repo is sagetv main repo)
OPT_PUBLISH=Y (only if repo is sagetv main repo)
PUBLISH_GITHUB_USERNAME=
PUBLISH_GITHUB_PASSWORD=
PUBLISH_BINTRAY_USERNAME=
PUBLISH_BINTRAY_PASSWORD=

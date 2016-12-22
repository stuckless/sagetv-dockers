# Build SageTV From Sources

The docker image can be used to automatically fetch and build sagetv from the latest sources.

The follow command will fetch the sources from the main git repo and build sagetv in the ```SOURCES``` directory from the current directory.  When the command completes, the ```SOURCES/sagetv/build/``` directory will have all the build sagetv packages.  If an existing ```SOURCES/sagetv``` exists, it will be deleted, and a new set of sources will be fetched.

```
# docker rm sagetv-build
# docker run --name sagetv-build -t -v `pwd`/SOURCES:/build stuckless/sagetv-build
```

# Customizing the Build

## Using a different REPO

You can set the ```SAGETV_REPO``` environment variable on the command line to tell the image to build using an alternate repo, ie, your own dev repo, if you want.

```
# docker rm sagetv-build
# docker run --name sagetv-build -t -e SAGETV_REPO=YOUR_REPO_URL -v `pwd`/SOURCES:/build stuckless/sagetv-build
```

## Building Using Local Sources
In some cases, you may want to build sagetv, pointing it to a local set of sources.  In this case it will not fetch/update from the remote repo, and it will just rebuild using the ```sagetv``` directory that is pointed to in the ```/build``` mapping.

For example if your local git clone is ```/home/user/git/sagetv``` then the following command will rebuild sagetv in your local directory.

```
# docker rm sagetv-build
# docker run --name sagetv-build -t -v /home/user/git/sagetv:/build stuckless/sagetv-build
```

The build script will detect that ```/home/user/git/sagetv``` is a sagetv sources directory and just build using that.  (nothing will be deleted)
Builds latest comskip for linux

# Create the Docker Image
```# ./buildImage.sh```

If that worked you should see the image in your docker images

```# docker images```

# Build Comskip Binaries
```# ./build.sh```

if you want to follow along for the build, you can use

```# docker logs -f comskip```

When the build is complete, the static binaries will be in ```build/binaries/static/```

# Stripping
Need to run strip on the comskip binary to remove symbols

```
# strip --strip-all comskip
```

This reduces the size from 83m to 18m

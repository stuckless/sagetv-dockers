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



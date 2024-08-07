VERSION=$1

docker build --no-cache --progress=plain -t chrisvisserio/ionsst:$VERSION .

# docker login  -u cloudspider

# docker push cloudspider/ionsst:$VERSION

# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# docker run cloudspider/ionsst:$VERSION

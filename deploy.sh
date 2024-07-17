VERSION=$1

docker build -t cloudspider/ionsst:$VERSION . --no-cache --progress=plain

docker login  -u cloudspider

docker push cloudspider/ionsst:$VERSION

# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# docker run cloudspider/ionsst:$VERSION

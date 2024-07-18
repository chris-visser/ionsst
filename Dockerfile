FROM --platform=linux/amd64 imbios/bun-node:1.1.20-20.12.2-alpine

RUN apk update && \
    apk add \
    tar \
    gzip \
    curl \
    bash \
    yarn>4.3.1

RUN curl -fsSL https://ion.sst.dev/install | VERSION=0.0.532 bash

ENV SST_DIR="/root/.sst"
ENV PATH="$SST_DIR/bin:$PATH"

ENV SST_TELEMETRY_DISABLED="1"

RUN mkdir -p /dummy

RUN cd /dummy & yes | sst init \ 
    sst install --verbose

RUN /root/.config/sst/bin/pulumi plugin install resource aws v6.45.0

CMD ["/bin/bash"]
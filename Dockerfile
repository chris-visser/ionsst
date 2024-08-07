FROM --platform=linux/amd64 frolvlad/alpine-glibc:glibc-2.34

RUN apk add --no-cache curl bash tar gzip nodejs>20.12.2 yarn>4.4.0

RUN touch /root/.bashrc

RUN curl -fsSL https://ion.sst.dev/install | VERSION=0.1.81 bash

ENV SST_DIR="/root/.sst"
ENV PATH="$SST_DIR/bin:$PATH"
ENV SST_TELEMETRY_DISABLED="1"

WORKDIR /app

COPY ./sst.config.ts /sst.config.ts

RUN sst init --verbose | exit 0

RUN sst deploy --stage development --verbose | exit 0

# # RUN /root/.config/sst/bin/pulumi plugin install resource aws v6.45.0

# # RUN ls -la ~/.pulumi/plugins
# # RUN ls -la ~/.config/sst/bin

CMD ["/bin/bash"]
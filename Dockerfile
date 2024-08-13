FROM --platform=linux/amd64 frolvlad/alpine-glibc:glibc-2.34

# ARG AWS_ACCESS_KEY_ID
# ARG AWS_SECRET_ACCESS_KEY

RUN apk add --no-cache curl bash tar gzip nodejs>20.12.2 yarn>4.4.0

RUN touch /root/.bashrc

RUN curl -fsSL https://ion.sst.dev/install | VERSION=0.1.81 bash

ENV SST_DIR="/root/.sst"
ENV PATH="$SST_DIR/bin:$PATH"
ENV SST_TELEMETRY_DISABLED="1"

WORKDIR /app

COPY ./sst.config.ts ./sst.config.ts
COPY ./index.js ./index.js

# ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
# ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

RUN --mount=type=secret,id=aws_access_key_id \
    --mount=type=secret,id=aws_secret_access_key \
    export AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws_access_key_id) \
    && export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws_secret_access_key) \
    && sst deploy --stage development --verbose

# RUN sst deploy --stage development --verbose

CMD ["/bin/bash"]
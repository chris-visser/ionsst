FROM --platform=linux/amd64 frolvlad/alpine-glibc:glibc-2.34

# ARG AWS_ACCESS_KEY_ID
# ARG AWS_SECRET_ACCESS_KEY

RUN apk add --no-cache curl bash tar gzip nodejs>20.12.2 yarn>4.4.0

WORKDIR /app

ENV HOME=/root

RUN touch /root/.bashrc

RUN curl -fsSL https://sst.dev/install | VERSION=3.2.76 bash

ENV SST_DIR="/root/.sst"
ENV PATH="$SST_DIR/bin:$PATH"
# Prevent external telemetry from being sent
ENV SST_TELEMETRY_DISABLED="1"
ENV DO_NOT_TRACK="1"

ENV PATH="/root/.config/sst/bin:$SST_DIR/bin:$PATH"

COPY ./app .

# ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
# ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY


# RUN sst deploy --stage development --verbose --print-logs

RUN --mount=type=secret,id=aws_access_key_id \
    --mount=type=secret,id=aws_secret_access_key \
    export AWS_ACCESS_KEY_ID=$(cat /run/secrets/aws_access_key_id) \
    && export AWS_SECRET_ACCESS_KEY=$(cat /run/secrets/aws_secret_access_key) \
    && sst deploy --stage development --verbose --print-logs

RUN chmod -R 755 /root/.config


CMD ["/bin/bash"]
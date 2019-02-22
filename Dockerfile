FROM golang:1.11-stretch AS build-env
COPY . /go/src/app
RUN cd /go/src/app && \
    go get && \
    go build -o google_auth_proxy

# Copy binary into our real base image
FROM debian:stable-slim

EXPOSE 4180
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD []

RUN apt-get update \
  && apt-get install -y ca-certificates \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /.
COPY --from=build-env /go/src/app/google_auth_proxy /usr/bin/.

FROM debian:stable-slim

EXPOSE 4180
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD []

RUN apt-get update \
  && apt-get install -y ca-certificates \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

COPY google_auth_proxy /usr/bin/.
COPY docker-entrypoint.sh /.

FROM debian:stable-slim

EXPOSE 4180
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD []

COPY google_auth_proxy /usr/bin/.
COPY docker-entrypoint.sh /.

#!/bin/bash

if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then
    # If no args given, or first argument starts with '-', run our main app w/ args

    # -upstream arg can be declared multiple times, split variable on comma and build arg array
    IFS=',' read -r -a upstreams <<< "${GOOGLE_AUTH_PROXY_UPSTREAM}"
    declare -a upstream_args=()
    for upstream in "${upstreams[@]}" ; do
        upstream_args+=("--upstream=${upstream}")
    done

    exec "google_auth_proxy" \
        "--redirect-url=$GOOGLE_AUTH_PROXY_REDIRECT_URL" \
        "--email-domain=$GOOGLE_AUTH_PROXY_GOOGLE_APPS_DOMAIN" \
        "--cookie-secret=$GOOGLE_AUTH_PROXY_COOKIE_SECRET" \
        "--client-secret=$GOOGLE_AUTH_PROXY_CLIENT_SECRET" \
        "--client-id=$GOOGLE_AUTH_PROXY_CLIENT_ID" \
        "--pass-host-header=$GOOGLE_AUTH_PROXY_PASS_HOST_HEADER" \
        "--pass-basic-auth=$GOOGLE_AUTH_PROXY_PASS_BASIC_AUTH" \
        "--http-address=:${GOOGLE_AUTH_PROXY_HTTP_PORT:-4180}" \
        "${upstream_args[@]}"
else
    # Running some other command
    exec "$@"
fi

#!/bin/bash

if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then
    # If no args given, or first argument starts with '-', run our main app w/ args
    exec "google_auth_proxy" \
        "--redirect-url=$GOOGLE_AUTH_PROXY_REDIRECT_URL" \
        "--upstream=$GOOGLE_AUTH_PROXY_UPSTREAM" "--google-apps-domain=$GOOGLE_AUTH_PROXY_GOOGLE_APPS_DOMAIN" \
        "--cookie-secret=$GOOGLE_AUTH_PROXY_COOKIE_SECRET" "--client-secret=$GOOGLE_AUTH_PROXY_CLIENT_SECRET" \
        "--client-id=$GOOGLE_AUTH_PROXY_CLIENT_ID" "--pass-basic-auth=$GOOGLE_AUTH_PROXY_PASS_BASIC_AUTH"
else
    # Running some other command
    exec "$@"
fi

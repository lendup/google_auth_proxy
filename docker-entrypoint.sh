#!/bin/bash

if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then
    # If no args given, or first argument starts with '-', run our main app w/ args
    # TODO: convert env vars into options
    exec "google_auth_proxy" "$@"
else
    # Running some other command
    exec "$@"
fi

#!/usr/bin/env bash
set -e

if [ $# -gt 0 ] && command -v "$1" &> /dev/null; then
    exec "$@"
fi

exec opencode "$@"

#!/bin/bash

MBSYNC=$(pgrep mbsync)
NOTMUCH=$(pgrep notmuch)

if [ -n "$MBSYNC" -o -n "$NOTMUCH" ]; then
  echo "Already running a mail sync. Exiting..."

  exit 0
fi

set -xe

mbsync -Va

notmuch new 2>&1 | grep -v "Ignoring non-mail file"

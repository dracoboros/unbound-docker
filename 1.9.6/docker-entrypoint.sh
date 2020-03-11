#!/bin/bash
if [ -z "$SKIP_ROOT_KEY" ]
then
    unbound-anchor -v
fi
exec "$@"
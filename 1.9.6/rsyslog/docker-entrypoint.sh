#!/bin/bash
if [ -z "$SKIP_ROOT_KEY" ]
then
    unbound-anchor -v
    chown unbound:unbound /opt/unbound/etc/unbound/root.key
fi
rsyslogd 
exec "$@"
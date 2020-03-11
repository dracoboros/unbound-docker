# Unbound Docker Images

## Images:

- [`1.9.6`, `latest`](https://github.com/dracoboros/unbound-docker/tree/master/1.9.6)
- [`1.9.6-rsyslog`](https://github.com/dracoboros/unbound-docker/tree/master/1.9.6/rsyslog)

## Image Variants

### `unbound:<version>-rsyslog`

This image contains rsyslog shipped along with Unbound. It may be useful when it is needed to export queries and replies logs to a file or remote syslog server.

## Environment Variables

### `SKIP_ROOT_KEY`

By default, the images in this repository executes `unbound-anchor` at entrypoint. It can be skipped if this variable is set to any non blank value.

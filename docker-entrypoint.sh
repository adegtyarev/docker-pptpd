#!/bin/sh

set -ex

if [ "${1:0:1}" = '-' ]; then
    exec pptpd "$@"
fi

echo $1 | grep -q ^pptpd- || exec "$@"

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

case $1 in
    'pptpd-chap')
        pptpd && syslogd -n -O /dev/stdout
    ;;
esac

source /tmp/lib.sh

if ! rpm -q avahi >/dev/null 2>&1 || { rpm -q avahi >/dev/null 2>&1 && ! systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL

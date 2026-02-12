source /tmp/lib.sh

if ! rpm -q squid >/dev/null 2>&1 || { rpm -q squid >/dev/null 2>&1 && ! systemctl is-enabled squid.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active squid.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL

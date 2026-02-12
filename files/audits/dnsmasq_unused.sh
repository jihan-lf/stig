source /tmp/lib.sh

if ! rpm -q dnsmasq >/dev/null 2>&1 || { rpm -q dnsmasq >/dev/null 2>&1 && ! systemctl is-enabled dnsmasq.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active dnsmasq.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL

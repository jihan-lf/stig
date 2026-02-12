source /tmp/lib.sh

if ! rpm -q net-snmp >/dev/null 2>&1 || { rpm -q net-snmp >/dev/null 2>&1 && ! systemctl is-enabled snmpd.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active snmpd.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL

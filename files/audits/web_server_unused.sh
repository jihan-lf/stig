source /tmp/lib.sh

if ! rpm -q httpd nginx >/dev/null 2>&1 || { rpm -q httpd nginx >/dev/null 2>&1 && ! systemctl is-enabled httpd.socket httpd.service nginx.service 2>/dev/null | grep -q 'enabled' && ! systemctl is-active httpd.socket httpd.service nginx.service 2>/dev/null | grep -q '^active'; }; then exit $PASS; fi
exit $FAIL

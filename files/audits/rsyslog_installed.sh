source /tmp/lib.sh

if systemctl is-active --quiet systemd-journald; then
  exit $PASS
fi

if systemctl is-active --quiet rsyslog; then
  if rpm -q rsyslog &>/dev/null; then exit $PASS; fi
  exit $FAIL
fi

exit $PASS

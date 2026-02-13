source /tmp/lib.sh

if systemctl is-active --quiet systemd-journald; then
  exit $PASS
fi

if systemctl is-active --quiet rsyslog; then
  if systemctl is-enabled rsyslog 2>/dev/null | grep -qx 'enabled' && \
     systemctl is-active rsyslog.service 2>/dev/null | grep -qx 'active'; then
    exit $PASS
  fi
  exit $FAIL
fi

exit $PASS

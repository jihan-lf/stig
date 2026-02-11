source /tmp/lib.sh

# check if bluez package is installed
if rpm -q bluez >/dev/null 2>&1; then
    # check if bluetooth service is enabled or active
    if systemctl is-enabled bluetooth.service 2>/dev/null | grep -q '^enabled'; then
        exit $FAIL
    fi
    if systemctl is-active bluetooth.service 2>/dev/null | grep -q '^active'; then
        exit $FAIL
    fi
fi

exit $PASS  

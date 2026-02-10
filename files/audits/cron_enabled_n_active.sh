source /tmp/lib.sh      

# Check if cron is enabled
if ! systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}' | grep -q '^enabled$'; then
    exit $FAIL
fi

# Check if cron is active
if ! systemctl list-units | awk '$1~/^crond?\.service/{print $3}' | grep -q '^active$'; then
    exit $FAIL
fi

exit $PASS
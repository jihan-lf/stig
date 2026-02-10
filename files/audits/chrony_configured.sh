source /tmp/lib.sh      

if rpm -q chrony &>/dev/null; then
    if grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/ &>/dev/null; then
        exit $PASS
    fi
fi
exit $FAIL
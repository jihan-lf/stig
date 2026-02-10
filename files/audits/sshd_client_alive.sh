source /tmp/lib.sh      

if [ -z "$(sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)')" ]; then exit $PASS; fi
exit $FAIL
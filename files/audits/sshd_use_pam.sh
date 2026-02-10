source /tmp/lib.sh

if [ "$(sshd -T | grep usepam | awk '{print $1}')" == "yes" ]; then exit $PASS; fi
exit $FAIL
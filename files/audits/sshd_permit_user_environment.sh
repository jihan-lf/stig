source /tmp/lib.sh

if [ "$(sshd -T | grep permituserenvironment | awk '{print $1}')" == "no" ]; then exit $PASS; fi
exit $FAIL
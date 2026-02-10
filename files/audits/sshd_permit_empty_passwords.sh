source /tmp/lib.sh      

if [ "$(sshd -T | grep permitemptypasswords | awk '{print $1}')" == "no" ]; then exit $PASS; fi
exit $FAIL
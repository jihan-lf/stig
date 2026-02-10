source /tmp/lib.sh      

if [ "$(sshd -T | grep maxauthtries | awk '{print $2}')" -le 4 ]; then exit $PASS; fi
exit $FAIL
source /tmp/lib.sh

if sshd -T | grep -Pi '^\h*gssapiauthentication\h+no\b' | awk '{print $2}' == "no"; then
  exit $PASS
fi

exit $FAIL  
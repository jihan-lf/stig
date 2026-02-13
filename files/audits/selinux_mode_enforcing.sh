source /tmp/lib.sh      

setenforce 1

if grep -Eq '^\s*SELINUX=enforcing\b' /etc/selinux/config && \
   [ "$(getenforce)" = "Enforcing" ]; then
  exit $PASS
fi
exit $FAIL

source /tmp/lib.sh

if [ "$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin | cut -d' ' -f2)" == 'no' ]; then exit $PASS; fi
exit $FAIL


#this setting is not only done in /etc/ssh/sshd_conf but also in:
#etc/ssh/sshd_config.d/01-permitrootlogin.conf


# AppArmor Profile for SSH (usr.sbin.sshd)
# Created: Week 1
# Location: /etc/apparmor.d/usr.sbin.sshd

#include <tunables/global>

/usr/sbin/sshd {
  #include <abstractions/base>
  #include <abstractions/nameservice>
  
  capability setuid,
  capability setgid,
  capability chown,
  capability fowner,
  capability fsetid,
  capability kill,
  capability net_bind_service,
  
  /usr/sbin/sshd mr,
  /etc/ssh/* r,
  /var/log/auth.log w,
  /var/run/sshd.pid rw,
  
  # Deny raw network access (restricts unnecessary network operations)
  deny network raw,
}

# To load this profile:
# sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.sshd
#
# To verify it's loaded:
# sudo aa-status | grep sshd
#
# To unload:
# sudo apparmor_parser -R /etc/apparmor.d/usr.sbin.sshd


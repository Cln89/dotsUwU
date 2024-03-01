# dotsUwU

#Fixing unable to import GPG:
`~/.gnupg/gpg.conf`

```no-greeting
no-permission-warning
lock-never
keyserver-options timeout=10
keyserver-options import-clean
keyserver-options no-self-sigs-only
keyserver hkp://keyserver.ubuntu.com:80```

#!/usr/bin/expect -f
spawn krb5_newrealm
expect "Enter KDC database master key:"
send "yourpassword\r"
expect "Re-enter KDC database master key to verify:"
send "yourpassword\r"
interact
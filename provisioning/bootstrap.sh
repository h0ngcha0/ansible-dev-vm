#!/bin/sh

## Set the timezone
## -------------------------------------------------------------------

# It is probably better idea to keep the VM UTC and adapt the scripts so that
# they don't assume they are running in CET
echo "CET" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

## Disable ssh locale forwarding
## -------------------------------------------------------------------
sed -i /etc/ssh/sshd_config -e 's/^AcceptEnv/#AcceptEnv/'

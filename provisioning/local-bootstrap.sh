#!/bin/sh
#
# This is run with the local user credentials
#
# Vagrant should be passing the user name as first argument

set -e

# Switch to local user
if [ "$USER" = "root" ]; then
    su vagrant -c "$0 $@"
    exit 0
fi

if [ "$#" != "1" ]; then
    echo "Usage $(basename $0) <username>" >&2
    echo 1>&2
    echo "This is a bug in the Vagrantfile" 1>&2
    exit 1
fi

HOST_USER_NAME=$1

## Configure some ~/.* files
##====================================================================

cat <<EOF > $HOME/.ssh/config

host git*
StrictHostKeyChecking no
user $HOST_USER_NAME

EOF

cat <<EOF > $HOME/.gitconfig
[user]
        name = $HOST_USER_NAME
        email = $HOST_USER_NAME@klarna.com
[push]
        default = upstream
EOF

#STASH="ssh://git@stash.internal.machines:7999/fredp"
#REPOS="fred_platform.git \
#    gitrdun.git \
#    ansible_playground.git \
#    fred.git \
#    slurpie.git"

## Clone the repos we want to have here
##====================================================================

mkdir -p $HOME/src
cd $HOME/src

#for i in $REPOS; do
#    # Delete first so that this just resets the repos when re-provisioning
#    rm -rf ${i%\.git}
#    git clone $STASH/$i
#done

#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ ! -f /etc/local/.cloud/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
. /etc/local/.cloud/hetzner/$account.sh

result=`/opt/farm/ext/cloud-client-hetzner/support/hcloud image list |grep ubuntu`

if [ "$result" = "" ]; then
	echo "error: cloud account \"$1\" has invalid credentials"
fi

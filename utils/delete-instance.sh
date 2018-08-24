#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <instance-name>"
	exit 1
elif [ ! -f /etc/local/.cloud/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
name=$2

. /etc/local/.cloud/hetzner/$account.sh
/opt/farm/ext/cloud-client-hetzner/support/hcloud server delete $name

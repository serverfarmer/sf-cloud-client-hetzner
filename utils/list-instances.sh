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

/opt/farm/ext/cloud-client-hetzner/support/hcloud server list -o columns=ipv4,status,datacenter,name \
	|grep -v ^IPV4 \
	|/opt/farm/ext/cloud-client-hetzner/internal/parse-instances.php

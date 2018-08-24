#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <cloud-account> <ssh-key-name> [instance-type]"
	exit 1
elif [ ! -f /etc/local/.cloud/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
fi

account=$1
key=$2
random=`date +%s |md5sum |head -c 4`
name=$key-$random

. /etc/local/.cloud/hetzner/$account.sh

if [ "$3" != "" ]; then
	type=$3
else
	type=$HETZNER_DEFAULT_INSTANCE_TYPE
fi

/opt/farm/ext/cloud-client-hetzner/support/hcloud server create \
	--name $name \
	--type $type \
	--datacenter $HETZNER_REGION \
	--image $HETZNER_IMAGE \
	--ssh-key $key \
	|grep IPv4 \
	|awk '{ print $2 }' \
	|/opt/farm/ext/cloud-client-hetzner/internal/parse-create.php

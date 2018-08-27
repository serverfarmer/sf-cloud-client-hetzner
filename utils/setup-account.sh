#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "$1" = "" ]; then
	echo "usage: $0 <cloud-account>"
	exit 1
elif [ -f /etc/local/.cloud/hetzner/$1.sh ]; then
	echo "error: cloud account \"$1\" already configured"
	exit 1
fi

API_TOKEN="`input \"enter Hetzner Cloud project api token\" put-your-token-here`"
REGION="`input \"enter Hetzner Cloud region to use\" fsn1-dc8`"
DEFAULT_INSTANCE_TYPE="`input \"enter Hetzner Cloud default instance type\" cx11`"

mkdir -p /etc/local/.cloud/hetzner
echo "#!/bin/sh
#
# Hetzner Cloud project API token:
#
export HCLOUD_TOKEN=$API_TOKEN
#
# region to use (fsn1-dc8, nbg1-dc3, hel1-dc2, fsn1-dc14):
#
export HETZNER_REGION=$REGION
#
# default instance type to use, when type isn't explicitely specified
#
export HETZNER_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/hetzner/$1.sh
chmod 0600 /etc/local/.cloud/hetzner/$1.sh

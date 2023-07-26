#!/bin/sh
# sleep 10
ETH_CARD='eth0'
ZONE_ID='123456789'
DNS_ID='123456789'
EMAIL='123456789@abc.com'
AUTH_KEY='123456789'
DNS_TYPE='AAAA'
HOST_NAME='www'

ROOT_DIR=$(dirname $(readlink -f "$0"))
. ${ROOT_DIR}/ipv6-config

IP6=`ip -6 addr show dev ${ETH_CARD} | grep global | awk '{print $2}' | awk -F "/" '{print $1}' | head -1`
[ -z ${IP6} ] && exit
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
    -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json" \
    --data '{"type":"'"${DNS_TYPE}"'","name":"'"${HOST_NAME}"'","content":"'"${IP6}"'","ttl":120,"proxied":false}'

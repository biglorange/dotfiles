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
# . ${ROOT_DIR}/ipv6-config

# IP6=`ip -6 addr show dev ${ETH_CARD} | grep global | awk '{print $2}' | awk -F "/" '{print $1}' | head -1`
# [ -z ${IP6} ] && exit
# curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
#     -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json" \
#     --data '{"type":"'"${DNS_TYPE}"'","name":"'"${HOST_NAME}"'","content":"'"${IP6}"'","ttl":120,"proxied":false}'
# https://cdn.jsdelivr.net/gh/NateScarlet/holiday-cn@master/{年份}.json
# 可以获取法定节假日进行判断
get_proxy_flag()
{
    current_hour=$(date +%H)
    current_date=$(date +%u)

    proxy_flag="false"

    if [[ ${current_date} -ge 1 && ${current_date} -le 5 && ${current_hour} -ge 8 && ${current_hour} -le 18 ]]; then
        proxy_flag="true"
    fi

    echo "${proxy_flag}"
}



ipv6_ddns_set()
{
    [ $# lt 1 ] && exit
    config_file=$1
    . ${ROOT_DIR}/${config_file}

    PROXY="$(get_proxy_flag)"

    tmp_result=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json")

    old_ipv6_address="$(echo "${tmp_result}" | grep -oE '"content":"[0-9a-fA-F:]*"' | awk -F'"' '{print $4}')"
    old_proxy_flag="$(echo "${tmp_result}" | grep -oE '"proxied":(false)|(true)' | awk -F':' '{print $2}' | tr -d '\n')"

    IP6=`ip -6 addr show dev ${ETH_CARD} | grep global | awk '{print $2}' | awk -F "/" '{print $1}' | head -1`
    [ -z ${IP6} ] && exit
    # ipv6 地址以 fe 开头则是本地地址
    [[ "${IP6}" == fe* || "${old_ipv6_address}" == "${IP6}" && ${old_proxy_flag} == "${PROXY}" ]] && exit
    curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json" \
        --data '{"type":"'"${DNS_TYPE}"'","name":"'"${HOST_NAME}"'","content":"'"${IP6}"'","ttl":120,"proxied":'"${PROXY}"'}'
}


ipv6_ddns_set ipv6-config

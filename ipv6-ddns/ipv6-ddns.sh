#!/bin/sh
# sleep 10
ETH_CARD='eth0'
ZONE_ID='123456789'
DNS_ID='123456789'
EMAIL='123456789@abc.com'
AUTH_KEY='123456789'
DNS_TYPE='AAAA'
HOST_NAME='www'
# NEED_PROXY='false'

ROOT_DIR=$(dirname $(readlink -f "$0"))
# . ${ROOT_DIR}/ipv6-config

# IP6=`ip -6 addr show dev ${ETH_CARD} | grep global | awk '{print $2}' | awk -F "/" '{print $1}' | head -1`
# [ -z ${IP6} ] && exit
# curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
#     -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json" \
#     --data '{"type":"'"${DNS_TYPE}"'","name":"'"${HOST_NAME}"'","content":"'"${IP6}"'","ttl":120,"proxied":false}'
# https://cdn.jsdelivr.net/gh/NateScarlet/holiday-cn@master/{年份}.json
# https://raw.githubusercontent.com/NateScarlet/holiday-cn/master/{年份}.json
# 可以获取法定节假日进行判断
get_proxy_flag()
{
    start_hour=900
    end_hour=1800

    current_weekday=$(date +%u)
    current_year=$(date +%Y)
    current_date=$(date +%Y-%m-%d)
    current_time=$(date +%-H%M)

    year_holiday_json="${ROOT_DIR}/${current_year}.json"

    [ -f "${year_holiday_json}" ] || curl https://raw.githubusercontent.com/NateScarlet/holiday-cn/master/${current_year}.json -o ${year_holiday_json}

    tmp_holiday=`cat "${year_holiday_json}" | grep -B 1 -A 1 "${current_date}"`

    # 日期在法定假日表中，但不是节假日，则是中国特色调休，需要上班
    tmp_is_holiday_flag=`echo "${tmp_holiday}" | grep -oE '"isOffDay": .*' | awk -F': ' '{print $2}'`

    proxy_flag="false"

    if [[ "${tmp_is_holiday_flag}" == "false" &&
        ${current_weekday} -ge 1 && ${current_weekday} -le 5 &&
        ${current_time} -ge ${start_hour} && ${current_time} -le ${end_hour} ]]; then
        proxy_flag="true"
        echo "${proxy_flag}"
        return
    fi

    if [[ ${current_weekday} -ge 1 && ${current_weekday} -le 5 &&
        ${current_time} -ge ${start_hour} && ${current_time} -le ${end_hour} ]]; then
        proxy_flag="true"
        echo "${proxy_flag}"
        return
    fi

    echo "${proxy_flag}"
}

ipv6_ddns_set()
{
    [ $# -lt 1 ] && return
    config_file=$1
    . ${config_file}

    old_ipv6_address_file=${ROOT_DIR}/"config_"$(basename "${config_file}")

    IP6=`ip -6 addr show dev ${ETH_CARD} | grep global | awk '{print $2}' | awk -F "/" '{print $1}' | head -1`
    [ -z ${IP6} ] && return
    # ipv6 地址以 fe 开头则是本地地址
    [[ "${IP6}" == fe* ]] && return

    if [ -f "${old_ipv6_address_file}" ]; then
        old_ipv6_address=`head -n 1 ${old_ipv6_address_file} | tr -d '\n'`
        old_proxy_flag=`sed -n '2p' ${old_ipv6_address_file} | tr -d '\n'`
    fi

    PROXY="false"
    if [[ "${NEED_PROXY}" == "true" ]]; then
        PROXY="$(get_proxy_flag)"
    fi

    [[ "${old_ipv6_address}" == "${IP6}" && "${old_proxy_flag}" == "${PROXY}" ]] && return

    tmp_result=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json")

    old_ipv6_address="$(echo "${tmp_result}" | grep -oE '"content":"[0-9a-fA-F:]*"' | awk -F'"' '{print $4}')"
    old_proxy_flag="$(echo "${tmp_result}" | grep -oE '"proxied":(false)|(true)' | awk -F':' '{print $2}' | tr -d '\n')"


    if [[ "${old_ipv6_address}" == "${IP6}" && ${old_proxy_flag} == "${PROXY}" ]]; then
        echo "${IP6}" > "${old_ipv6_address_file}"
        echo "${PROXY}" >> "${old_ipv6_address_file}"
        return
    fi

    curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${EMAIL}" -H "X-Auth-Key: ${AUTH_KEY}" -H "Content-Type: application/json" \
        --data '{"type":"'"${DNS_TYPE}"'","name":"'"${HOST_NAME}"'","content":"'"${IP6}"'","ttl":120,"proxied":'"${PROXY}"'}'

    echo "${IP6}" > "${old_ipv6_address_file}"
    echo "${PROXY}" >> "${old_ipv6_address_file}"

    echo "\n"
    return
}

for file in "${ROOT_DIR}"/ipv6-conf*; do
    if [ -f "${file}" ]; then
        ipv6_ddns_set "${file}"
    fi
done

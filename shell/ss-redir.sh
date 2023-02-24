#!/usr/bin/bash

ss-redir -v -c /etc/shadowsocks/shadowsocks.json
iptables -t nat -N SHADOWSOCKS
# 在 nat 表中创建新链
iptables -t nat -A SHADOWSOCKS -p tcp --dport 443 -j RETURN
# 23596 是 ss 代理服务器的端口，即远程 shadowsocks 服务器提供服务的端口，如果你有多个 ip 可用,但端口一致，就设置这个

#iptables -t nat -A SHADOWSOCKS -d 2607:fcd0:106:3206:0:1:c46c:d024 -j RETURN
# 123.456.789.111 是 ss 代理服务器的 ip, 如果你只有一个 ss服务器的 ip，却能选择不同端口,就设置此条

iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-ports 7777
# 7777 是 ss-redir 的监听端口,ss-local 和 ss-redir 的监听端口不同,配置文件不同
iptables -t nat -I PREROUTING -p tcp -j SHADOWSOCKS
# 在 PREROUTING 链前插入 SHADOWSOCKS 链,使其生效

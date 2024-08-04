#!/usr/bin/python3
# -* - coding: UTF-8 -* -

import sys
import os

IPs = [
    {
        'ip':'192.168.123.5',
        'port':'41134',
        'user':'root',
        'folder':[
            "/root/scripts",
            "/root/docker",
            "/home/orange/docker",
            "/home/orange/scripts",
            ],
        'exclude':[
            ".cache",
            "log",
            "logs",
            "nextcloud",
            "metadata",
            "plugins",
            "transcodes",
            "jellyfin/data",
            "jellyfin/root/default",
            "jellyfin/config/dlna",
            "plex_config",
            "photoprism/cache",
            "photoprism/sidecar",
            "photoprism/users",
            "photoprism/albums",
            "ipc-socket",
            "session.lock",
            "navidrome/cache",
            "music_tag_web/tmp",
            "ikaros/data/web.log",
            "emby/config/cache",
            "emby/config/transcoding-temp",
            "baidupan",
            "alist/temp",
            ]
    },
    {
        'ip':'192.168.123.12',
        'port':'41134',
        'user':'root',
        'folder':[
            "/home/orange/docker",
            "/home/orange/scripts",
            ],
        'exclude':[
            ".cache",
            "log",
            "logs",
            "metadata",
            "plugins",
            "transcodes",
            "ipc-socket",
            "session.lock",
            "navidrome/cache",
            "music_tag_web/tmp",
            "ikaros/data/web.log",
            "emby/config/cache",
            "emby/config/transcoding-temp",
            "baidupan",
            "alist/temp",
            "moviepolit/core",
            "ib_logfile0",
            "iyuu/src",
            ]
    },
    {
        'ip':'192.168.123.6',
        'port':'41134',
        'user':'root',
        'folder':[
            "/root/scripts",
            "/root/docker",
            "/home/orange/docker",
            "/home/orange/scripts",
            ],
        'exclude':[
            "log",
            "logs",
            "metadata",
            "plugins",
            "transcodes",
            "adguard/work/data/querylog.json"
            "vaultwarden/icon_cache",
            "nginx-proxy-manager/logs",
            "postgres",
            ]
    },
]

save_path='/home/orange/Documents/04_OS/Linux/02_pve'

def rsync_one(server):

    save_folder = save_path + '/' + server['ip']
    if not os.path.exists(save_folder):
        os.mkdir(save_folder)
    for folder in server['folder']:
        save_folder = save_path + '/' + server['ip'] + '/'
        cmd = "rsync -e 'ssh -p %s' -azh %s@%s:%s %s --delete " %(server['port'], server['user'], server['ip'], folder, save_folder)

        for ignore in server['exclude']:
            cmd = cmd + '--exclude="%s" ' %(ignore)

        os.system(cmd)

if len(sys.argv) > 1:
    save_path = sys.argv[1]
    print(sys.argv[1])
    for ip in IPs:
        rsync_one(ip)

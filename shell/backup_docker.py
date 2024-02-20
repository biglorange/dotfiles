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
            "cache",
            "photoprism/sidecar",
            "photoprism/users",
            "photoprism/albums",
            "ipc-socket",
            "session.lock",
            "Library/Application Support/Plex Media Server",
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
            "logs"
            "metadata",
            "plugins",
            "transcodes",
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

#!/usr/bin/python3
# -* - coding: UTF-8 -* -

import sys
import os
# from datetime import datetime

IPs = [
    {'ip':'192.168.123.5', 'port':'41134', 'user':'root','folder':["/root/scripts", "/root/docker"], 'exclude':[".cache", "log", "nextcloud", "metadata", "plugins", "transcodes", "jellyfin/data", "logs", "jellyfin/root/default"]},
    {'ip':'192.168.123.6', 'port':'41134', 'user':'root','folder':["/root/scripts", "/root/docker"], 'exclude':["log", "metadata", "plugins", "transcodes", "logs"]},
]

save_path='/home/orange/Documents/04_OS/Linux/02_pve'

# onedrive_path='/home/orange/OneDrive/OS/linux/pve'

# exclude_file_list = '--exclude=".*" --exclude=nextcloud --exclude=log --exclude=metadata --exclude=plugins --exclude=transcodes --exclude=jellyfin/data --exclude=logs'

def rsync_one(server):

    save_folder = save_path + '/' + server['ip']
    if not os.path.exists(save_folder):
        os.mkdir(save_folder)
    for folder in server['folder']:
        save_folder = save_path + '/' + server['ip'] + '/'
        # print(save_folder)
        cmd = "rsync -e 'ssh -p %s' -avzh %s@%s:%s %s --delete " %(server['port'], server['user'], server['ip'], folder, save_folder)

        for ignore in server['exclude']:
            cmd = cmd + '--exclude="%s" ' %(ignore)

        print(cmd)
        os.system(cmd)



# time_stamp = datetime.now().strftime("%Y-%m-%d")
# print(save_path.split('/')[-1])
# cmd = "cd %s && tar -czvf %s/../pve_bk_%s.tgz -C%s/ *" %(save_path, save_path, time_stamp, save_path)
# print(cmd)
# os.system(cmd)

if len(sys.argv) > 1:
    save_path = sys.argv[1]
    # print(sys.argv[1])
    for ip in IPs:
        rsync_one(ip)

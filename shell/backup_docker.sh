#!/usr/bin/bash

DATE=$(date +%F)

save_path='/home/orange/Documents/04_OS/Linux/02_pve'

onedrive_path='/home/orange/OneDrive/OS/linux/pve'

python3 ./backup_docker.py ${save_path}

cd ${save_path}

save_file=${save_path}/../pve_bk_${DATE}.tgz
# tar -czvf ${save_path}/../pve_bk_${DATE}.tgz -C${save_path}/ *

tar -czvf ${save_file} -C${save_path}/ *


last_bk=`ls -t ${onedrive_path} | head -1`

last_bk_md5=`md5sum ${onedrive_path}/${last_bk} | awk '{print $1}'`

new_bk_md5=`md5sum ${save_file} | awk '{print $1}'`

# echo ${last_bk_md5}

# echo ${new_bk_md5}

if [[ ${last_bk_md5} == ${new_bk_md5} ]]; then
    echo "no need to create new backup"
    rm ${save_file}
else
    cp ${save_file} ${onedrive_path}/

    cd ${onedrive_path}

    find ./ -type d -mtime +7 | xargs rm -rf
fi

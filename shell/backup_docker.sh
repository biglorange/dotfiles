#!/usr/bin/bash

max_version_num=7

WORK_DIR=$(dirname $(readlink -f $0))

echo $WORK_DIR

DATE=$(date +%F)

save_path='/home/orange/Documents/04_OS/Linux/02_pve'

onedrive_path='/home/orange/OneDrive/OS/linux/pve'

python3 ${WORK_DIR}/backup_docker.py ${save_path}

cd ${save_path}

save_file=${save_path}/../pve_bk_${DATE}.tgz

tar -czf ${save_file} -C${save_path}/ *

sleep 1

last_bk=`ls -t ${onedrive_path} | head -1`

last_bk_md5=`md5sum ${onedrive_path}/${last_bk} | awk '{print $1}'`

new_bk_md5=`md5sum ${save_file} | awk '{print $1}'`

if [[ ${last_bk_md5} == ${new_bk_md5} ]]; then
    echo "no need to create new backup"
    rm ${save_file}
else
    cp ${save_file} ${onedrive_path}/

    cd ${onedrive_path}

    backup_files=$(ls -t "${onedrive_path}")

    num_files=$(echo "${backup_files}" | wc -l)

    if [ "${num_files}" -gt "${max_version_num}" ]; then
        num_files_to_delete=$((num_files - max_version_num))
        echo "${backup_files}" | tail -n "${num_files_to_delete}" | xargs -I {} rm -f {}
    fi
fi

#!/bin/bash

IP=${1:-}
FUPDATE=${2:-}

SCRIPTDIR=/home/${USER}/azure/scripts

if [[ ${FUPDATE} == "update" ]]; then
    echo "Only update codes"
    scp DCM_* ${USER}@${IP}:${SCRIPTDIR}/
    exit 0
fi

if [[ ${FUPDATE} == "" ]]; then
    echo "Copying scripts"
    scp -rp ${SCRIPTDIR} ${USER}@${IP}:azure/

    #Backup out current crontab
    echo "Backup crontab"
    ssh ${USER}@${IP} crontab -l > ${SCRIPTDIR}/mycron.backup
    #install new cron file
    echo "Setup crontab"
    ssh ${USER}@${IP} crontab ${SCRIPTDIR}/crontab_file
else
    echo "Unrecognized argument"
    exit 0
fi

#!/bin/bash

IP=${1:-}
FUPDATE=${2:-}

SCRIPTDIR=/home/${USER}/matlabsrc/DCM_scheduler

if [[ ${FUPDATE} == "update" ]]; then
    echo "Update codes for DCM_scheduler"
    scp DCM_* ${USER}@${IP}:${SCRIPTDIR}/
    echo "Update matlab batches (Ctrl+C to abort)"
    scp -rp ${SCRIPTDIR}/batch ${USER}@${IP}:${SCRIPTDIR}/
    exit 0
fi

if [[ ${FUPDATE} == "" ]]; then
    echo "Copying scripts"
    scp -rp ${SCRIPTDIR} ${USER}@${IP}:matlabsrc/
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

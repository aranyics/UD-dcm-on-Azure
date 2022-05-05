#!/bin/bash

MAXTHREADS=5
PROJDIR=${HOME}/matlabsrc
LOGDIR=${PROJDIR}/DCM_scheduler/logs
#TORUN=test_sleep.sh
TORUN=DCM_start.sh

mkdir -p ${LOGDIR}

PID=`pgrep -f "${TORUN}"`

if [[ $1 == "query" ]]; then
    echo ${PID}
    exit 0
fi

if [[ $1 == "kill" ]]; then
    echo "killing: $2"
    kill $2
    exit 0
fi

k=0

while true
do
    PID=`pgrep -f "${TORUN}"`
    PIDS=(${PID// / })
    NPIDS=0
    if [[ ! ${PIDS} == "" ]]; then NPIDS=${#PIDS[@]}; fi
    echo "$NPIDS running"
    if [[ ${NPIDS} -lt ${MAXTHREADS} ]]; then
        echo "starting script"
        LOGFILE=`date +"%F"`_`date +"%T"`.log
        nohup ${PROJDIR}/DCM_scheduler/${TORUN} >>${LOGDIR}/${LOGFILE} 2>&1 </dev/null &
        #nohup ${PROJDIR}/scripts/${TORUN} 2>&1 </dev/null &
    else
        echo "already running $NPIDS"
        exit 0
    fi

    k=$((k+1))
    if [[ $k -gt 10 ]]; then
        echo "timeout"
        exit 0
    fi

    sleep 60

done

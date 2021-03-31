#!/bin/bash

PROJDIR=${HOME}/azure
DCMDIR=${PROJDIR}/analysis/DCM/largescale/conn
RESULTSDIR=${PROJDIR}/analysis/DCM/largescale/results/par
BATCHDIR=${PROJDIR}/scripts/batch
MATLAB=/usr/local/bin/matlab

for F in `ls ${PROJDIR}/DCM*`;
do
    FB=`basename $F`
    FBPARTS=(${FB//_/ })
    SID=${FBPARTS[1]}
    MODEL=${FBPARTS[2]}
    echo "$SID $MODEL"

    if [[ -f ${PROJDIR}/${SID}_${MODEL}.isrunning ]]; then continue; fi
    if [[ -f ${PROJDIR}/${SID}_${MODEL}.finished ]]; then continue; fi
    if [[ -f ${PROJDIR}/${SID}_${MODEL}.error ]]; then continue; fi

    touch ${PROJDIR}/${SID}_${MODEL}.isrunning
    touch ${PROJDIR}/${SID}_${MODEL}.log

    mkdir -p ${DCMDIR}/${SID}
    cp ${F} ${DCMDIR}/${SID}

    ${MATLAB} -nodisplay -nosplash -nodesktop -r "run('${BATCHDIR}/GLM_DCM_rest_p1_est.m'); exit;" s=${SID} m=${MODEL} >>${PROJDIR}/${SID}_${MODEL}.log

    if [[ -f ${RESULTSDIR}/${MODEL}/Ep_${FB} ]]; then
        touch ${PROJDIR}/${SID}_${MODEL}.finished
        rm ${PROJDIR}/${SID}_${MODEL}.isrunning
    else
        touch ${PROJDIR}/${SID}_${MODEL}.error
        rm ${PROJDIR}/${SID}_${MODEL}.isrunning
    fi

    sleep 10

done

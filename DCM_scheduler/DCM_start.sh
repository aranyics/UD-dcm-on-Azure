#!/bin/bash

PROJDIR=${HOME}/azure
DCMDIR=${PROJDIR}/analysis/DCM/largescale/conn_4sess
RESULTSDIR=${PROJDIR}/analysis/DCM/largescale/results/par
BATCHDIR=${HOME}/matlabsrc/DCM_scheduler/batch
MATLAB=/usr/local/bin/matlab

for F in `ls ${PROJDIR}/DCM*`;
do
    FB=`basename $F`
    FBPARTS=(${FB//_/ })
    SID=${FBPARTS[1]}
    SESS=${FBPARTS[2]}_${FBPARTS[3]}
    MODEL=${FBPARTS[4]}
    echo "$SID $MODEL $SESS"

    if [[ -f ${PROJDIR}/${SID}_${SESS}_${MODEL}.isrunning ]]; then continue; fi
    if [[ -f ${PROJDIR}/${SID}_${SESS}_${MODEL}.finished ]]; then continue; fi
    if [[ -f ${PROJDIR}/${SID}_${SESS}_${MODEL}.error ]]; then continue; fi

    touch ${PROJDIR}/${SID}_${SESS}_${MODEL}.isrunning
    touch ${PROJDIR}/${SID}_${SESS}_${MODEL}.log

    mkdir -p ${DCMDIR}/${SID}/${SESS}
    cp ${F} ${DCMDIR}/${SID}/${SESS}

    ${MATLAB} -nodisplay -nosplash -nodesktop -r "run('${BATCHDIR}/GLM_DCM_rest_p1_est.m'); exit;" s=${SID} r=${SESS} m=${MODEL} >>${PROJDIR}/${SID}_${SESS}_${MODEL}.log

    if [[ -f ${RESULTSDIR}/${MODEL}/Ep_${FB} ]]; then
        touch ${PROJDIR}/${SID}_${SESS}_${MODEL}.finished
        rm ${PROJDIR}/${SID}_${SESS}_${MODEL}.isrunning
    else
        touch ${PROJDIR}/${SID}_${SESS}_${MODEL}.error
        rm ${PROJDIR}/${SID}_${SESS}_${MODEL}.isrunning
    fi

    sleep 10

done

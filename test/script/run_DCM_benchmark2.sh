#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ARG1=${1:-small}

OUTDIR=${DIR}/../DCM/estimated/small

FILE1=${DIR}/../DCM/input/small/DCM_d001_MDMN-test_csd.mat
FILE2=${DIR}/../DCM/input/small/DCM_d033_MDMN-test_csd.mat
FILE3=${DIR}/../DCM/input/small/DCM_o039_MDMN-test_csd.mat

if [[ $ARG1 == 'medium' ]]; then
    OUTDIR=${DIR}/../DCM/estimated/medium

    FILE1=${DIR}/../DCM/input/medium/DCM_d001_M2NW-test_csd.mat
    FILE2=${DIR}/../DCM/input/medium/DCM_d033_M2NW-test_csd.mat
    FILE3=${DIR}/../DCM/input/medium/DCM_o039_M2NW-test_csd.mat
fi

if [[ $ARG1 == 'large' ]]; then
    OUTDIR=${DIR}/../DCM/estimated/large

    FILE1=${DIR}/../DCM/input/large/DCM_d001_Mfull-test_csd.mat
    FILE2=${DIR}/../DCM/input/large/DCM_d033_Mfull-test_csd.mat
    FILE3=${DIR}/../DCM/input/large/DCM_o039_Mfull-test_csd.mat
fi

if [[ $ARG1 == 'DCS' ]]; then
    OUTDIR=${DIR}/../DCM/estimated/DCS

    FILE1=${DIR}/../DCM/input/DCS/DCM_103212_MDCS_csd.mat
    FILE2=${DIR}/../DCM/input/DCS/DCM_103212_MDCS_csd.mat
    FILE3=${DIR}/../DCM/input/DCS/DCM_103212_MDCS_csd.mat
fi

OUTDIR=${DIR}/../DCM/estimated

echo matlab -nodisplay -nosplash -nodesktop -r "run('${DIR}/script_DCM_benchmark2.m'); exit;" dcmfile1=$FILE1 dcmfile2=$FILE2 dcmfile3=$FILE3 outdir=$OUTDIR
matlab -nodisplay -nosplash -nodesktop -r "run('${DIR}/script_DCM_benchmark2.m'); exit;" dcmfile1=$FILE1 dcmfile2=$FILE2 dcmfile3=$FILE3 outdir=$OUTDIR

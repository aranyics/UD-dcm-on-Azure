#!/bin/bash

IP=${1:-}

echo "deleting analysis directory"
ssh ${USER}@${IP} "rm -rf azure/analysis"

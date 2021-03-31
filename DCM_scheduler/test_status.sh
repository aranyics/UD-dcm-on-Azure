#!/bin/bash

IP=${1:-}

echo "all   finished  isrunning  error"
ssh ${USER}@${IP} "ls -l azure/*.mat | wc -l; ls -l azure/*.finished | wc -l; ls -l azure/*.isrunning | wc -l; ls -l azure/*.error | wc -l;"

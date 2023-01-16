echo $1
script='cd /home/matdcm/azure; if [ -f "'$2'" ]; then echo "'$2' exists."; fi'
sshpass -p "MatlabDCM12;" ssh matdcm@$1 "${script}"

echo $(date)
echo $1/$2 matdcm@$3:/home/matdcm/azure/$2
sshpass -p "MatlabDCM12;" scp $1/$2 matdcm@$3:/home/matdcm/azure/$2
#cp /mnt/raid6_data/hc/azure/analysis/DCM/largescale/conn/$1/$2 /mnt/raid6_data/user/dszabo/azure/test
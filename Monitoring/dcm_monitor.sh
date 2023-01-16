#filename=$1
#filename="ip_list.csv"
#echo $filename
script="cd azure; ls -l"
#n=1
#while read line
#do
#    vars=($line)
#    ip=${vars[0]}
#    echo $ip
#    sshpass -p "MatlabDCM12;" ssh matdcm@$ip "${script}" > ./out_$n.txt
#    n=$((n+1))
#done < $filename

echo $1
sshpass -p "MatlabDCM12;" ssh matdcm@$1 "${script}"
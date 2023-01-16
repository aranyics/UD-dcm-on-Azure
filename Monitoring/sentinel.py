import os
import glob
import csv
from pathlib import Path

def main():
    csvfile = "/mnt/raid6_data/user/dszabo/azure/subjlist.csv"
    remain_subjs = []
    path = "/mnt/raid6_data/hc/azure/analysis/DCM/largescale/conn"
    dirs = os.listdir(path)
    with open(csvfile) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            subj = row[0]
            ip = row[1]
            if subj in dirs:
                files = os.listdir(path+"/"+subj)
                res = [s for s in files if "DCM_" in s]
                if not res:
                    remain_subjs.append([subj,ip])
                    continue
                out = os.popen("/mnt/raid6_data/user/dszabo/azure/copy_to_azure.sh %s %s %s" % (subj, res[0], ip)).read()
                print(out)
            else:
                remain_subjs.append([subj,ip])

    outfile = open(csvfile, 'w')
    with outfile:
        writer = csv.writer(outfile, lineterminator='\n')
        writer.writerows(remain_subjs)
        #writer.writerow(data)


if __name__ == "__main__":
    import sys
    main()
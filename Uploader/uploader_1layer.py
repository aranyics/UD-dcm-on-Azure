import os
import glob
import csv
from pathlib import Path

def main(model):
    print(model)
    dbFile = "/mnt/raid6_data/user/dszabo/azure/scripts/uploader/uploader" + model + "db.csv"
    ipListFile = "/mnt/raid6_data/user/dszabo/azure/scripts/uploader/ip_list.csv"
    #path = "/mnt/raid6_data/hc/azure/analysis/DCM/largescale/conn"
    paths = ["/mnt/raid6_data/user/aranyics/ELTE/MTA_ATP/analysis/DCM/sm/largescale/conn", "/mnt/raid6_data/user/aranyics/ELTE/MTA_ATP/analysis/DCM/ph/largescale/conn"]

    db = {}
    with open(dbFile) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        for row in csv_reader:
            db[row[0]] = row[1]

    #print(db)
    ipList = []
    with open(ipListFile) as csv_file:
        csv_reader = csv.reader(csv_file)
        for row in csv_reader:
            ipList.append(row[0])

    #print(ipList)

    for path in paths:
        subjects = os.listdir(path)
        for subj in subjects:
            files = os.listdir(path+"/"+subj)
            res = [s for s in files if model in s]
            if not res or (subj in list(db.keys()) and db[subj] != "processed"): continue
            #print(str(n)+" "subj)
            #print(res[0])
            #print(subj)
            #melyik a legritkábban használt ip?
            ipDict = {}
            for ip in ipList:
                if "x" in ip:
                    ipDict[ip] = 9999
                    continue
                ipDict[ip] = 0
            for ip in list(db.values()):
                if ipDict[ip] == 9999: continue
                if ip == "processed": continue
                ipDict[ip] += 1
            sortedIpDict = dict(sorted(ipDict.items(), key=lambda item: item[1]))
            ip = list(sortedIpDict.keys())[0]
            print(ip)
            out = os.popen("/mnt/raid6_data/user/dszabo/azure/scripts/uploader/copy_to_azure.sh %s %s %s" % (path+"/"+subj, res[0], ip)).read()
            print(out)
            db[subj] = ip

            #TODO ha nem sikerül a feltöltés db[subj] = "processed"

            #print(db)
            outfile = open(dbFile, 'w')
            with outfile:
                for k, v in db.items():
                    writer = csv.writer(outfile, lineterminator='\n')
                    #writer.writerows(db)
                    writer.writerow([k, v])


if __name__ == "__main__":
    import sys
    main(sys.argv[1])
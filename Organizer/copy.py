import os
import glob
import csv
from pathlib import Path
from shutil import copyfile
from shutil import copytree
from os import path as pt

def main(path):
    saves = os.listdir(path)
    frompath = "/mnt/raid6_data/user/dszabo/azure/dcm_analysis_backup"
    saves = ["20210303"]
    dest_path = "/mnt/raid6_data/user/aranyics/ELTE/MTA_ATP"
    for save in saves:
        print(save)
        dcm_list = os.listdir(path+"/"+save)
        for dcm in dcm_list:
            print(dcm)
            conn = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/conn"
            dest_conn = dest_path+"/analysis/DCM/largescale/conn"
            subjs = os.listdir(conn)
            for subj in subjs:
                print(conn+"/"+subj+" "+dest_conn+"/"+subj)
                if os.path.isdir(conn+"/"+subj):
                    if pt.exists(dest_conn+"/"+subj) == True: continue
                    copytree(conn+"/"+subj,dest_conn+"/"+subj)

            resultscsvmdcs = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/csv/MDCS"
            resultscsvmfull = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/csv/MFULL"
            resultsparmdcs = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/par/MDCS"
            resultsparmfull = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/par/MFULL"
            resultscsvmmigfull = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/csv/MMIGFULL"
            resultsparmmigfull = frompath+"/"+save+"/"+dcm+"/"+"analysis/DCM/largescale/results/par/MMIGFULL"


            if pt.exists(resultscsvmdcs) == True:
                list = os.listdir(resultscsvmdcs)
                if len(list) > 0:
                    for file in list:
                        print(resultscsvmdcs+"/"+file+" "+"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MDCS/"+file)
                        if pt.exists("/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MDCS/"+file) == False:
                            copyfile(resultscsvmdcs+"/"+file,"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MDCS/"+file)

            if pt.exists(resultscsvmfull) == True:
                list = os.listdir(resultscsvmfull)
                if len(list) > 0:
                    for file in list:
                        print(resultscsvmfull+"/"+file+" "+"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MFULL/"+file)
                        if pt.exists("/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MFULL/"+file) == False:
                            copyfile(resultscsvmfull+"/"+file,"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/csv/MFULL/"+file)

            if pt.exists(resultsparmdcs) == True:
                list = os.listdir(resultsparmdcs)
                if len(list) > 0:
                    for file in list:
                        print(resultsparmdcs+"/"+file+" "+"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MDCS/"+file)
                        if pt.exists("/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MDCS/"+file) == False:
                            copyfile(resultsparmdcs+"/"+file,"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MDCS/"+file)

            if pt.exists(resultsparmfull) == True:
                list = os.listdir(resultsparmfull)
                if len(list) > 0:
                    for file in list:
                        print(resultsparmfull+"/"+file+" "+"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MFULL/"+file)
                        if pt.exists("/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MFULL/"+file) == False:
                            copyfile(resultsparmfull+"/"+file,"/mnt/raid6_data/hc/azure/analysis/DCM/largescale/results/par/MFULL/"+file)

            if pt.exists(resultscsvmmigfull) == True:
                list = os.listdir(resultscsvmmigfull)
                if len(list) > 0:
                    for file in list:
                        print(resultscsvmmigfull+"/"+file+" "+dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file)
                        if pt.exists(dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file) == False:
                            copyfile(resultscsvmmigfull+"/"+file,dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file)

            if pt.exists(resultsparmmigfull) == True:
                list = os.listdir(resultsparmmigfull)
                if len(list) > 0:
                    for file in list:
                        print(resultsparmmigfull+"/"+file+" "+dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file)
                        if pt.exists(dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file) == False:
                            copyfile(resultsparmmigfull+"/"+file,dest_path+"/analysis/DCM/largescale/results/par/MMIGFULL/"+file)

if __name__ == "__main__":
    import sys
    main(sys.argv[1])
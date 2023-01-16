import os
import csv
import subprocess
import datetime

def main():
    file = "./ip_list.csv"
    ipList = []
    with open(file) as csv_file:
        csv_reader = csv.reader(csv_file)
        for row in csv_reader:
            ipList.append(row[0])

    data = []
    for ip in ipList:
        #out = os.popen("/mnt/raid6_data/user/dszabo/azure/scripts/monitor.sh %s" % (file)).read()
        out = subprocess.Popen(["bash", "/mnt/raid6_data/user/dszabo/azure/scripts/dcm_monitor/dcm_monitor.sh",ip], stdout=subprocess.PIPE)
        stdout, stderr = out.communicate()

        out = str(stdout).split("\\n")
        status = {"mdcs_finished": 0, "mdcs_error": 0, "mdcs_isrunning": 0, "mdcs_mat": 0, "mfull_finished": 0, "mfull_error": 0, "mfull_isrunning": 0, "mfull_mat": 0, "mmigfull_finished": 0, "mmigfull_error": 0, "mmigfull_isrunning": 0, "mmigfull_mat": 0}
        for item in out:
            if "MDCS.finished" in item:
                status["mdcs_finished"] += 1
            elif "MDCS.error" in item:
                status["mdcs_error"] += 1
            elif "MDCS.isrunning" in item:
                status["mdcs_isrunning"] += 1
            elif "MDCS_csd.mat" in item:
                status["mdcs_mat"] += 1
            elif "MFULL.finished" in item:
                status["mfull_finished"] += 1
            elif "MFULL.error" in item:
                status["mfull_error"] += 1
            elif "MFULL.isrunning" in item:
                status["mfull_isrunning"] += 1
            elif "MFULL_csd.mat" in item:
                status["mfull_mat"] += 1
            elif "MMIGFULL.finished" in item:
                status["mmigfull_finished"] += 1
            elif "MMIGFULL.error" in item:
                status["mmigfull_error"] += 1
            elif "MMIGFULL.isrunning" in item:
                status["mmigfull_isrunning"] += 1
            elif "MMIGFULL_csd.mat" in item:
                status["mmigfull_mat"] += 1

        data.append([ip, datetime.datetime.now().strftime("%Y-%m-%d-%H:%M"), status["mdcs_finished"], status["mdcs_error"], status["mdcs_isrunning"], status["mdcs_mat"], status["mfull_finished"], status["mfull_error"], status["mfull_isrunning"], status["mfull_mat"], status["mmigfull_finished"], status["mmigfull_error"], status["mmigfull_isrunning"], status["mmigfull_mat"]])
        print(ip)
        '''print("finished " + str(status["finished"]))
        print("error " + str(status["error"]))
        print("isrunning " + str(status["isrunning"]))
        print("")'''

    all_data = [["MDCS finished: ", 0], ["MDCS error: ", 0], ["MDCS running: ", 0], ["MDCS uploaded: ", 0], ["MFULL finished: ", 0], ["MFULL error: ", 0], ["MFULL running: ", 0], ["MFULL uploaded: ", 0], ["MMIGFULL finished: ", 0], ["MMIGFULL error: ", 0], ["MMIGFULL running: ", 0], ["MMIGFULL uploaded: ", 0]]
    for list in data:
        all_data[0][1] += list[2]
        all_data[1][1] += list[3]
        all_data[2][1] += list[4]
        all_data[3][1] += list[5]
        all_data[4][1] += list[6]
        all_data[5][1] += list[7]
        all_data[6][1] += list[8]
        all_data[7][1] += list[9]
        all_data[8][1] += list[10]
        all_data[9][1] += list[11]
        all_data[10][1] += list[12]
        all_data[11][1] += list[13]

    myFile = open("./dcm_status.csv", 'a')
    with myFile:
        writer = csv.writer(myFile, lineterminator='\n')
        #writer.writerow(["ip", "date", "finished", "error", "isrunning", "mat"])
        writer.writerows(data)
        writer.writerows([[datetime.datetime.now().strftime("%Y-%m-%d %H:%M")]])
        writer.writerows(all_data)

if __name__ == "__main__":
    import sys
    main()
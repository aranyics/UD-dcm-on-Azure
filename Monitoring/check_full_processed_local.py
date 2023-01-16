import os

# A letöltött anyagokon (backup mappa) megnézi, melyik paciensből hány session készült el

def main(dir, model):
    backup = "/mnt/raid6_data/user/dszabo/azure/dcm_analysis_backup/20220222"
    vms = os.listdir(backup)
    pats = os.listdir(dir)
    pats.sort()
    n = 0
    for pat in pats:
        sessions = ["REST1_LR","REST1_RL","REST2_LR","REST2_RL"]
        pat_sessions = []
        for vm in vms:
            processed_pat = backup+"/"+vm+"/analysis/DCM/largescale/conn_4sess/" + pat
            if os.path.exists(processed_pat):
                for sess in sessions:
                    if os.path.exists(processed_pat+"/"+sess):
                        files = os.listdir(processed_pat+"/"+sess)
                        dcm_file = "DCM_"+pat+"_"+sess+"_"+model+"_csd.mat"
                        if dcm_file in files:
                            pat_sessions.append(sess)
        pat_sessions.sort()
        print(pat + " " + ",".join(pat_sessions))
    #print(str(n))



if __name__ == "__main__":
    import sys
    main(sys.argv[1], sys.argv[2])

import os
import glob
import csv
from pathlib import Path

def main():
    filename = "DCM_448347_MFULL_csd.mat"
    ip = "13.82.43.240"
    out = os.popen("/mnt/raid6_data/user/dszabo/azure/scripts/checkdcm.sh %s %s" % (ip, filename)).read()[:-1]
    print(out)





if __name__ == "__main__":
    import sys
    main()
import os
import glob
import csv
from pathlib import Path

def main(dir):
    n=0
    for path, currentDirectory, files in os.walk(dir):
        for file in files:
            if not file.startswith("DCM") and "MFULL_csd.mat" in file:
                n+=1
                #print(os.path.join(path, file))

    print(n)



if __name__ == "__main__":
    import sys
    main(sys.argv[1])

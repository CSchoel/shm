import pandas
import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt

if __name__ == "__main__":
    ref = pandas.read_csv("subprojects/shm-ref/SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample_res.csv")
    cur = pandas.read_csv("test-output/SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample_res.csv")
    plt.plot(ref["time"], ref["lung.resp.phase"])
    plt.plot(cur["time"], cur["lung.resp.phase"])
    plt.show()

import pandas
import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt

if __name__ == "__main__":
    reffile = "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample_res.csv"
    reffile = "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample_res.csv"
    reffile = "SHM.SchoelzelThesis.Examples.PacemakerExample_res.csv"
    # refvar = "lung.resp.phase"
    # refvar = "blood.vessel.pressure"
    # refvar = "para.signal.activation"
    # refvar = "heart.contraction.T"
    refvar = "x"
    #ref = pandas.read_csv("subprojects/shm-ref/{}".format(reffile))
    cur = pandas.read_csv("test-output/{}".format(reffile))
    #plt.plot(ref["time"], ref[refvar])
    plt.plot(cur["time"], cur[refvar], "--")
    plt.show()

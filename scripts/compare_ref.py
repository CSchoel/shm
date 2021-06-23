import pandas
import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt
import os

if __name__ == "__main__":
    resfile = "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample_res.csv"
    resfile = "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample_res.csv"
    resfile = "SHM.SchoelzelThesis.Examples.AVDelayExample_res.csv"
    reffile = "subprojects/shm-ref/{}".format(resfile)
    # refvar = "lung.resp.phase"
    # refvar = "blood.vessel.pressure"
    # refvar = "para.signal.activation"
    # refvar = "heart.contraction.T"
    # refvars = [refvar]
    refvars = ["countOut", "countOuts"]
    withref = os.path.exists(reffile)
    if withref:
        ref = pandas.read_csv(reffile)
    cur = pandas.read_csv("test-output/{}".format(resfile))
    for i, refvar in enumerate(refvars):
        if withref:
            plt.plot(ref["time"], ref[refvar], color="C%d" % i)
        plt.plot(cur["time"], cur[refvar], "--", color="C%d" % i)
    plt.show()

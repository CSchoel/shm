import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os

def plot_mc(time, modular, orig, outname=None):
  plt.figure(figsize=(10,4), dpi=100)
  plt.plot(time, modular, linewidth=2, alpha=0.5, label="modular")
  plt.plot(time, orig, linewidth=2, alpha=0.5, label="original")
  plt.xlabel("time [s]")
  plt.ylabel("RR interval length [s]")
  #plt.xticks(np.arange(0, 5) * 10)
  plt.minorticks_on()
  #plt.grid(alpha=0.5, which="both")
  plt.legend(loc="best")
  plt.xlim(0, 50)
  plt.tight_layout()
  if outname is None:
    plt.show()
  else:
    plt.savefig(outname)
  plt.close()

def plot_pvc(time_s, modular_s, time_nos, modular_nos, outname=None):
  f, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 4))
  ax1.plot(time_s, modular_s)
  ax1.set_ylabel("RR interval length [s]")
  ax1.set_xlabel("time[s]")
  ax1.set_xlim(0, 30)
  ax1.set_title("With sinus node")
  ax1.minorticks_on()
  #ax1.grid(alpha=0.5, which="both")
  for (x, y, s) in [(6, 0.95, "a)"), (11, 0.85, "b)"), (14.5, 0.85, "c)"), (20, 1.00, "d)")]:
    ax1.annotate(s, (x, y))
  ax2.plot(time_nos, modular_nos)
  ax2.set_ylabel("RR interval length [s]")
  ax2.set_xlabel("time[s]")
  ax2.set_xlim(0, 50)
  ax2.set_ylim(0.5, 2)
  ax2.set_title("Without sinus node")
  ax2.minorticks_on()
  #ax2.grid(alpha=0.5, which="both")
  for (x, y, s) in [(12, 1.9, "a)"), (23, 1.9, "b)"), (32, 1.9, "c)"), (42, 1.9, "d)")]:
    ax2.annotate(s, (x, y))
  f.tight_layout()
  if outname is None:
    plt.show(f)
  else:
    f.savefig(outname)
  plt.close(f)

if __name__ == "__main__":
  result_folder = "/home/cslz90/Documents/Promotion/results/modular-contraction/"
  orig_vs_modular = pd.read_csv(
    os.path.join(
      result_folder,
      "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample_res.csv"
    )
  )
  pvc_sinus = pd.read_csv(
    os.path.join(
      result_folder,
      "ExtraSystoleExample_pvc_upward_sinus.csv"
    )
  )
  pvc_nosinus = pd.read_csv(
    os.path.join(
      result_folder,
      "ExtraSystoleExample_pvc_upward_nosinus.csv"
    )
  )
  plot_mc(
    orig_vs_modular["time"],
    orig_vs_modular["c2.T_cont"],
    orig_vs_modular["mc.T"],
    outname=os.path.join(result_folder, "plot_mc.pdf")
  )
  plot_pvc(
    pvc_sinus["time"],
    pvc_sinus["T"],
    pvc_nosinus["time"],
    pvc_nosinus["T"],
    outname=os.path.join(result_folder, "plot_pvc.pdf")
  )
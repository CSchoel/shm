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

def plot_pvc(time_s, modular_s, pvc_s, time_nos, modular_nos, pvc_nos, outname=None):
  x_pvc_s = time_s.values[pvc_s]
  x_pvc_nos = time_nos.values[pvc_nos]
  pvc_labels = ["a)", "b)", "c)", "d)"]
  f, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(10, 4))
  for x in x_pvc_s:
    ax1.axvline(x, label="PVC", color="black", linestyle="--", alpha=0.5)
  ax1.plot(time_s, modular_s)
  ax1.set_ylabel("RR interval length [s]")
  ax1.set_xlabel("time[s]")
  ax1.set_xlim(0, 30)
  ax1.set_title("With SA node")
  ax1.minorticks_on()
  #ax1.grid(alpha=0.5, which="both")
  for (x, s) in zip(x_pvc_s, pvc_labels):
    ax1.annotate(s, xy=(x, 1), xytext=(4, 0), textcoords="offset points")
  for x in x_pvc_nos:
    ax2.axvline(x, label="PVC", color="black", linestyle="--", alpha=0.5)
  ax2.plot(time_nos, modular_nos)
  ax2.set_ylabel("RR interval length [s]")
  ax2.set_xlabel("time[s]")
  ax2.set_xlim(0, 55)
  ax2.set_ylim(0.5, 2)
  ax2.set_title("Without SA node")
  ax2.minorticks_on()
  #ax2.grid(alpha=0.5, which="both")
  for (x, s) in zip(x_pvc_nos, pvc_labels):
    ax2.annotate(s, xy=(x, 1.93), xytext=(4, 0), textcoords="offset points")
  plot_scenarios(ax3)
  f.tight_layout()
  if outname is None:
    plt.show(f)
  else:
    f.savefig(outname)
  plt.close(f)

def plot_scenarios(ax=None):
  if ax is None:
    f = plt.figure(figsize=(5, 4))
    ax = f.axes
  h_signal = 1
  dist = 0.2
  t_delay = 0.09
  t_refrac_avn = 0.34
  t_refrac_vent = 0.2
  ax.vlines(x=[0.8, 1.6], ymin=0, ymax=h_signal, label="SA/AV signal")
  kwargs = dict(marker="|", solid_capstyle="butt")
  ax.plot([0.8, 0.8 + t_delay], [h_signal + dist*1, h_signal + dist*1], label="AV node delay", **kwargs)
  l = ax.plot([0.8, 0.8 + t_refrac_avn], [h_signal + dist*2, h_signal + dist*2], label="AV refractory period", **kwargs)
  c = l[0].get_color()
  ax.plot([1.2, 1.2 + t_refrac_avn], [h_signal + dist*1, h_signal + dist*1], "--", color=c, **kwargs) # , label="AV ref. per. (after PVC)"
  ax.plot([1.6 - t_delay/2, 1.6 - t_delay/2 + t_refrac_avn], [h_signal + dist*2, h_signal + dist*2], "--", color=c, **kwargs)
  ax.plot([0.8 + t_delay, 0.8 + t_delay + t_refrac_vent], [h_signal + dist*3, h_signal + dist*3], label="ventr. refractory period", **kwargs)
  ax.set_xlim(0.7, 2)
  ax.set_ylim(0, h_signal + dist*10)
  ax.set_yticks([])
  ax.set_xticks([0.8 + t_delay/2, 0.8 + t_refrac_avn/2, 1.2, 1.6 - t_delay/2])
  ax.set_xticklabels(["a)", "b)", "c)", "d)"])
  ax.set_xlabel("time")
  ax.legend(loc="best")
  ax.set_title("PVC locations in SA/AV cycle")

def find_pvcs(trigger):
  return np.where(np.array(trigger[:-1]) < np.array(trigger[1:]))


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
    find_pvcs(pvc_sinus["trigger"]),
    pvc_nosinus["time"],
    pvc_nosinus["T"],
    find_pvcs(pvc_nosinus["trigger"]),
    outname=os.path.join(result_folder, "plot_pvc.pdf")
  )
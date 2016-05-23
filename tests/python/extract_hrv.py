import numpy as np
import re
import glob
import os
import matplotlib.pyplot as plt

beat_chars = set(['N','L','R','B','A','a','J','S','V','r','F','e','j','n','E','/','f','Q','?'])

def ra(fname):
	data = np.loadtxt(fname, dtype=str, usecols=(0,2))
	types = data[:,1]
	times = data[:,0]
	other = set(types) - beat_chars
	if len(other) > 0:
		print("ignored the following annotation types in %s: %s" % (fname, other))
	data = [times[i] for i in range(len(times)) if types[i] in beat_chars]
	data = [parse_time(x) for x in data]
	return data

time_re = re.compile(r"(?:(\d+):)?(\d+):(\d+).(\d+)")

def parse_time(s):
	h,m,s,ms = time_re.match(s).groups()
	h = 0 if h is None else int(h)
	t = h * 60 + int(m)    # t[min]
	t = t * 60 + int(s)    # t[s]
	t = t * 1000 + int(ms) # t[ms]
	return t


def load_fantasia(dname):
	young = [ra(x) for x in glob.glob(os.path.join(dname, "*y*_ann.txt"))]
	old = [ra(x) for x in glob.glob(os.path.join(dname, "*o*_ann.txt"))]
	return {"healthy_young": young, "healthy_old": old }


if __name__ == '__main__':
	fantasia = "D:/Daten/physionet/fantasia" 
	val = load_fantasia(fantasia)
	ds = val["healthy_young"][0]
	plt.plot(np.array(ds[1:])-np.array(ds[:-1]))
	plt.show()
	#print(val)

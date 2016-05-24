import numpy as np
import re
import glob
import os
import matplotlib.pyplot as plt

beat_chars = set(['N','L','R','B','A','a','J','S','V','r','F','e','j','n','E','/','f','Q','?'])

def ra(fname):
	#data = np.loadtxt(fname, dtype=bytes, usecols=(0,2))
	line_re = r"\[?([\d:\.]+(?: \d)?)\]?\s+\d+\s+(.)\s+.+"
	data = np.fromregex(fname, line_re, [('time', 'S14'), ('type', 'S1')])
	types = np.char.decode(data['type'], "utf-8")
	times = np.char.decode(data['time'], "utf-8")
	other = set([str(x) for x in set(types)]) - beat_chars
	if len(other) > 0:
		print("ignored the following annotation types in %s: %s" % (fname, other))
	data = [times[i] for i in range(len(times)) if types[i] in beat_chars]
	data = np.array([parse_time(x) for x in data])
	return data

time_re = re.compile(r"\[?(?:(\d+):)?(\d+):(\d+).(\d+)\]?")

def parse_time(s):
	mtch = time_re.match(s)
	if mtch is None:
		print("malformatted time: %s" % s)
	h,m,s,ms = mtch.groups()
	h = 0 if h is None else int(h)
	t = h * 60 + int(m)    # t[min]
	t = t * 60 + int(s)    # t[s]
	t = t * 1000 + int(ms) # t[ms]
	return t


def load_fantasia(dname):
	name = lambda x : "ft_"+os.path.basename(x)[:-8]
	young = [(name(x),ra(x)) for x in glob.glob(os.path.join(dname, "*y*_ann.txt"))]
	old = [(name(x),ra(x)) for x in glob.glob(os.path.join(dname, "*o*_ann.txt"))]
	return {"healthy_young": young, "healthy_old": old }

def load_ptbdb(dname):
	reason_prefix = "# Reason for admission:"
	data = {}
	for h in glob.glob(os.path.join(dname, "patient*/*.hea")):
		name = "ptb_" + os.path.basename(os.path.dirname(h)) + "_" + os.path.basename(h)[:-4]
		cls = None
		with open(h, "r", encoding="utf-8") as hf:
			lines = hf.readlines()
		for l in lines:
			if l.startswith(reason_prefix):
				cls = l[len(reason_prefix):].strip().lower()
		if cls is None:
			print("could not find class for record %s" % h)
		else:
			if cls.startswith("healthy"):
				# use string "healthy" instead of "Healthy control"
				cls = "healthy"
			data[cls] = data.get(cls,[])
			data[cls].append((name,ra(h[:-4]+"_ann.txt")))
	return data

def load_nsr(dname, prefix="nsr"):
	name = lambda x: prefix + "_" + os.path.basename(x)[:-8]
	data = [(name(x), ra(x)) for x in glob.glob(os.path.join(dname, "*_ann.txt"))]
	return {"healthy" : data}

def load_prcp(dname):
	name = lambda x: "prcp_" + os.path.basename(x)[:-13]
	data = [(name(x), ra(x)) for x in glob.glob(os.path.join(dname, "*_ann_wqrs.txt"))]
	return {"healthy_moving" : data}	

if __name__ == '__main__':
	fantasia = "D:/Daten/physionet/fantasia" 
	val = load_fantasia(fantasia)
	ds = val["healthy_young"][0]
	plt.plot(np.array(ds[1:])-np.array(ds[:-1]))
	plt.show()
	#print(val)

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

def update_lst(dct, dct2):
	all_keys = set(list(dct.keys()) + list(dct2.keys()))
	ndict = dict([(k, dct.get(k, []) + dct2.get(k, [])) for k in all_keys])
	return ndict

def load_all():
	fantasia = "D:/Daten/physionet/fantasia"
	ptb = "D:/Daten/physionet/ptbdb"
	nsr = "D:/Daten/physionet/nsrdb"
	nsr2 = "D:/Daten/physionet/nsr2db"
	prcp = "D:/Daten/physionet/prcp"

	val = load_fantasia(fantasia)
	val = update_lst(val, load_ptbdb(ptb))
	val = update_lst(val, load_nsr(nsr))
	val = update_lst(val, load_nsr(nsr2, "nsr2"))
	val = update_lst(val, load_prcp(prcp))
	return val

def make_safe(s):
	return s.replace("/","-")

def create_db(dstdir):
	if not os.path.exists(dstdir):
		os.mkdir(dstdir)
	data = load_all()
	for k in data:
		kf = os.path.join(dstdir,make_safe(k)+".npz")
		dct = dict(data[k])
		print("creating %s with %d records..." % (kf,len(data[k])))
		np.savez(kf, **dct)


def inspect(db):
	for k in val:
		print("%s: %d" % (k, len(val[k])))
		print([x[0] for x in val[k]])

if __name__ == '__main__':
	create_db("D:/Daten/hrvdb")

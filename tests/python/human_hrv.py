import numpy as np
import matplotlib.pyplot as plt
import os
import itertools as it
import glob

def load_db(dbdir, names=None, combine=False):
	data = {}
	for f in glob.glob(os.path.join(dbdir,"*.npz")):
		k = os.path.basename(f)[:-4]
		if names is None or k in names:
			data[k] = np.load(os.path.join(dbdir, f))
	if combine:
		d2 = {}
		for v in data.values():
			d2.update(v)
		data = d2
	return data

def to_rr(data):
	return data[1:] - data[:-1]

def poincare(rr):
	pc = np.zeros((len(rr)-1,2))
	pc[:,0] = rr[:-1]
	pc[:,1] = rr[1:]
	return pc

def plot_poincare(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	lim = (0, 2000)
	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	ax.plot(pc[:,0], pc[:,1], "ro", alpha=0.1)
	ax.set_xlim(lim)
	ax.set_ylim(lim)
	fig.savefig(fname+".png")
	plt.close(fig)

def is_flat(data):
	return isinstance(next(iter(data.values())), np.ndarray)

def make_plots(db, dname):
	if is_flat(db):
		db = {'' : db}
	for k in db:
		kdir = os.path.join(dname, k)
		if not os.path.exists(kdir):
			os.mkdir(kdir)
		for n,ar in db[k].items():
			#print(n.encode("utf-8"))
			print("plotting %s" % os.path.join(kdir,n))
			if(len(ar) < 2):
				print("ERROR: too few datapoints!")
			else:
				plot_poincare(os.path.join(kdir,n), ar)

if __name__ == "__main__":
	dbdir = "D:/Daten/hrvdb"
	db = load_db(dbdir, names=None, combine=False)
	make_plots(db, dbdir)
	print(db.keys())
	print(is_flat(db))
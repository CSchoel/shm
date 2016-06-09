import numpy as np
import matplotlib.pyplot as plt
import os
import itertools as it
import glob
from scipy.stats import norm
from scipy.stats.mstats import mquantiles
import scipy.signal as sig

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

def plot_qq(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	# project onto sd1 diagonal
	ax1 = np.array([-1,1])
	sd1 = np.dot(pc,ax1) / np.linalg.norm(ax1)
	sd1 = (sd1 - np.mean(sd1)) / np.std(sd1)
	lim = (-4,4)
	nbins = 50
	xvals = np.arange(nbins,dtype="float32")/nbins
	q_data = mquantiles(sd1, xvals)
	q_gauss = [norm.ppf(x) for x in xvals]
	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	#xvals = bins[:-1] 
	#bin_width = bins[1]-bins[0]
	#ax.bar(xvals, np.log(h), bin_width, label="actual")
	ax.plot(q_data,q_gauss,"bo")
	ax.set_xlim(lim)
	ax.set_ylim(lim)
	fig.savefig(fname+"_qq.png")
	plt.close(fig)

def plot_cdf(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	# project onto sd1 diagonal
	ax1 = np.array([-1,1])
	sd1 = np.dot(pc,ax1) / np.linalg.norm(ax1)
	sd1 = (sd1 - np.mean(sd1)) / np.std(sd1)
	lim = (-4,4)
	nbins = 50
	h,bins = np.histogram(sd1, nbins, lim)
	xvals = bins[1:]
	cdf_data = np.cumsum(h) / np.sum(h)
	cdf_gauss = norm.cdf(xvals)
	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	ax.plot(xvals,cdf_data,"b-")
	ax.plot(xvals,cdf_gauss,"r-")
	ax.set_xlim(lim)
	fig.savefig(fname+"_cdf.png")
	plt.close(fig)		

def plot_hist(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	# project onto sd1 diagonal
	ax1 = np.array([-1,1])
	sd1 = np.dot(pc,ax1) / np.linalg.norm(ax1)
	lim = (-1000, 1000)
	h,bins = np.histogram(sd1, 50, lim)
	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	xvals = bins[:-1] 
	bin_width = bins[1]-bins[0]
	g0 = np.where(h > 0)
	h = h.astype("float32")
	h[g0] = np.log(h[g0])
	h /= np.sum(h)
	ax.bar(xvals, h, bin_width, label="actual")
	fig.savefig(fname+"_hist.png")
	plt.close(fig)

def plot_hist_smooth(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	# project onto sd1 diagonal
	ax1 = np.array([-1,1])
	sd1 = np.dot(pc,ax1) / np.linalg.norm(ax1)
	lim = (-1000, 1000)
	nbins = 50
	h,bins = np.histogram(sd1, nbins, lim)
	xvals = bins[:-1] 
	bin_width = bins[1]-bins[0]
	g0 = np.where(h > 0)
	h = h.astype("float32")
	h[g0] = np.log(h[g0])
	h /= np.sum(h)
	gauss = sig.gaussian(20,1)
	gauss /= np.sum(gauss)
	hsmooth = np.convolve(h, gauss)
	

	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	ax.bar(xvals, h, bin_width, label="actual")
	ax.plot(xvals,hsmooth[len(gauss)//2:], "r-")
	fig.savefig(fname+"_hist.png")
	plt.show()
	exit()
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
				name = os.path.join(kdir,n)
				plot_poincare(name, ar)
				plot_hist_smooth(name, ar)
				plot_qq(name, ar)
				plot_cdf(name, ar)

if __name__ == "__main__":
	dbdir = "D:/Daten/hrvdb"
	db = load_db(dbdir, names=None, combine=False)
	make_plots(db, dbdir)
	print(db.keys())
	print(is_flat(db))
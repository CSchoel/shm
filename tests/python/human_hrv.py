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

def poincare_d(pc, binsize=5, max_rr=2000):
	nbins = int(np.ceil(max_rr / binsize))
	# capping rr values at max_rr
	pc = np.minimum(pc, max_rr-1)
	# transform from rr to bin coordinates
	pc = np.floor(pc / binsize).astype("int32")
	# sort poincare points as tuples
	pc = pc[np.argsort(pc[:,0] * max_rr*2 + pc[:,1])]
	# calculate absolute difference between neighboring points in sorted array
	diff = np.sum(np.abs(np.diff(pc,n=1,axis=0)),axis=1)
	# add a difference of 1 for the first element
	diff = np.concatenate(([1], diff))
	# find indices where difference is not zero
	idx = np.where(diff > 0)[0]
	# add artificial index len(pc) so that last element is not lost
	idx = np.concatenate((idx, [len(pc)]))
	# calculate how often the points pc[idx] occurred (difference of indices)
	counts = np.diff(idx)
	points = pc[idx[:-1]]
	# transform point coordintates and counts to density plot
	density = np.zeros((nbins, nbins))
	density[(nbins - points[:,1], points[:,0])] = counts
	return density

def keep(data):
	min_ex_height = 0.01
	sd1_cutoff = 70 # mean 42 +- 7 (Guzik2007)
	rr = to_rr(data)
	pc = poincare(rr)
	ppc = np.dot(pc,[-1,1])/np.sqrt(2) # projected poincare to axis (-1,1)
	sd1 = np.std(ppc)
	_,hs,_,extrema = extreme_hist(data)
	# only keep extrema that are higher than min_ex_height
	ex = [x for x in np.clip(extrema,0,len(hs)-1) if hs[x] > min_ex_height]
	return len(ex) == 1 and sd1 < sd1_cutoff

def extreme_hist(data):
	lim = (-1000, 1000)
	nbins = 50
	
	rr = to_rr(data)
	pc = poincare(rr)
	# project onto sd1 diagonal
	ax1 = np.array([-1,1])
	ppc = np.dot(pc,ax1) / np.linalg.norm(ax1) # projected poincare
	# calculate historgram
	h,bins = np.histogram(ppc, nbins, lim)
	xvals = bins[:-1] 
	bin_width = bins[1]-bins[0]
	# take log where h > 0
	g0 = np.where(h > 0)
	h = h.astype("float32")
	h[g0] = np.log(h[g0])
	s = np.sum(h)
	if s > 0:
		h /= s
	# smoothe histogram with gaussian
	gauss = sig.gaussian(23,0.8)
	gauss /= np.sum(gauss)
	hsmooth = np.convolve(h, gauss)
	
	# finnd extrema
	left = (hsmooth[1:-1] - hsmooth[2:]) > 0
	right = (hsmooth[1:-1] - hsmooth[:-2]) > 0
	extrema = np.where(np.logical_and(left,right))[0]

	# return only relevant part of histogram
	off_s = np.floor(len(gauss)/2.0) - 1
	off_e = len(gauss) - off_s - 1

	hsmooth = hsmooth[off_s:-off_e]
	extrema += 1 - off_s
	
	return h, hsmooth,bins[:-1],extrema

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

def plot_poincare_d(fname, data):
	rr = to_rr(data)
	pc = poincare(rr)
	binsize = 50
	max_rr = 2000
	density = poincare_d(pc, binsize=binsize, max_rr=max_rr)
	d2 = density.copy()
	d2[d2 > 0] = np.log(d2[d2 > 0])
	
	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	ax.imshow(d2)
	labels = np.array(range(0,max_rr,500))
	ticks = labels / binsize
	ax.set_xticks(ticks)
	ax.set_xticklabels(labels)
	ax.set_yticks(ticks)
	ax.set_yticklabels(max_rr - labels)
	fig.savefig(fname+"_0d.png")
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
	h, hsmooth, xvals, extrema = extreme_hist(data)
	bin_width = xvals[1] - xvals[0]

	fig = plt.figure(figsize=(8,8))
	ax = fig.add_subplot(111)
	ax.bar(xvals, h, bin_width, label="actual")
	for e in extrema:
		ax.axvline(xvals[np.clip(e,0,len(xvals)-1)], color="#00FFFF")
	ax.plot(xvals,hsmooth, "r-")
	ax.set_ylim(0,0.5)
	fig.savefig(fname+"_hist.png")
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
				plot_poincare_d(name, ar)
				plot_hist_smooth(name, ar)
				plot_qq(name, ar)
				plot_cdf(name, ar)

def filter_db(db, dname, outname):
	if not os.path.exists(dname):
		os.mkdir(dname)
	if is_flat(db):
		db = {'' : db}
	seldir = os.path.join(dname,"selected")
	exdir = os.path.join(dname,"excluded")
	if not os.path.exists(seldir):
		os.mkdir(seldir)
	if not os.path.exists(exdir):
		os.mkdir(exdir)
	selected = []
	excluded = []
	for k in db:
		for n,ar in db[k].items():
			if keep(ar):
				selected.append((n,ar))
			else:
				excluded.append((n,ar))
	np.savez(os.path.join(dname,outname+"_selected.npz"),**dict(selected))
	np.savez(os.path.join(dname,outname+"_excluded.npz"),**dict(excluded))
	with open(os.path.join(dname,"selected.txt"),"w",encoding="utf-8") as f:
		f.write("\n".join([x[0] for x in selected]))
	with open(os.path.join(dname,"excluded.txt"),"w",encoding="utf-8") as f:
		f.write("\n".join([x[0] for x in excluded]))
	print("excluded: %d/%d samples" % (len(excluded),len(selected)+len(excluded)))
	print([x[0] for x in excluded])
	for data,outdir in [[selected, seldir], [excluded, exdir]]:
		for n,ar in data:
			name = os.path.join(outdir,n)
			print("plotting %s..." % name)
			plot_poincare(name, ar)
			plot_poincare_d(name, ar)
			plot_hist_smooth(name, ar)
			plot_qq(name, ar)
			plot_cdf(name, ar)

if __name__ == "__main__":
	dbdir = "D:/Daten/hrvdb"
	db = load_db(dbdir, names=None, combine=False)
	make_plots(db, os.path.join(dbdir,"plots"))
	#db = load_db(dbdir, names=["healthy", "healthy_moving", "healthy_young", "healthy_old"], combine=True)
	#filter_db(db, os.path.join(dbdir, "filter"), "filtered")
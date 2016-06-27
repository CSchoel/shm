import numpy as np
import matplotlib.pyplot as plt
import sys
import os
import io
import itertools as it
import glob
import scipy.stats as sst
import scipy.stats.mstats as msst
import scipy.signal as sig
import multiprocessing as mp

import hrv_nonlinear as hnl

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
	q_data = sst.mquantiles(sd1, xvals)
	q_gauss = [msst.norm.ppf(x) for x in xvals]
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
	with io.open(os.path.join(dname,"selected.txt"),"w",encoding="utf-8") as f:
		f.write("\n".join([x[0] for x in selected]))
	with io.open(os.path.join(dname,"excluded.txt"),"w",encoding="utf-8") as f:
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

def plot_measure_hists(data, dnames, alnames, plotdir, extra=None):
	nbins = 50
	nsigma = 3
	ymax = 0.2
	usebest = None
	#pdf_names = ["norm", "gamma", "beta", "genlogistic", "weibull_min", "weibull_max"]
	pdf_names = ["norm", "gamma", "weibull_min"]
	n = len(alnames)
	total_data = np.concatenate(data)
	total_std = np.std(total_data, axis=0)
	total_mean = np.mean(total_data, axis=0)
	for i in range(n):
		rng = (total_mean[i] - nsigma * total_std[i], total_mean[i] + nsigma * total_std[i])
		for j in range(len(data)):
			fname = os.path.join(plotdir,"{0:s}_hist_{1:s}.png".format(alnames[i], dnames[j]))
			d = data[j][:,i]
			h, bins = np.histogram(d, nbins, rng)
			normfac = np.sum(h)
			h = h.astype("float32") / normfac
			vlines = [("mean", np.mean(d)), ("median",np.median(d))]
			if not extra is None:
				vlines.append((extra[0], extra[1][i]))
			pdfs = []
			pdfs.append(("norm", sst.norm.pdf(bins[:-1],*sst.norm.fit(d))))
			pdfs.append(("gamma", sst.gamma.pdf(bins[:-1],*sst.gamma.fit(d))))
			pdfs.append(("beta", sst.beta.pdf(bins[:-1],*sst.beta.fit(d))))
			pdfs.append(("genlogistic", sst.genlogistic.pdf(bins[:-1],*sst.genlogistic.fit(d))))
			pdfs.append(("weibull_min", sst.weibull_min.pdf(bins[:-1],*sst.weibull_min.fit(d))))
			pdfs.append(("weibull_max", sst.weibull_max.pdf(bins[:-1],*sst.weibull_max.fit(d))))
			#powerfit = sst.powernorm.fit(d)
			#pdfs.append(("powernorm (p={:.3f})".format(powerfit[0]), sst.powernorm.pdf(bins[:-1],*powerfit)))
			pdfs = [(nm, dat / np.sum(dat)) for nm,dat in pdfs if nm in pdf_names]
			if not usebest is None:
				# compare pdfs to actual histogram and retain only normal and best n (for visibility)		
				pdf_diffs = [np.sum((h - dat)**2) for _, dat in pdfs]
				best_idx = np.argsort(pdf_diffs)[:usebest]
				best = [pdfs[idx] for idx in best_idx]
				if not 0 in best_idx:
					best.insert(0, pdfs[0])
				pdfs = best
			plot_hist_with_pdf(h, bins, ymax, fname, vlines=vlines, pdfs=pdfs)

def plot_hist_with_pdf(h, bins, ymax, fname, vlines=[], pdfs=[]):
	print("plotting {}...".format(fname))
	bin_width = bins[1]-bins[0]
	plt.bar(bins[:-1], h, bin_width, color="0.8")
	colors = ["red", "blue", "black", "#FF9900", "#0099FF"]
	for vi in range(len(vlines)):
		v_name, v_value = vlines[vi]
		col = colors[vi % len(colors)]
		plt.axvline(v_value,label=v_name, linestyle="--", color=col)
	for name,pdf in pdfs:
		plt.plot(bins[:-1], pdf,label=name)
	plt.ylim(0, ymax)
	plt.xlim(bins[0],bins[-1]+bin_width)
	plt.legend(loc="best")
	plt.savefig(fname)
	plt.close()

def _compare_measures_sample(args):
	name, rr, dnames, nbeats = args
	alnames = dnames.keys()
	log_data = []
	log_names = []
	max_chunks = 10
	sys.stdout.flush()
	nchunks = max(1,len(rr) // nbeats)
	for s in range(nchunks):
		if not max_chunks is None and s > max_chunks:
			break
		fnt = "{}_{{}}_{}-{}".format(name, s*nbeats, (s+1)*nbeats)
		fnf = lambda s: (None if dnames[s] is None else os.path.join(dnames[s],fnt.format(s)))
		rr_slice = rr[s*nbeats:(s+1)*nbeats]
		lambda_e = np.max(hnl.lyap_e(rr_slice, emb_dim=10, matrix_dim=4, debug_plot=True, plot_file=fnf("lyap_e")))
		lambda_r = hnl.lyap_r(rr_slice, debug_plot=True, plot_file=fnf("lyap_r"))
		sen = hnl.sampen(rr_slice, debug_plot=True, plot_file=fnf("sampEn"))
		h = hnl.hurst_rs(rr_slice, debug_plot=True, plot_file=fnf("hurst"))
		cd = hnl.corr_dim(rr_slice, 2, debug_plot=True, plot_file=fnf("corrDim"))
		dfa = hnl.dfa(rr_slice, debug_plot=True, plot_file=fnf("dfa"))
		log_data.append([lambda_e, lambda_r, sen, h, cd, dfa])
		log_names.append("{}_{}-{}".format(name,s*nbeats, (s+1)*nbeats))
		print("{}: {}/{}".format(name, s+1, nchunks))
		sys.stdout.flush()
	return name, log_names, log_data

def compare_measures(dbs, names, outdir=None, nprocs=1):
	nparams = 6
	nbeats = 200
	template = "{:s};" + ";".join(["{:.3f}"] * nparams) + "\n"
	res = {}
	all_data = []
	alnames = ["lyap_e", "lyap_r", "sampEn", "hurst", "corrDim", "dfa"]
	for dbn, db in zip(names, dbs):
		measurefile = os.path.join(outdir,dbn + "_nonlinear.txt")
		with io.open(measurefile, "w", encoding="utf-8") as f:
			f.write(u"name;lyap_e;lyap_r;sampen;hurst;corr_dim;dfa\n")
		sample_names = sorted(db.keys())
		log_data = []
		log_names = []
		if not (outdir is None):
			plotdir = os.path.join(outdir,"plots")
			dnames = {}
			for algo in alnames:
				algodir = os.path.join(os.path.join(plotdir, algo),dbn)
				try:
					os.makedirs(algodir)
				except:
					pass
				dnames[algo] = algodir
		else:
			dnames = {a : None for a in alnames}
		
		rr_data = [(n, to_rr(db[n]), dnames, nbeats) for n in sample_names]
		if nprocs > 1:
			imp = mp.Pool(nprocs).imap_unordered(_compare_measures_sample, rr_data)
		else:
			# note: assumes python 3 map (else we should use it.imap)
			imp = map(_compare_measures_sample, rr_data)
		i = 0
		for name, ln, ld in imp:
			print("processed sample {:d}/{:d}".format(i+1, len(sample_names)))
			print("name: {:s}, chunks: {:d}".format(name,len(ln)))
			log_data.extend(ld)
			log_names.extend(ln)
			i += 1
		log_data = np.array(log_data, dtype="float32")
		all_data.append(log_data)
		res[dbn] = dict(zip(sample_names, log_data))
		if not (outdir is None):
			with io.open(measurefile, "a", encoding="utf-8") as f:
				f.writelines([template.format(*([n]+list(x))) for n, x in zip(log_names,log_data)])
				f.write(template.format(*(["mean"]+list(np.mean(log_data, axis=0)))))
				f.write("\n")
	if not outdir is None:
		plot_measure_hists(all_data, names, alnames, os.path.join(outdir, "plots"))
	return res

test_names = {
	"lyap_e" : "lyapunov exponent (Eckmann)",
	"lyap_r" : "lyapunov exponent (Rosenstein)",
	"corrDim" : "correlation dimension",
	"hurst" : "hurst exponent",
	"dfa" : "hurst parameter (DFA)",
	"sampEn" : "sample entropy"
}

def load_test_data(fname):
	with io.open(fname, "r", encoding="utf-8") as f:
		data = [x.split(";") for x in f.readlines()]
		data = [(x, float(y)) for x, y in data]
	return dict(data)

def test_extras(fname, alnames):
	d = load_test_data(fname)
	return ("SHM test", [d[test_names[an]] for an in alnames])

def replot_compare_hists():
	dn = "D:/Daten/hrvdb/filter"
	test_file = "../../../test-output/measures.csv"
	cols = range(1,7)
	names = ["selected_nonlinear.txt", "excluded_nonlinear.txt"]
	data = [np.loadtxt(os.path.join(dn,fn), delimiter=";", skiprows=1, usecols=cols) for fn in names]
	alnames = ["lyap_e", "lyap_r", "sampEn", "hurst", "corrDim", "dfa"]
	ex = test_extras(test_file, alnames)
	plot_measure_hists(data, ["selected", "excluded"], alnames, os.path.join(dn, "plots"), extra=ex)

if __name__ == "__main__":
	dbdir = "D:/Daten/hrvdb"
	test_file = "../../../test-output/measures.csv"
	#db = load_db(dbdir, names=None, combine=False)
	#make_plots(db, os.path.join(dbdir,"plots"))
	
	#db = load_db(dbdir, names=["healthy", "healthy_moving", "healthy_young", "healthy_old"], combine=True)
	#filter_db(db, os.path.join(dbdir, "filter"), "filtered")

	print("loading selected...")
	db_s = load_db(os.path.join(dbdir,"filter"), names=["filtered_selected"], combine=True)
	print("loading excluded...")
	db_e = load_db(os.path.join(dbdir,"filter"), names=["filtered_excluded"], combine=True)
	db_s = dict(list(db_s.items())[:2])
	db_e = dict(list(db_e.items())[:2])
	print("comparing measures...")
	compare_measures([db_s, db_e], ["selected", "excluded"], outdir=os.path.join(dbdir, "filter"), nprocs=2)
	
	#replot_compare_hists()

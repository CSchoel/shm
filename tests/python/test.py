#!python2.7
#^ shebang used by pylauncher to identify python version to use (python2.7 64 bit)

from __future__ import print_function # use python3-style printing
from builtins import range            # use python3 implementation of range

import hrv_nonlinear as hnl
import ompython_helper as omh

import unittest
import os
import shutil
import numpy as np
import matplotlib.pyplot as plt
import scipy.interpolate as it
import re

def rmse(x,y):
	return np.sqrt(((x-y)**2).mean())

def resample_nearest(x,y,n):
	nx = np.arange(n,dtype=float) / n * x[-1]
	ny = it.interp1d(x,y,"nearest")(nx)
	return np.dstack((nx, ny)).reshape((n,2))

class TestSHMModel(unittest.TestCase):
	session = None
	loaded = None
	outdir = None
	simtime = 200
	simres = None
	data_pressure = None
	data_hrv = None
	data_hrv_cont = None

	@classmethod
	def setUpClass(cls):
		cls.session = omh.MyFancyOMCSession()
		cls.session.appendToMoPath("../..")
		cls.session.loadModel("Modelica")
		cls.loaded = cls.session.loadModel("SHM")
		cls.outdir = outdir
		if not os.path.exists(cls.outdir) :
			os.makedirs(cls.outdir)
		cls.session.cd(outdir)
		cls.simres = cls.session.simulate("SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample", stopTime=cls.simtime)
		cls.data_pressure = cls.session.getResults("blood.vessel.pressure")
		cls.data_hrv = np.loadtxt(os.path.join(outdir,"heartbeats.csv"),skiprows=1)
		tmp_hrv = cls.session.getResults("heart.contraction.T")
		cls.data_hrv_cont = resample_nearest(tmp_hrv[:,0], tmp_hrv[:,1], cls.simtime*1000)
	@classmethod
	def tearDownClass(cls):
		# close session
		del cls.session
	def assertBetween(v, vmin, vmax):
		self.assertGreater(v, vmin)
		self.assertLess(v, vmax)
	def printt(self, name, fmt, value, base):
		match = re.match(r"%(\d*)(.*)", fmt)
		if match :
			fmt = "%%%s%s" % (12, match.group(2))
		stat_line = "%%40s %s %s" % (fmt, fmt)
		print(stat_line % (name, value, base))
	def test_simulate(self):
		self.assertTrue(self.loaded)
		self.assertNotIn("failed", self.simres["messages"].lower())
		self.assertIn("Simulation stopped", self.simres["messages"])
		self.printt("simulation time", "%.3f", self.simres["timeSimulation"], 19.889)
	def test_pressure(self):
		# cut off first 10 seconds
		bp = self.data_pressure[10000:,1]
		bp_mean = np.mean(bp)
		bp_max = np.max(bp)
		bp_min = np.min(bp)
		bp_std = np.std(bp)

		self.printt("MAP", "%.3f", bp_mean, 106.842)
		self.printt("min pressure", "%.3f", bp_min, 74.979)
		self.printt("max pressure", "%.3f", bp_max, 140.912)
		self.printt("standard deviation", "%.3f", bp_std, 18.639)
		
		# normal MAP: 70 - 105 mmHg
		# is already elevated in the model => shift upper range to 110
		self.assertBetween(bp_mean, 70, 110) # TODO reduce to 105 when model is fixed
		
		# normal diastolic pressure: 60 - 90 mmHg
		self.assertBetween(bp_min, 60, 90)

		# normal systolic pressure: 100 - 140 mmHg
		self.assertBetween(bp_max, 100, 150) # TODO reduce to 140 when model is fixed

		# normal standard deviation: 14 - 24 mmHg (taken from model run in base state)
		self.assertBetween(bp_std, 14, 24)
	def plot_hist(self, bins, vals, outfile, val, unit, expected=None):
		f = plt.figure(figsize=(10,5))
		ax = f.add_subplot(111)
		xvals = bins[:-1] 
		bin_width = bins[1]-bins[0]
		ax.bar(xvals, vals, bin_width, label="actual")
		if not (expected is None) :
			diff = vals-expected
			diff_plus = diff.copy()
			diff_plus[np.where(diff_plus < 0)] = 0
			ax.bar(xvals, -diff_plus, bin_width, vals, color=[[0,1,0,0.5]])
			diff_minus = diff.copy()
			diff_minus[np.where(diff_minus > 0)] = 0
			ax.bar(xvals, -diff_minus, bin_width, vals, color=[[1,0,0,0.5]])
		ax.set_title("%s histogram" % val.title())
		ax.set_xlabel("%s [%s]" % (val,unit))
		ax.set_ylabel("% data points")
		plt.savefig(os.path.join(self.outdir, outfile))
		plt.close(f)
	def test_pressure_hist(self):
		vals,bins = np.histogram(self.data_pressure[:,1],np.arange(60,140,10))
		vals = np.array(vals,dtype=float) / len(self.data_pressure)
		expected = np.array([0,0.06,0.18,0.17,0.15,0.14,0.14])
		error = rmse(vals, expected)
		self.plot_hist(bins, vals, "pressure_hist.png", "pressure", "mmHg", expected)
		self.printt("RMSE pressure histogram", "%.3f", error, 0.002)
		# TODO tolerance is chosen very low to not produce false positive test results
		# TODO probably needs to be increased when this test fails repeatedly (look at the plot!)
		self.assertLess(error, 0.005)
	def plot_fft(self, freq, xvals, expected):
		f = plt.figure(figsize=(10,5))
		ax = f.add_subplot(111)
		ax.plot(xvals[1:], freq[1:], label="actual")
		ax.plot(xvals[1:], expected, label="expected")
		ax.set_xlabel("frequency [Hz]")
		ax.set_ylabel("RR-interval spectral density [s]")
		ax.set_title("RR-interval spectral density")
		ax.legend()
		plt.savefig(os.path.join(self.outdir, "fft_full.png"))
		plt.close(f)
	def test_ftt(self):
		n = len(self.data_hrv_cont)
		freq = np.absolute(np.fft.fft(self.data_hrv_cont[:,1]))/n
		t_max = self.data_hrv_cont[-1,0]
		sps = 1.0 * n / t_max # sampling frequency (samples/s)
		f_max = 0.4 # maximum frequency that is interesting for us
		nfreq = round(f_max * t_max) # number of samples to take
		freq = freq[:nfreq]
		xvals = np.fft.fftfreq(n,d=1.0/sps)[:nfreq]
		expected = np.array([
			0.000026, 0.000032, 0.000085, 0.000216, 0.000332, 0.000486, 0.000627, 0.000709,
			0.000698, 0.000629, 0.000549, 0.000466, 0.000395, 0.000332, 0.000291, 0.000249,
			0.000225, 0.000198, 0.000186, 0.000162, 0.000138, 0.000123, 0.000106, 0.000113,
			0.021758, 0.000103, 0.000149, 0.000070, 0.000079, 0.000080, 0.000071, 0.000067,
			0.000077, 0.000093, 0.000099, 0.000102, 0.000098, 0.000092, 0.000088])
		self.plot_fft(freq, xvals, expected)
		err = rmse(freq[1:],expected)

		# very low frequency component (vlf)
		# - not recommended by task force of ESC and NASPE => not implemented
		#vlf = 0

		# low frequency component (lf)
		# high frequency component (hf)

		self.printt("RMSE RR-interval spectral density", "%.9f", err, 0.000000292)
		self.assertLess(err,0.000001) # TODO adjust tolerance
	def test_heart_rate(self):
		# skip all heart beats that occured in the first 10 seconds
		hr = self.data_hrv[np.where(self.data_hrv[:,0] > 10)]
		dt = self.simtime - 10 # seconds of data left
		bpm = len(hr)*60.0/dt
		rr_max = np.max(hr[:,1])
		rr_min = np.min(hr[:,1])
		rr_std = np.std(hr[:,1])

		self.printt("heart rate", "%.3f", bpm, 61.333)
		self.printt("min RR", "%.3f", rr_min, 0.930)
		self.printt("max RR", "%.3f", rr_max, 1.029)
		self.printt("std RR (sdnn)", "%.3f", rr_std, 0.034)

		# normal resting heart rate: 60 - 100 bpm
		self.assertBetween(bpm, 60, 100)

		# standard deviation of nn-inverval (sdnn)
		# normal values (Task Force paper): 141 +- 39 ms
		sdnn = rr_std * 1000
		# TODO increase lower bound to 102 when model is fixed (only possible with noise?)
		self.assertBetween(sdnn, 30, 180)

		# standard deviation of average (over 5 minutes) NN interval (sdann)
		# - estimate for changes in heart rate due to cycles longer than 5 min
		# - cannot be used here, because we only simulate 100 seconds
		#sdann = 0

		# root mean squared successive differences (rmssd)
		# normal values (Task Force paper): 27+-12 ms
		rmssd = rmse(hr[1:,1],hr[:-1,1]) * 1000
		self.printt("rmssd", "%.3f", rmssd, 0) # TODO base value
		self.assertBetween(rmssd, 15, 39)

		# proportion of number of successive interval differences greater than 50 ms (pnn50)
		# - not recommended by task force of ESC and NASPE => not implemented
		# pnn50 = 0

		# triangular interpolation of NN interval histogram (TINN)
		# - not recommended by task force of ESC and NASPE => not implemented
		# tinn = 0

		# sample entropy (SampEn)
		# - -log(p(sim_next|sim_last_m))  (sim_next = next point is similar, sim_last_m = last m points are similar)
		# - lower values (closer to zero) => more self-similarity
		saen = hnl.sampen(hr[:,1])
		self.printt("sample entropy", "%.3f", saen, 0)

		# Lyapunov Exponent
		# - A positive lyapunov exponent is an indicator of chaos
		lexp = np.max(hnl.lyap_e(hr[:,1], emb_dim=10, matrix_dim=4))
		self.printt("lyapunov exponent", "%.3f", lexp, 0)

		# Hurst Exponent
		# - < 0.5 : negative long-term correlations ("mean-reverting" system)
		# - = 0.5 : no long-term correlations (random walk)
		# - > 0.5 : positive long-term correlations ("long-term memory")
		hexp = hnl.hurst_rs(hr[:,1])
		self.printt("hurst exponent", "%.3f", hexp, 0)

		# Correlation Dimension
		# - between 0 and 1, should be < 1 for 1D-system with strange attractor
		cdim = hnl.corr_dim(hr[:,1], 4)
		self.printt("correlation dimension", "%.3f", cdim, 0)

		# Detrended Fluctuation Analysis
		# - < 1 : stationary process with Hurst exponent H = hdfa
		# - > 1 : non-stationary process with Hurst exponent H = hdfa - 1
		hdfa = hnl.dfa(hr[:,1])
		self.printt("hurst parameter (DFA)", "%.3f", hdfa, 0)

		# TODO calculate values for human sample data?
		
	def test_rr_hist(self):
		vals,bins = np.histogram(self.data_hrv[:,1],np.arange(0.5,2.0,0.1))
		vals = np.array(vals, dtype=float) / len(self.data_hrv)
		expected = np.array([0,0,0,0,0.68,0.32,0,0,0,0,0,0,0,0])
		self.plot_hist(bins, vals, "rr_hist.png", "RR-interval", "s", expected)
		error = rmse(vals, expected)

		# HRV triangular index (ti)
		# - number of NN-intervals / number of NN-intervals in maximal bin of histogram
		# - typical bin size: 1/128 s
		vals2, bins2 = np.histogram(self.data_hrv[:,1],np.arange(0.0,1.5,1.0/128))
		ti = 1.0*len(self.data_hrv)/np.max(vals2)

		# TODO set limits
		self.assertGreater(ti, 4)
		self.assertLess(ti,6)
		
		self.printt("RMSE RR-interval histogram", "%.3f", error, 0.001)
		self.printt("HRV triangular index","%.3f", ti, 0) # TODO set base value
		# TODO tolerance is chosen very low to not produce false positive test results
		# TODO probably needs to be increased when this test fails repeatedly (look at the plot!)
		self.assertLess(error, 0.005)
	def test_poincare(self):
		poincare = np.dstack((self.data_hrv[:-1,1],self.data_hrv[1:,1])).reshape((len(self.data_hrv)-1,2))
		ax1 = np.array([-1,1])
		ax2 = np.array([1,1])
		sd = lambda x : np.std(np.dot(poincare, x) / np.linalg.norm(x))
		sd2 = sd(ax2)
		sd1 = sd(ax1)
		self.printt("Poincare SD1", "%.3f", sd1, 0.034)
		self.printt("Poincare SD2", "%.3f", sd2, 0.035)
		
		# TODO adjust values
		self.assertGreater(sd1,0.02)
		self.assertLess(sd1,0.05)
		
		self.assertGreater(sd2,0.02)
		self.assertLess(sd2,0.05)

outdir = "../../../test-output"
if __name__ == '__main__':
	if os.path.exists(outdir):
		try:
			shutil.rmtree(outdir)
		except Exception as e:
			print("WARNING: result directory could not be deleted (%s)" % e)
	unittest.main()


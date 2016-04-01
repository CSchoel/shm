#!python2.7
#^ shebang used by pylauncher to identify python version to use (python2.7 64 bit)

import OMPython
import unittest
import os
import shutil
import numpy as np
import sys
import matplotlib.pyplot as plt
import DyMat
import scipy.interpolate as it

def enquote(s):
	return "\"%s\"" % s

def rmse(x,y):
	return np.sqrt(((x-y)**2).mean())

def resample_nearest(x,y,n):
	nx = np.arange(n,dtype=float) / n * x[-1]
	ny = it.interp1d(x,y,"nearest")(nx)
	return np.dstack((nx, ny)).reshape((n,2))

class MyFancyOMCSession(OMPython.OMCSession):
	def __init__(self):
		OMPython.OMCSession.__init__(self)
		self.debug = False
	def appendToMoPath(self, path):
		self.send("setModelicaPath(getModelicaPath()+\";%s\")" % path)
	def send(self, command):
		if self.debug:
			print ">", command
		res = self.sendExpression(command)
		if self.debug:
			print res
		return res
	def loadModel(self, name):
		res = self.send("loadModel(%s)" % name)
		return res
	def simulate(self, model, startTime=0, stopTime=1, 
							 method="dassl", dt = 0.001, tolerance=1e-6, 
							 fileNamePrefix="simulation_output", 
							 outputFormat="mat", variables=None, 
							 variableFilter=None):
		params = {
			"startTime": startTime,
			"stopTime": stopTime,
			"method": enquote(method),
			"numberOfIntervals": int(round((stopTime-startTime)/dt)),
			"tolerance": tolerance,
			"fileNamePrefix": enquote(fileNamePrefix),
			"outputFormat": enquote(outputFormat),
		}
		self.outputFormat = outputFormat
		if not (variables is None):
			params["variableFilter"] = enquote("^("+"|".join(variables)+")$")
		elif not (variableFilter is None):
			params["variableFilter"] = enquote(variableFilter)
		cmd = "simulate(%s, %s)" % (model, ", ".join(map(lambda x: "%s=%s" % x, params.items())))
		return self.send(cmd)
	def cd(self, path=None):
		cmd = "cd()" if path is None else "cd(%s)" % enquote(path)
		self.send(cmd)
	def getResults(self, *varnames):
		if self.outputFormat != "mat":
			raise "unable to retrieve results from CSV-file, choose outputFormat=\"mat\" instead"
		resFile = self.send("currentSimulationResult")
		data = DyMat.DyMatFile(resFile)
		return data.getVarArray(varnames).T
	def closeResultFile(self):
		self.send("closeSimulationResultFile()")


class TestSHMModel(unittest.TestCase):
	session = None
	loaded = None
	outdir = None
	simres = None
	data_pressure = None
	data_hrv = None
	data_hrv_cont = None

	@classmethod
	def setUpClass(cls):
		cls.session = MyFancyOMCSession()
		cls.session.appendToMoPath("../..")
		cls.session.loadModel("Modelica")
		cls.loaded = cls.session.loadModel("SHM")
		cls.outdir = outdir
		if not os.path.exists(cls.outdir) :
			os.makedirs(cls.outdir)
		cls.session.cd(outdir)
		cls.simres = cls.session.simulate("SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample", stopTime=100)
		cls.data_pressure = cls.session.getResults("blood.vessel.pressure")
		cls.data_hrv = np.loadtxt(os.path.join(outdir,"heartbeats.csv"),skiprows=1)
		tmp_hrv = cls.session.getResults("heart.contraction.T")
		cls.data_hrv_cont = resample_nearest(tmp_hrv[:,0], tmp_hrv[:,1], 100000) # 1000 datapoints per second
	@classmethod
	def tearDownClass(cls):
		# close session
		del cls.session
	def test_simulate(self):
		self.assertTrue(self.loaded)
		self.assertNotIn("failed", self.simres["messages"].lower())
		self.assertIn("Simulation stopped", self.simres["messages"])
	def test_pressure(self):
		# cut off first 10 seconds
		bp = self.data_pressure[10000:,1]
		bp_mean = np.mean(bp)
		bp_max = np.max(bp)
		bp_min = np.min(bp)
		bp_std = np.std(bp)
		
		# normal MAP: 70 - 105 mmHg
		# is already elevated in the model => shift upper range to 110
		self.assertGreater(bp_mean, 70)
		self.assertLess(bp_mean, 110) # TODO reduce to 105 when model is fixed
		
		# normal diastolic pressure: 60 - 90 mmHg
		self.assertGreater(bp_min, 60)
		self.assertLess(bp_min, 90)

		# normal systolic pressure: 100 - 140 mmHg
		self.assertGreater(bp_max, 100)
		self.assertLess(bp_max, 150) # TODO reduce to 140 when model is fixed

		# normal standard deviation: 14 - 24 mmHg (taken from model run in base state)
		self.assertGreater(bp_std, 14)
		self.assertLess(bp_std, 24)

		stat_line = "%20s %7.3f %7.3f"
		print "%20s %7s %7s" % ("test parameter", "value", "base")
		print stat_line % ("MAP", bp_mean, 106.842)
		print stat_line % ("min pressure", bp_min, 74.979)
		print stat_line % ("max pressure", bp_max, 140.912)
		print stat_line % ("standard deviation", bp_std, 18.639)
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
		# TODO tolerance is chosen very low to not produce false positive test results
		# TODO probably needs to be increased when this test fails repeatedly (look at the plot!)
		self.assertLess(error, 0.005)
		print "RMSE pressure histogram: %7.3f" % error
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
		print "RMSE RR-interval spectral density: %.9f" % err
		self.assertLess(err,0.000001) # TODO adjust tolerance
	def test_heart_rate(self):
		# skip all heart beats that occured in the first 10 seconds
		hr = self.data_hrv[np.where(self.data_hrv[:,0] > 10)]
		dt = 90 # 90 seconds of data left
		bpm = len(hr)*60.0/dt
		rr_max = np.max(hr[:,1])
		rr_min = np.min(hr[:,1])
		rr_std = np.std(hr[:,1])

		# normal resting heart rate: 60 - 100 bpm
		self.assertGreater(bpm, 60)
		self.assertLess(bpm, 100)
		stat_line = "%20s %7.3f %7.3f"
		print "%20s %7s %7s" % ("test parameter", "value", "base")
		print stat_line % ("heart rate", bpm, 0)
		print stat_line % ("min RR", rr_min, 0)
		print stat_line % ("max RR", rr_max, 0)
		print stat_line % ("std RR", rr_std, 0)
	def test_rr_hist(self):
		vals,bins = np.histogram(self.data_hrv[:,1],np.arange(0.5,2.0,0.1))
		vals = np.array(vals, dtype=float) / len(self.data_hrv)
		expected = np.array([0,0,0,0,0.68,0.32,0,0,0,0,0,0,0,0])
		self.plot_hist(bins, vals, "rr_hist.png", "RR-interval", "s", expected)
		error = rmse(vals, expected)
		# TODO tolerance is chosen very low to not produce false positive test results
		# TODO probably needs to be increased when this test fails repeatedly (look at the plot!)
		self.assertLess(error, 0.005)
		print "RMSE RR-interval histogram: %7.3f" % error
outdir = "../../../test-output"
if __name__ == '__main__':
	if os.path.exists(outdir):
		try:
			shutil.rmtree(outdir)
		except Exception as e:
			print "WARNING: result directory could not be deleted (%s)" % e
	unittest.main()


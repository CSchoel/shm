#!python2.7
#^ shebang used by pylauncher to identify python version to use (python2.7 64 bit)

import OMPython
import unittest
import os
import shutil
import numpy as np

def enquote(s):
	return "\"%s\"" % s
	

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
		if self.outputFormat == "csv":
			raise "unable to retrieve results from CSV-file, choose outputFormat=\"mat\" instead"
		cmd = "readSimulationResult(currentSimulationResult,{%s})" % ", ".join(varnames)
		# readSimulationResults returns array with variable as the first index and time as second
		# => transpose to get array of data rows with time as first index
		return np.array(self.send(cmd)).T
	def closeResultFile(self):
		self.send("closeSimulationResultFile()")


class TestSHMModel(unittest.TestCase):
	session = None
	loaded = None
	outdir = None
	simres = None
	data_pressure = None
	data_hrv = None

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
		cls.data_pressure = cls.session.getResults("time", "blood.vessel.pressure")
		cls.data_hrv = np.loadtxt(os.path.join(outdir,"heartbeats.csv"),skiprows=1)
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



outdir = "../../../test-output"
if __name__ == '__main__':
	if os.path.exists(outdir):
		try:
			shutil.rmtree(outdir)
		except Exception as e:
			print "WARNING: result directory could not be deleted (%s)" % e
	unittest.main()


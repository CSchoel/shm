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
		return np.array(self.send(cmd))
	def closeResultFile(self):
		self.send("closeSimulationResultFile()")


class TestSHMModel(unittest.TestCase):
	def setUp(self):
		self.session = MyFancyOMCSession()
		self.session.appendToMoPath("../..")
		self.session.loadModel("Modelica")
		self.loaded = self.session.loadModel("SHM")
		self.outdir = outdir
		if not os.path.exists(self.outdir) :
			os.makedirs(self.outdir)
		self.session.cd(outdir)
	def test_simulate(self):
		self.assertTrue(self.loaded)
		res = self.session.simulate("SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample")
		self.assertFalse("error" in res["messages"].lower())
		self.assertFalse("Simulation Failed." in res["messages"])

outdir = "../../../test-output"

if __name__ == '__main__':
	if os.path.exists(outdir):
		try:
			shutil.rmtree(outdir)
		except Exception as e:
			print "WARNING: result directory could not be deleted (%s)" % e
	unittest.main()


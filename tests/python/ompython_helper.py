import OMPython
import DyMat # https://bitbucket.org/jraedler/dymat
import os

# TODO error handling

def enquote(s):
	return "\"%s\"" % s

class MyFancyOMCSession(OMPython.OMCSessionZMQ):
	def __init__(self):
		OMPython.OMCSessionZMQ.__init__(self)
		self.debug = False
	def appendToMoPath(self, path):
		ap = os.path.abspath(path)
		delim = ";" if os.name == "nt" else ":"
		self.send("setModelicaPath(getModelicaPath()+\"%s%s\")" % (delim, ap))
	def send(self, command):
		if self.debug:
			print(">", command)
		res = self.sendExpression(command)
		if self.debug:
			print(res)
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
		self.resFile = os.path.join(
			self.send("cd()"),
			"simulation_output_res.%s" % outputFormat
		)
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
		data = DyMat.DyMatFile(self.resFile)
		return data.getVarArray(varnames).T
	def closeResultFile(self):
		self.send("closeSimulationResultFile()")

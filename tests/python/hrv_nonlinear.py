import numpy as np
import matplotlib.pyplot as plt


def lyap(data, emb_dim=10, matrix_dim=4, min_nb=None, tau=1):
	# TODO more detailed description of the algorithm / lyapunov exponent
	"""
	Estimates the lyapunov exponents for the given data using the algorithm of Eckmann et al..

	Recommendations for parameter settings by Eckmann et al.:
		* long recording time improves accuracy, small tau does not
		* use large values for emb_dim
		* matrix_dim should be 'somewhat larger than the expected number of positive lyapunov exponents'
		* min_nb = min(2 * matrix_dim, matrix_dim + 4)

	Args:
		data (iterable): list/array of (scalar) data points

	Kwargs:
		emb_dim (int): embedding dimension
		matrix_dim (int): matrix dimension (emb_dim - 1 must be divisible by matrix_dim - 1)
		min_nb (int): minimal number of neighbors (default: min(2 * matrix_dim, matrix_dim + 4))
		tau (float): step size of the data in seconds

	Returns:
		array of matrix_dim lyapunov exponents
	"""
	n = len(data)
	if (emb_dim - 1) % (matrix_dim - 1) != 0:
		raise "emb_dim - 1 must be divisible by matrix_dim - 1!"
	m = (emb_dim - 1) / (matrix_dim - 1) 
	if min_nb is None:
		# minimal number of neighbors as suggested by Eckmann et al.
		min_nb = min(2 * matrix_dim, matrix_dim + 4)

	# construct orbit as matrix (e = emb_dim)
	# x0 x1 x2 ... xe-1
	# x1 x2 x3 ... xe
	# x2 x3 x4 ... xe+1
	# ...
	
	# note: we need to be able to step m points further for the beta vector
	#       => maximum start index is n - emb_dim - m
	orbit = np.array([data[i:i+emb_dim] for i in range(n - emb_dim + 1 - m)], dtype=float)
	old_Q = np.identity(matrix_dim)
	lexp = np.zeros(matrix_dim)
	for i in range(len(orbit)):
		# find neighbors for each vector in the orbit using the chebychev distance
		diffs = np.max(np.abs(orbit - orbit[i]), axis=1)
		diffs[i] = float('inf') # ensure that we do not count the difference of the vector to itself
		indices = np.argsort(diffs)
		idx = indices[min_nb-1] # index of the min_nb-nearest neighbor
		r = diffs[idx] # corresponding distance
		# there may be more than min_nb vectors at distance r (if multiple vectors have a distance of exactly r)
		# => update index accordingly
		indices = np.where(diffs <= r)[0]
		
		# build matrix X for linear least squares (d_M = matrix_dim)
		# x_j1 - x_i   x_j1+m - x_i+m   ...   x_j1+(d_M-1)m - x_i+(d_M-1)m
		# x_j2 - x_i   x_j2+m - x_i+m   ...   x_j2+(d_M-1)m - x_i+(d_M-1)m
		# ...

		# note: emb_dim = (d_M - 1) * m + 1
		mat_X = np.array([data[j:j+emb_dim:m] for j in indices])
		mat_X -= data[i:i+emb_dim:m]
		
		# build vector beta for linear least squares
		# x_j1+(d_M)m - x_i+(d_M)m
		# x_j2+(d_M)m - x_i+(d_M)m
		# ...
		vec_beta = data[indices + matrix_dim * m] - data[i + matrix_dim * m]

		# perform linear least squares
		a,_,_,_ = np.linalg.lstsq(mat_X, vec_beta)
		# build matrix L
		# 0  1  0  ... 0
		# 0  0  1  ... 0
		# ...
		# 0  0  0  ... 1
		# a1 a2 a3 ... a_(d_M)
		mat_T = np.zeros((matrix_dim, matrix_dim))
		mat_T[:-1,1:] = np.identity(matrix_dim-1)
		mat_T[-1] = a

		# QR-decomposition of T * old_Q
		mat_Q, mat_R = np.linalg.qr(np.dot(mat_T, old_Q))
		# force diagonal of R to be positive (if QR = A then also QLL'R = A with L' = L^-1)
		sign_diag = np.sign(np.diag(mat_R))
		sign_diag[np.where(sign_diag == 0)] = 1
		sign_diag = np.diag(sign_diag)
		mat_Q = np.dot(mat_Q, sign_diag)
		mat_R = np.dot(sign_diag, mat_R)
		
		# TODO tolerance value may not be applicable for matrices with very large values
		# assert np.sum(np.abs(np.dot(mat_Q, mat_R) - np.dot(mat_T, old_Q))) < 1e-10

		old_Q = mat_Q

		# successively build sum for lyapunov exponents
		lexp += np.log(np.diag(mat_R))
	# normalize exponents over number of individual mat_Rs
	lexp /= len(orbit)
	# normalize with respect to tau
	lexp /= tau
	# take m into account
	lexp /= m
	return lexp


def test_lyap():
	rvalues = np.arange(2, 4, 0.01)
	lambdas = []
	lambdas_est = []
	maps = []
	logistic = lambda x : r * x * (1 - x)
	for r in rvalues:
		x = 0.1
		result = []
		full_data = [x]
		# ignore first 100 values for bifurcation plot
		for t in range(100):
			x = logistic(x)
			result.append(np.log(abs(r-2*r*x)))
			full_data.append(x)
		lambdas.append(np.mean(result))
		for t in range(20):
			x = logistic(x)
			maps.append(x)
			full_data.append(x)
		le = lyap(np.array(full_data), emb_dim=6, matrix_dim=2)
		#print(full_data)
		#print(le)
		lambdas_est.append(np.max(le))
	#print(lambdas_est)
	plt.plot(rvalues, lambdas, "b-")
	plt.plot(rvalues, lambdas_est, color="#00AAAA")
	plt.plot(rvalues, np.zeros(len(rvalues)), "g--")
	xvals = np.repeat(rvalues, 20)
	plt.plot(xvals, maps, "ro", alpha=0.1)
	plt.ylim((-2,2))
	plt.show()

def sampen(data, emb_dim=2, tolerance=None, dist="chebychev"):
	# TODO more verbose description of sample entropy
	"""
	Computes the sample entropy of the given data.

	Args:
		data (iterable): the list/array of data points

	Kwargs:
		emb_dim (int): the embedding dimension (length of vectors to compare)
		tolerance (float): distance threshold for two template vectors to be considered equal (default: 0.2 * std(data))
		dist (string): distance function used to calculate the distance between template vectors, can be 'euler' or 
		               'chebychev'

	Returns: the sample entropy of the data (negative logarithm of ratio between similar template 
	         vectors of length emb_dim + 1 and emb_dim)
	"""
	if tolerance is None:
		tolerance = 0.2*np.std(data)
	n = len(data)

	# build matrix of "template vectors" 
	# (all consecutive subsequences of length m)
	# x0 x1 x2 x3 ... xm-1
	# x1 x2 x3 x4 ... xm
	# x2 x3 x4 x5 ... xm+1
	# ...
	# x_n-m-1     ... xn-1

	# since we need two of these matrices for m = emb_dim and m = emb_dim +1, 
	# we build one that is large enough => shape (emb_dim+1, n-emb_dim)

	# note that we ignore the last possible template vector with length emb_dim, 
	# because this vector has no corresponding vector of length m+1 and thus does 
	# not count towards the conditional probability
	# (otherwise first dimension would be n-emb_dim+1 and not n-emb_dim)
	tVecs = np.zeros((n - emb_dim, emb_dim + 1))
	for i in range(tVecs.shape[0]):
		tVecs[i,:] = data[i:i+tVecs.shape[1]]
	counts = []
	for m in [emb_dim, emb_dim+1]:
		counts.append(0)
		# get the matrix that we need for the current m
		tVecsM = tVecs[:n-m+1,:m]
		# successively calculate distances between each pair of template vectors
		for i in range(len(tVecsM)-1):
			diff = tVecsM[i+1:] - tVecsM[i]
			if dist == "chebychev":
				dsts = np.max(np.abs(diff),axis=1)
			elif dist == "euler":
				dsts = np.norm(diff, axis=1)
			else :
				raise "unknown distance function: %s" % dist
			# count how many distances are smaller than the tolerance
			counts[-1] += np.sum(dsts < tolerance)
	return -np.log(1.0*counts[1]/counts[0])


def binary_n(total_N, min_n=50):
	max_exp = np.log2(1.0 * total_N / min_n)
	max_exp = int(np.floor(max_exp))
	return [int(round(1.0*total_N/(2**i))) for i in range(1, max_exp+1)]

def rs(data, n):
	total_N = len(data)
	data = data[:total_N - (total_N % n)] # make data divisible by n
	seqs = np.reshape(data, (total_N/n, n))
	means = np.mean(seqs,axis=1)
	y = seqs - means.reshape((len(seqs), 1))
	y = np.cumsum(y, axis=1)
	r = np.max(y,axis=1) - np.min(y, axis=1)
	s = np.std(seqs,axis=1)
	return np.mean(r/s)


def hurst_rs(data, nvals=None):
	total_N = len(data)
	if nvals is None:
		nvals = binary_n(total_N, 50)
	rsvals = [rs(data, n) for n in nvals]
	poly = np.polyfit(np.log(nvals), np.log(rsvals), 1)
	return poly[0]

if __name__ == "__main__":
	#test_lyap()
	#data = [1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5]
	#data = np.random.random((100,)) * 10
	#data = np.concatenate([np.arange(100)] * 3)
	# TODO random numbers should give positive exponents, what is happening here?
	#l = lyap(np.array(data), emb_dim=7, matrix_dim=3)
	#print(l)
	#exit()

	# TODO why does this not work for the brownian motion?
	n = 10000
	#data = np.arange(n) # should give result 1
	#data = np.cumsum(np.random.randn(n)) # brownian motion, should give result 0.5
	data = np.random.randn(n) # should give result 0
	print(hurst_rs(data, nvals = binary_n(len(data), 2)))

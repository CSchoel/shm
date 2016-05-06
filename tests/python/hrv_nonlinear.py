import numpy as np
import matplotlib.pyplot as plt


def lyap(data, emb_dim=10, matrix_dim=4, min_nb=None, tau=1):
	"""
	Estimates the Lyapunov exponents for the given data using the algorithm of Eckmann et al..

	Recommendations for parameter settings by Eckmann et al.:
		* long recording time improves accuracy, small tau does not
		* use large values for emb_dim
		* matrix_dim should be 'somewhat larger than the expected number of positive Lyapunov exponents'
		* min_nb = min(2 * matrix_dim, matrix_dim + 4)

	Explanation of Lyapunov exponents:
		The Lyapunov exponent describes the rate of separation of two infinitesimally close 
		trajectories of a dynamical system in phase space. In a chaotic system, these trajectories
		diverge exponentially following the equation:

		|X(t, X_0) - X(t, X_0 + eps)| = e^(lambda * t) * |eps|

		In this equation X(t, X_0) is the trajectory of the system X starting at the point X_0 in
		phase space at time t. eps is the (infinitesimal) difference vector and lambda is called
		the Lyapunov exponent. If the system has more than one free variable, the phase space is
		multidimensional and each dimension has its own Lyapunov exponent. The existence of at 
		least one positive Lyapunov exponent is generally seen as a strong indicator for chaos.

	Explanation of the Algorithm:
		To calculate the Lyapunov exponents analytically, the Jacobian of the system is required.
		The algorithm of Eckmann et al. therefore tries to estimate this Jacobian by reconstructing
		the dynamics of the system from which the time series was obtained. For this, several
		steps are required:

		* Embed the time series [x_1, x_2, ..., x_(N-1)] in an orbit of emb_dim dimensions 
		  (map each point x_i of the time series to a vector [x_i, x_(i+1), x_(i+2), ... x_(i+emb_dim-1)]).
		* For each vector X_i in this orbit find a radius r_i so that at least min_nb other vectors
		  lie within (chebychev-)distance r_i around X_i. These vectors will be called 
		  "neighbors" of X_i.
		* Find the Matrix T_i that sends points from the neighborhood of X_i to the neighbor
		  hood of X_(i+1). To avoid undetermined values in T_i, we construct T_i not with size
		  (emb_dim x emb_dim) but with size (matrix_dim x matrix_dim), so that we have a larger
		  "step size" m in the X_i, which are now defined as X'_i = [x_i, x_(i+m), x_(i+2m), 
		  ... x_(i+(matrix_dim-1)*m)]. This means that emb_dim-1 must be divisible by matrix_dim-1.
		  The T_i are then found by a linear least squares fit, assuring that 
		  T_i (X_j - X_i) ~= X_(j+m) - X_(i+m) for any X_j in the neighborhood of X_i.
		* Starting with i = 1 and Q_0 = identity successively decompose the matrix T_i * Q_(i-1) 
		  into the matrices Q_i and R_i by a QR-decomposition.
		* Calculate the Lyapunov exponents from the mean of the logarithm of the diagonal
		  elements of the matrices R_i. To normalize the Lyapunov exponents, they have to be
		  divided by m and by the step size tau of the original time series.

	References:
		[1] J. P. Eckmann, S. O. Kamphorst, D. Ruelle, and S. Ciliberto, 
		    “Liapunov exponents from time series,” Physical Review A, 
		    vol. 34, no. 6, pp. 4971–4979, 1986.


	Args:
		data (iterable): list/array of (scalar) data points

	Kwargs:
		emb_dim (int): embedding dimension
		matrix_dim (int): matrix dimension (emb_dim - 1 must be divisible by matrix_dim - 1)
		min_nb (int): minimal number of neighbors (default: min(2 * matrix_dim, matrix_dim + 4))
		tau (float): step size of the data in seconds (normalization scaling factor for exponents)

	Returns:
		float array: array of matrix_dim Lyapunov exponents
	"""
	n = len(data)
	if (emb_dim - 1) % (matrix_dim - 1) != 0:
		raise ValueError("emb_dim - 1 must be divisible by matrix_dim - 1!")
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
		# TODO also mask vectors that are too close in the original data?
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
		# build matrix T
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

		# successively build sum for Lyapunov exponents
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

	Explanation of the sample entropy:
		The sample entropy of a time series is defined as the negative natural logarithm
		of the conditional probability that two sequences similar for emb_dim points remain 
		similar at the next point, excluding self-matches.

		A lower value for the sample entropy therefore corresponds to a higher probability
		indicating more self-similarity.

	Explanation of the algorithm:
		The algorithm constructs all subsequences of length emb_dim [s_1, s_2, s_3, ...] and 
		then counts each pair (s_i, s_j) with i != j where dist(s_i, s_j) < tolerance. The same process
		is repeated for all subsequences of length emb_dim + 1. The sum of similar sequence pairs 
		with length emb_dim + 1 is divided by the sum of similar sequence pairs with length emb_dim.
		The result of the algorithm is the negative logarithm of this ratio/probability.

	References:
		[1] J. S. Richman and J. R. Moorman, “Physiological time-series 
		    analysis using approximate entropy and sample entropy,” 
		    American Journal of Physiology-Heart and Circulatory Physiology, 
		    vol. 278, no. 6, pp. H2039–H2049, 2000.

	Args:
		data (iterable): the list/array of data points

	Kwargs:
		emb_dim (int): the embedding dimension (length of vectors to compare)
		tolerance (float): distance threshold for two template vectors to be considered 
		                   equal (default: 0.2 * std(data))
		dist (string): distance function used to calculate the distance between template vectors, 
		               can be 'euler' or 'chebychev'

	Returns: 
		float: the sample entropy of the data (negative logarithm of ratio between similar template 
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
	"""
	Creates a list of values by successively halving the total length total_N
	until the resulting value is less than min_n.

	Non-integer results are rounded down.

	Creates a list of values total_N/2^1, total_N/2^2, total_N/2^3, ... until total_N/2^i < min_n

	Args:
		total_N (int): total length
	Kwargs:
		min_n (int): minimal length after division

	Returns:
		list of integers: total_N/2, total_N/4, total_N/8, ... until total_N/2^i < min_n
	"""
	max_exp = np.log2(1.0 * total_N / min_n)
	max_exp = int(np.floor(max_exp))
	return [int(np.floor(1.0*total_N/(2**i))) for i in range(1, max_exp+1)]

def rs(data, n):
	"""
	Calculates an individual R/S value in the rescaled range approach for a given n.

	Note: This is just a helper function for hurs_rs and should not be called directly.

	Args:	
		data (array of float): time series
		n (float): size of the subseries in which data should be split
	"""
	total_N = len(data)
	# cut values at the end of data to make the array divisible by n
	data = data[:total_N - (total_N % n)]
	# split remaining data into subsequences of length n
	seqs = np.reshape(data, (total_N/n, n))
	# calculate means of subsequences
	means = np.mean(seqs,axis=1)
	# normalize subsequences by substracting mean
	y = seqs - means.reshape((total_N/n,1))
	# build cumulative sum of subsequences
	y = np.cumsum(y, axis=1)
	# find ranges
	r = np.max(y,axis=1) - np.min(y, axis=1)
	# find standard deviation
	s = np.std(seqs,axis=1)
	# return mean of r/s along subsequence index
	return np.mean(r/s)


def hurst_rs(data, nvals=None):
	"""
	Calculates the hurst exponent by a standard rescaled range (R/S) approach.

	Args:
		data (array of float): time series
	Kwargs:
		nvals (iterable of int): sizes of subseries to use

	Returns:
		float: estimated Hurst exponent using (R/S)
	"""
	total_N = len(data)
	if nvals is None:
		nvals = binary_n(total_N, 50)
	# get individual values for (R/S)_n
	rsvals = [rs(data, n) for n in nvals]
	# fit a line to the logarithm of the obtained (R/S)_n
	poly = np.polyfit(np.log(nvals), np.log(rsvals), 1)
	# return line slope
	# TODO remove
	plt.plot(np.log(nvals), np.log(rsvals))
	plt.show()
	return poly[0]

def corr_dim(data, emb_dim, rvals=None):
	# TODO more verbose description of correlation dimension
	"""
	Calculates the correlation dimension with tge Grassberger-Procaccia algorithm

	Args:
		data (array of float): time series of data points
		emb_dim (int): embedding dimension
	Kwargs:
		rvals (iterable of float): list of values to use for calculating individual C(r) values

	Returns:
		slope of the line fittet to log(r) vs log(C(r)) as estimate of correlation dimension
	"""
	# TODO what are good values for r?
	# TODO do this for multiple values of emb_dim?
	if rvals is None:
		rvals = np.arange(0.1,0.5,0.01) * np.std(data)
	dist = lambda x, y: np.max(np.abs(x - y), axis=1)
	n = len(data)
	orbit = np.array([data[i:i+emb_dim] for i in range(n - emb_dim + 1)])
	dists = np.array([dist(orbit, orbit[i]) for i in range(len(orbit))])
	csums = []
	for r in rvals:
		s = 1.0 / (n * (n-1)) * np.sum(dists < r)
		csums.append(s)
	csums = np.array(csums)
	poly = np.polyfit(np.log(rvals), np.log(csums), 1)
	# TODO remove
	plt.plot(np.log(rvals), np.log(csums))
	plt.show()
	return poly[0]

def dfa(data, nvals= None):
	"""
	Performs a detrended fluctuation analysis on the given data

	Args:
		data (array of float): time series
	Kwargs:
		nvals (iterable of int): subseries sizes at which to calculate fluctuation
	"""
	total_N = len(data)
	if nvals is None:
		nvals = binary_n(total_N, 50)
	fluctuations = []
	for n in nvals:
		# subdivide data into chunks of size n
		d = data[:total_N % n]
		d = data.reshape((total_N/n, n))
		# calculate a "walk" from the data by taking the cumulative sum of subsequences
		# TODO do we get the same result with less computations when we take the cumulative 
		# sum only once at the beginning for the whole sequence?
		walk = np.cumsum(d, axis=1)
		x = np.arange(n)
		# calculate local trends as polynomes
		poly = np.array([np.polyfit(x, walk[i], 1) for i in range(len(walk))])
		print(walk.shape, poly.shape)
		trend = poly[:,0] * np.repeat([x], len(walk),axis=0) + poly[:,1]
		# calculate variance ("fluctuation") of original walk (walk) around trend
		flucs = np.sqrt(np.sum((walk - trend) ** 2, axis=1) / n)
		# calculate mean fluctuation over all subsequences
		f_n = np.sum(flucs) / len(flucs)
		fluctuations.append(f_n)
	fluctuations = np.array(fluctuations)
	poly = np.polyfit(np.log(nvals), np.log(fluctuations))
	return poly[0]

def test_lyap2():
	#test_lyap()
	data = [1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5]
	data = np.random.random((100,)) * 10
	data = np.concatenate([np.arange(100)] * 3)
	# TODO random numbers should give positive exponents, what is happening here?
	l = lyap(np.array(data), emb_dim=7, matrix_dim=3)
	print(l)

def test_hurst():
	# TODO why does this not work for the brownian motion?
	n = 10000
	data = np.arange(n) # should give result 1
	#data = np.cumsum(np.random.randn(n)) # brownian motion, should give result 0.5
	#data = np.random.randn(n) # should give result 0
	data = np.sin(np.arange(n,dtype=float) / (n-1) * np.pi * 100)
	print(hurst_rs(data, nvals = binary_n(len(data), 50)))

def test_corr():
	n = 1000
	data = np.arange(n)
	print(corr_dim(data, 4))

def test_dfa():
	n = 1000
	data = np.arange(n)
	print(dfa(data))

if __name__ == "__main__":
	test_dfa()

	

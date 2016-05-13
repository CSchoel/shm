# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import warnings

def delay_embedding(data, emb_dim, lag=1):
	"""
	Perform a time-delay embedding of a time series

	Args:
		emb_dim (int): the embedding dimension
	Kwargs:
		lag (int): the lag between elements in the embedded vectors

	Returns:
		emb_dim x m array: matrix of embedded vectors of the form 
		                   [data[i], data[i+lag], data[i+2*lag], ... data[i+(emb_dim-1)*lag]]
		                   for i in 0 to m-1 (m = len(data)-(emb_dim-1)*lag)
	"""
	m = len(data) - (emb_dim-1)*lag
	indices = np.repeat([np.arange(emb_dim)*lag], m, axis=0)
	indices += np.arange(m).reshape((m,1))
	return data[indices]

def lyap_r(data, emb_dim=10, lag=None, min_tsep=None, tau=1, min_vectors=20, trajectory_len=20, debug_plot=False):
	"""
	Estimates the largest lyapunov exponent using the algorithm of Rosenstein et al.

	Explanation of Lyapunov exponents:
		See lyap_e.

	Args:
		data (iterable of float): (one-dimensional) time series
	Kwargs:
		emb_dim (int): embedding dimension for delay embedding
		lag (float): lag for delay embedding
		min_tsep (float): minimal temporal separation between two "neighbors"
		tau (float): step size between data points in the time series in seconds
		min_vectors (int): if lag=None, the search for a suitable lag will be stopped
		                   when the number of resulting vectors drops below min_vectors
		min_trajectory_len (int): do not consider points as neighbors that can only be
		                          followed for less than min_trajectory_len steps
	Returns:
		float: an estimate of the largest lyapunov exponent (a positive exponent is
		       a strong indicator for chaos)
	"""
	n = len(data)
	max_tsep_factor = 0.25
	if lag is None or min_tsep is None:
		# calculate min_tsep as mean period (= 1 / mean frequency)
		f = np.fft.rfft(data, n*2-1)
		mf = np.fft.rfftfreq(n*2-1) * np.abs(f)
		mf = np.mean(mf[1:]) / np.sum(np.abs(f[1:]))
		min_tsep = int(np.ceil(1.0/mf))
		if min_tsep > max_tsep_factor * n:
			min_tsep = int(max_tsep_factor * n)
			warnings.warn("signal has very low mean frequency, setting min_tsep = %d" % min_tsep)
		# calculate the lag as point where the autocorrelation drops to (1 - 1/e) times its
		# maximum value
		# note: the Wiener–Khinchin theorem states that the spectral decomposition of the
		# autocorrelation function of a process is the power spectrum of that process
		# => we can use fft to calculate the autocorrelation
		acorr = np.fft.irfft(f * np.conj(f))
		acorr = np.roll(acorr, n-1)
		eps = acorr[n-1] * (1 - 1.0 / np.e)
		lag = 1
		for i in range(n):
			if acorr[n-1+i] < eps or acorr[n-1-i] < eps or 1.0 * n / emb_dim * i < min_vectors:
				lag = i
				break
		if 1.0 * n / emb_dim * lag < min_vectors:
			warnings.warn("autocorrelation declined too slowly to find suitable lag")
	# delay embedding
	orbit = delay_embedding(data, emb_dim, lag)
	m = len(orbit)
	# construct matrix with pairwise distances between vectors in orbit
	dists = np.array([rowwise_euler(orbit, orbit[i]) for i in range(m)])
	# we do not want to consider vectors as neighbor that are less than min_tsep time steps
	# together => mask the distances min_tsep to the right and left of each index by setting
	# them to infinity (will never be considered as nearest neighbors)
	for i in range(m):
		dists[i,max(0,i-min_tsep):i+min_tsep+1] = float("inf")
	# find nearest neighbors (exclude last columns, because these vectors cannot be followed
	# in time for trajectory_len steps)
	nb_idx = np.argmin(dists[:,:-trajectory_len+1], axis=1)
	ntraj = m-trajectory_len
	# build divergence trajectory by averaging distances along the trajectory over all neighbor
	# pairs
	div_traj = np.zeros(trajectory_len, dtype=float)
	for i,j in zip(range(ntraj), nb_idx):
		indices = (range(i,i+trajectory_len), range(j,j+trajectory_len))
		div_traj += dists[indices]
	div_traj /= ntraj
	if np.any(div_traj == 0):
		# if we have zeros in the divergence trajectory, we get -inf in the log plot and therefore
		# cannot correctly fit a line
		poly = [np.inf, 0]
	else:
		# normal line fitting
		poly = np.polyfit(np.log(np.arange(trajectory_len)+1), np.log(div_traj), 1)
	if debug_plot:
		plot_reg(np.log(np.arange(trajectory_len)+1), np.log(div_traj), poly, "log(i)", "log(d(i))")
	return poly[0]

def lyap_e(data, emb_dim=10, matrix_dim=4, min_nb=None, tau=1):
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
		float array: array of matrix_dim Lyapunov exponents (positive exponents are indicators
		             for chaos)
	"""
	n = len(data)
	if (emb_dim - 1) % (matrix_dim - 1) != 0:
		raise ValueError("emb_dim - 1 must be divisible by matrix_dim - 1!")
	m = (emb_dim - 1) // (matrix_dim - 1) 
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
		
		# find the matrix T_i that satisifies
		# T_i (orbit'[j] - orbit'[i]) = (orbit'[j+m] - orbit'[i+m])
		# for all neighbors j where orbit'[i] = [x[i], x[i+m], ... x[i + (matrix_dim-1)*m]]

		# note that T_i has the following form:
		# 0  1  0  ... 0
		# 0  0  1  ... 0
		# ...
		# a0 a1 a2 ... a(matrix_dim-1)

		# This is because for all rows except the last one the aforementioned equation has
		# a clear solution since
		# orbit'[j+m] - orbit'[i+m] = [x[j+m]-x[i+m], x[j+2*m]-x[i+2*m], ... x[j+d_M*m]-x[i+d_M*m]]
		# and
		# orbit'[j] - orbit'[i] = [x[j]-x[i], x[j+m]-x[i+m], ... x[j+(d_M-1)*m]-x[i+(d_M-1)*m]]
		# therefore x[j+k*m] - x[i+k*m] is already contained in orbit'[j] - orbit'[x]
		# for all k from 1 to matrix_dim-1. Only for k = matrix_dim there is an actual
		# problem to solve.

		# We can therefore find a = [a0, a1, a2, ... a(matrix_dim-1)] by formulating a
		# linear least squares problem (mat_X * a = vec_beta) as follows.

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

def sampen(data, emb_dim=2, tolerance=None, dist="chebychev"):
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

def logarithmic_n(min_n, max_n, factor):
	"""
	Creates a list of values by successively multiplying a minimum value min_n by
	a factor > 1 until a maximum value max_n is reached.

	Non-integer results are rounded down.

	Args:
		min_n (float): minimum value (must be < max_n)
		max_n (float): maximum value (must be > min_n)
		factor (float): factor used to increase min_n (must be > 1)

	Returns:
		list of integers: min_n, min_n * factor, min_n * factor^2, ... min_n * factor^i < max_n
		                  without duplicates
	"""
	assert max_n > min_n
	assert factor > 1
	# stop condition: min * f^x = max
	# => f^x = max/min
	# => x = log(max/min) / log(f)
	max_i = int(np.floor(np.log(1.0 * max_n / min_n) / np.log(factor)))
	ns = [min_n]
	for i in range(max_i+1):
		n = int(np.floor(min_n * (factor ** i)))
		if n > ns[-1]:
			ns.append(n)
	return ns

def logarithmic_r(min_n, max_n, factor):
	"""
	Creates a list of values by successively multiplying a minimum value min_n by
	a factor > 1 until a maximum value max_n is reached.

	Args:
		min_n (float): minimum value (must be < max_n)
		max_n (float): maximum value (must be > min_n)
		factor (float): factor used to increase min_n (must be > 1)

	Returns:
		list of floats: min_n, min_n * factor, min_n * factor^2, ... min_n * factor^i < max_n
	"""
	assert max_n > min_n
	assert factor > 1
	max_i = int(np.floor(np.log(1.0 * max_n / min_n) / np.log(factor)))
	return (int(np.floor(min_n * (factor ** i))) for i in range(max_i+1))

def rs(data, n):
	"""
	Calculates an individual R/S value in the rescaled range approach for a given n.

	Note: This is just a helper function for hurs_rs and should not be called directly.

	Args:	
		data (array of float): time series
		n (float): size of the subseries in which data should be split

	Returns: 
		float: (R/S)_n
	"""
	total_N = len(data)
	# cut values at the end of data to make the array divisible by n
	data = data[:total_N - (total_N % n)]
	# split remaining data into subsequences of length n
	seqs = np.reshape(data, (total_N//n, n))
	# calculate means of subsequences
	means = np.mean(seqs,axis=1)
	# normalize subsequences by substracting mean
	y = seqs - means.reshape((total_N//n,1))
	# build cumulative sum of subsequences
	y = np.cumsum(y, axis=1)
	# find ranges
	r = np.max(y,axis=1) - np.min(y, axis=1)
	# find standard deviation
	s = np.std(seqs,axis=1)
	# return mean of r/s along subsequence index
	return np.mean(r/s)

def plot_reg(xvals, yvals, poly, x_label="x", y_label="y", data_label="data", reg_label="regression line"):
	"""
	Helper function to plot trend lines for line-fitting approaches. This function will
	show a plot through plt.show() and close it after the window has been closed by the user.

	Args:
		xvals (list/array of float): list of x-values
		yvals (list/array of float): list of y-values
		poly (list/array of float): polynomial parameters as accepted by np.polyval
	Kwargs:
		x_label (str): label of the x-axis
		y_label (str): label of the y-axis 
		data_label (str): label of the data
		reg_label(str): label of the regression line
	"""
	plt.plot(xvals, yvals, "bo", label=data_label)
	if not (poly is None):
		plt.plot(xvals, np.polyval(poly, xvals), "r-", label=reg_label)
	plt.xlabel(x_label)
	plt.ylabel(y_label)
	plt.legend(loc="best")
	plt.show()
	plt.close()

def hurst_rs(data, nvals=None, debug_plot=False):
	"""
	Calculates the Hurst exponent by a standard rescaled range (R/S) approach.

	Explanation of Hurst exponent:
		The Hurst exponent is a measure for the "long-term memory" of a time series, meaning
		the long statistical dependencies in the data that do not originate from cycles.

		It originates from H.E. Hursts observations of the problem of long-term storage in
		water reservoirs. If x_i is the discharge of a river in year i and we observe this
		discharge for N years, we can calculate the storage capacity that would be required
		to keep the discharge steady at its mean value.

		To do so, we first substract the mean over all x_i from the individual x_i to obtain
		the departures x'_i from the mean for each year i. As the excess or deficit in 
		discharge always carrys over from year i to year i+1, we need to examine the cumulative
		sum of x'_i, denoted by y_i. This cumulative sum represents the filling of our
		hypothetical storage. If the sum is above 0, we are storing excess discharge from 
		the river, if it is below zero we have compensated a deficit in discharge by releasing
		water from the storage. The range (maximum - minimum) R of y_i therefore represents 
		the total capacity required for the storage.

		Hurst showed that this value follows a steady trend for varying N if it is normalized
		by the standard deviation sigma over the x_i. Namely he obtained the following formula:

		R/sigma = (N/2)^K

		In this equation, K is called the Hurst exponent. Its value is 0.5 for a purely brownian
		motion, but becomes greater for time series that exhibit a bias in one direction.

	Explanation of the algorithm:
		The rescaled range (R/S) approach is directly derived from Hurst's definition. The time
		series of length N is split into non-overlapping subseries of length n. Then, R and S
		(S = sigma) are calculated for each subseries and the mean is taken over all subseries 
		yielding (R/S)_n. This process is repeated for several lengths n. Finally, the exponent
		K is obtained by fitting a straight line to the plot of log((R/S)_n) vs log(n).

		There seems to be no consensus how to chose the subseries lenghts n. This function
		therefore leaves the choice to the user. The module provides some utility functions
		for "typical" values:
			* binary_n: N/2, N/4, N/8, ...
			* logarithmic_n: min_n, min_n * f, min_n * f^2, ...

	References:
		[1] H. E. Hurst, “The problem of long-term storage in reservoirs,” International 
		    Association of Scientific Hydrology. Bulletin, vol. 1, no. 3, pp. 13–27, 1956.
		[2] H. E. Hurst, “A suggested statistical model of some time series which occur in 
		    nature,” Nature, vol. 180, p. 494, 1957.
		[3] R. Weron, “Estimating long-range dependence: finite sample properties and confidence 
		    intervals,” Physica A: Statistical Mechanics and its Applications, vol. 312, no. 1, 
		    pp. 285–299, 2002.

	Args:
		data (array of float): time series
	Kwargs:
		nvals (iterable of int): sizes of subseries to use (default: logarithmic_n(4, 0.1*len(data), 1.2))
		debug_plot (boolean): if True, a simple plot of the final line-fitting step will be shown

	Returns:
		float: estimated Hurst exponent K using a rescaled range approach (if K = 0.5 there are
		       no long-range correlations in the data, if K < 0.5 there are negative long-range
		       correlations, if K > 0.5 there are positive long-range correlations)
	"""
	total_N = len(data)
	if nvals is None:
		nvals = logarithmic_n(4, 0.1*total_N, 1.2)
	# get individual values for (R/S)_n
	rsvals = [rs(data, n) for n in nvals]
	# fit a line to the logarithm of the obtained (R/S)_n
	poly = np.polyfit(np.log(nvals), np.log(rsvals), 1)
	if debug_plot:
		plot_reg(np.log(nvals), np.log(rsvals), poly, "log(n)", "log((R/S)_n)")
	# return line slope
	return poly[0]

rowwise_chebychev = lambda x, y: np.max(np.abs(x - y), axis=1)
rowwise_euler = lambda x, y: np.sqrt(np.sum((x - y)**2, axis=1))

def corr_dim(data, emb_dim, rvals=None, dist=rowwise_euler, debug_plot=False):
	"""
	Calculates the correlation dimension with the Grassberger-Procaccia algorithm

	Explanation of correlation dimension:
		The correlation dimension is a characteristic measure that can be used
		to describe the geometry of chaotic attractors. It is defined using the
		correlation sum C(r) which is the fraction of pairs of points X_i in the
		phase space whose distance is smaller than r.

		If the relation between C(r) and r can be described by the power law

		C(r) ~ r^D

		then D is called the correlation dimension of the system.

	Explanation of the algorithm:
		The Grassberger-Procaccia algorithm calculates C(r) for a range of different
		r and then fits a straight line into the plot of log(C(r)) versus log(r).

		This version of the algorithm is created for one-dimensional (scalar) time
		series. Therefore, before calculating C(r), a delay embedding of the time
		series is performed to yield emb_dim dimensional vectors
		Y_i = [X_i, X_(i+1), X_(i+2), ... X_(i+embd_dim-1)]. Choosing a higher value
		for emb_dim allows to reconstruct higher dimensional dynamics and avoids
		"systematic errors due to corrections to scaling".

	References:
		[1] P. Grassberger and I. Procaccia, “Characterization of strange attractors,” 
		    Physical review letters, vol. 50, no. 5, p. 346, 1983.
		[2] P. Grassberger and I. Procaccia, “Measuring the strangeness of strange 
		    attractors,” Physica D: Nonlinear Phenomena, vol. 9, no. 1, pp. 189–208, 1983.
		[3] http://www.scholarpedia.org/article/Grassberger-Procaccia_algorithm

	Args:
		data (array of float): time series of data points
		emb_dim (int): embedding dimension
	Kwargs:
		rvals (iterable of float): list of values for to use for r 
		                           (default: logarithmic_r(0.1 * std, 0.5 * std, 1.03))
		dist (function (2d-array, 1d-array) -> 1d-array): row-wise difference function
		debug_plot (boolean): if True, a simple plot of the final line-fitting step will
		                      be shown

	Returns:
		correlation dimension as slope of the line fitted to log(r) vs log(C(r))
	"""
	# TODO what are good values for r?
	# TODO do this for multiple values of emb_dim?
	if rvals is None:
		sd = np.std(data)
		rvals = logarithmic_r(0.1 * std, 0.5 * std, 1.03)
	n = len(data)
	orbit = np.array([data[i:i+emb_dim] for i in range(n - emb_dim + 1)])
	dists = np.array([dist(orbit, orbit[i]) for i in range(len(orbit))])
	csums = []
	for r in rvals:
		s = 1.0 / (n * (n-1)) * np.sum(dists < r)
		csums.append(s)
	csums = np.array(csums)
	poly = np.polyfit(np.log(rvals), np.log(csums), 1)
	if debug_plot:
		plot_reg(np.log(rvals), np.log(csums), poly, "log(r)", "log(C(r))")
	return poly[0]

def dfa(data, nvals= None, overlap=True, order=1, debug_plot=True):
	"""
	Performs a detrended fluctuation analysis (DFA) on the given data

	Recommendations for parameter settings by Hardstone et al.:
		* nvals should be equally spaced on a logarithmic scale so that each window
		  scale hase the same weight
		* min(nvals) < 4 does not make much sense as fitting a polynomial (even if it
		  is only of order 1) to 3 or less data points is very prone.
		* max(nvals) > len(data) / 10 does not make much sense as we will then have
		  less than 10 windows to calculate the average fluctuation 
		* use overlap=True to obtain more windows and therefore better statistics
		  (at an increased computational cost)

	Explanation of DFA:
		Detrended fluctuation analysis, much like the Hurst exponent, is used to find
		long-term statistical dependencies in time series.

		The idea behind DFA originates from the definition of self-affine processes.
		A process X is said to be self-affine if the standard deviation of the values
		within a window of length n changes with the window length factor L in a power
		law:

		std(X,L * n) = L^H * std(X, n)

		where std(X, k) is the standard deviation of the process X calculated over
		windows of size k. In this equation, H is called the Hurst parameter, which
		behaves indeed very similar to the Hurst exponent.

		Like the Hurst exponent, H can be obtained from a time series by calculating
		std(X,n) for different n and fitting a straight line to the plot of log(std(X,n)) 
		versus log(n).

		To calculate a single std(X,n), the time series is split into windows of
		equal length n, so that the ith window of this size has the form

		W_(n,i) = [x_i, x_(i+1), x_(i+2), ... x_(i+n-1)]

		The value std(X,n) is then obtained by calculating std(W_(n,i)) for each i
		and averaging the obtained values over i.

		The aforementioned definition of self-affinity, however, assumes that the 
		process is  non-stationary (i.e. that the standard deviation changes over 
		time) and it is highly influenced by local and global trends of the time 
		series.

		To overcome these problems, an estimate alpha of H is calculated by using a 
		"walk" or "signal profile" instead of the raw time series. This walk is 
		obtained by substracting the mean and then taking the cumulative sum of the 
		original time series. The local trends are removed for each window separately 
		by fitting a polynomial p_(n,i) to the window W_(n,i) and then calculating 
		W'_(n,i) = W_(n,i) - p_(n,i) (element-wise substraction).

		We then calculate std(X,n) as before only using the "detrended" window 
		W'_(n,i) instead of W_(n,i). Instead of H we obtain the parameter alpha
		from the line fitting.

		For alpha < 1 the underlying process is stationary and can be modelled as
		fractional Gaussian noise with H = alpha. This means for alpha = 0.5 we have
		no correlation or "memory", for 0.5 < alpha < 1 we have a memory with positive
		correlation and for alpha < 0.5 the correlation is negative.

		For alpha > 1 the underlying process is non-stationary and can be modeled
		as fractional Brownian motion with H = alpha - 1.

	References:
		[1] C.-K. Peng, S. V. Buldyrev, S. Havlin, M. Simons, H. E. Stanley, and 
		    A. L. Goldberger, “Mosaic organization of DNA nucleotides,” Physical 
		    Review E, vol. 49, no. 2, 1994.
		[2] R. Hardstone, S.-S. Poil, G. Schiavone, R. Jansen, V. V. Nikulin, 
		    H. D. Mansvelder, and K. Linkenkaer-Hansen, “Detrended fluctuation 
		    analysis: A scale-free view on neuronal oscillations,” Frontiers in 
		    Physiology, vol. 30, 2012.

	Args:
		data (array of float): time series
	Kwargs:
		nvals (iterable of int): subseries sizes at which to calculate fluctuation
		                         (default: logarithmic_n(4, 0.1*len(data), 1.2))
		overlap (boolean): if True, the windows W_(n,i) will have a 50% overlap, 
		                   otherwise non-overlapping windows will be used
		order (int): (polynomial) order of trend to remove
		debug_plot (boolean): if True, a simple plot of the final line-fitting step will
		                      be shown
	Returns:
		float: the estimate alpha for the Hurst parameter (alpha < 1: stationary
		       process similar to fractional Gaussian noise with H = alpha, 
		       alpha > 1: non-stationary process similar to fractional brownian
		       motion with H = alpha - 1)
	"""
	total_N = len(data)
	if nvals is None:
		nvals = logarithmic_n(4, 0.1*total_N, 1.2)
	# create the signal profile (cumulative sum of deviations from the mean => "walk")
	walk = np.cumsum(data - np.mean(data))
	fluctuations = []
	for n in nvals:
		# subdivide data into chunks of size n
		if overlap:
			# step size n/2 instead of n
			d = np.array([walk[i:i+n] for i in range(0,len(walk)-n,n//2)])
		else:
			# non-overlapping windows => we can simply do a reshape
			d = walk[:total_N-(total_N % n)]
			d = d.reshape((total_N//n, n))
		# calculate local trends as polynomes
		x = np.arange(n)
		tpoly = np.array([np.polyfit(x, d[i], order) for i in range(len(d))])
		trend = np.array([np.polyval(tpoly[i], x) for i in range(len(d))])
		# calculate standard deviation ("fluctuation") of walks in d around trend
		flucs = np.sqrt(np.sum((d - trend) ** 2, axis=1) / n)
		# calculate mean fluctuation over all subsequences
		f_n = np.sum(flucs) / len(flucs)
		fluctuations.append(f_n)
	fluctuations = np.array(fluctuations)
	poly = np.polyfit(np.log(nvals), np.log(fluctuations), 1)
	if debug_plot:
		plot_reg(np.log(nvals), np.log(fluctuations), poly, "log(n)", "std(X,n)")
	return poly[0]

def test_lyap():
	rvalues = np.arange(2, 4, 0.01)
	lambdas = []
	lambdas_est = []
	lambdas_est2 = []
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
		le = lyap_e(np.array(full_data), emb_dim=6, matrix_dim=2)
		#print(full_data)
		#print(le)
		lambdas_est.append(np.max(le))
		lambdas_est2.append(lyap_r(np.array(full_data), emb_dim=6))
	#print(lambdas_est)
	print(lambdas_est2)
	plt.plot(rvalues, lambdas, "b-")
	plt.plot(rvalues, lambdas_est, color="#00AAAA")
	plt.plot(rvalues, lambdas_est2, color="#AA00AA")
	plt.plot(rvalues, np.zeros(len(rvalues)), "g--")
	xvals = np.repeat(rvalues, 20)
	plt.plot(xvals, maps, "ro", alpha=0.1)
	plt.ylim((-2,2))
	plt.show()

def test_lyap2():
	#test_lyap()
	data = [1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5,1,2,4,5,6,6,1,5]
	data = np.random.random((100,)) * 10
	data = np.concatenate([np.arange(100)] * 3)
	# TODO random numbers should give positive exponents, what is happening here?
	l = lyap_e(np.array(data), emb_dim=7, matrix_dim=3)
	print(l)

def test_hurst():
	# TODO why does this not work for the brownian motion?
	n = 10000
	data = np.arange(n) # should give result 1
	#data = np.cumsum(np.random.randn(n)) # brownian motion, should give result 0.5
	#data = np.random.randn(n) # should give result 0
	data = np.sin(np.arange(n,dtype=float) / (n-1) * np.pi * 100)
	print(hurst_rs(data, debug_plot=True))

def test_corr():
	n = 1000
	data = np.arange(n)
	print(corr_dim(data, 4))

def test_dfa():
	n = 10000
	data = np.arange(n)
	data = np.random.randn(n)
	data = np.cumsum(data)
	plt.plot(data)
	plt.show()
	print(dfa(data))

def test_logarithmic_n():
	print(binary_n(1000))
	print(logarithmic_n(4,100,1.1))
	x = logarithmic_n(4,100,1.1)
	x = np.log(list(x))
	plt.plot(x,np.arange(len(x)))
	plt.show()

def test_delay_embed():
	data = np.arange(57)
	print(delay_embedding(data,4,lag=2))

if __name__ == "__main__":
	test_dfa()

	

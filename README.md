# Modelica implementation of the Seidel-Herzel model of the human baroreflex

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3855126.svg)](https://doi.org/10.5281/zenodo.3855126)

This project contains a Modelica implementation of the model of the human baroreflex developed by H. Seidel in his PhD thesis under the supervision of H. Herzel [\[1\]](#ref1).
We published and presented this implementation at the 2015 International Modelica Conference [\[2\]](#ref2).

Preliminary versions of the model have been published as book chapter [\[3\]](#ref3) and journal paper [\[4\]](#ref4) and the latter has been extended with additional noise terms by K. Kotani et al. in two journal papers [\[5](#ref5)[, 6\]](#ref6).
From a conversation with H. Seidel we learned that although the journal paper [\[4\]](#ref4) was published in 1998, the thesis from 1997 [\[1\]](#ref1) actually describes the most recent version of the model which has several improvements over the journal version.
We therefore chose to use the thesis as the basis for our implementation.

## Installation and Simulation

To run simulations with the model developed in this project you need [OpenModelica](https://openmodelica.org/), which is available for Microsoft Windows, Linux and MacOS.

Once you have installed OpenModelica, you can run simulations with the model as follows:

1. Clone this repository with Git or download a [ZIP file of the current master branch](https://github.com/CSchoel/shm/archive/master.zip) and extract it with an archive manager of your choice.
2. Start OMEdit and open the folder `SHMConduction` with "File" → "Load Library".
3. Open the example of your choice (e.g. `SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample`) with a double click and simulate it by clicking the simulate button and adjusting simulation parameters as desired.

Some of the scripts and tests have additional dependencies, which are listed in the following.

### Test suite

The test suite in `tests/python/test.py` needs [Python 3](https://www.python.org/) with the following packages:

* `numpy` for basic vectorized scientific computing
* `matplotlib` for plotting
* `scipy` for interpolation of data
* `OMPython` for interfacing with the OpenModelica compiler
* `DyMat` for reading result files in MATLAB format
* `nolds` for nonlinear measures of HRV


### Extraction and analysis of PhysioNet data

The functions to extract and analyse PhysioNet data in `tests/python/extract_hrv.py` and `test/python/human_hrv.py` also require [Python 3](https://www.python.org/) with the following packages:

* `numpy` for basic vectorized scientific computing
* `matplotlib` for plotting
* `scipy` for statistical functions
* `nolds` for nonlinear measures of HRV

**NOTE:** Currently the functions cannot be used without manual changes because they contain absolute references to the downloaded PhysioNet files on my hard drive.

### Simulation scripts and plots

The scripts in the folder `scripts` are a wild mix of Modelica-,  R-, Ruby-, and Python-scripts for simulating and plotting the models in this repository.
They are not required to work with the model and should probably only be used to reproduce the plots in [\[2\]](#ref2). The requirements are as follows:

* `.mos` files require OpenModelica and can be run in OMShell with the function `runScript("nameOfFile.mos")`.
* `.py` files require [Python 3](https://www.python.org/) with the packages `numpy`, `pandas` and `matplotlib`.
* `.R` files require [R](https://www.r-project.org/) with the packages `stats`, `plotrix`, `ggplot2`, `pracma` and `tseriesChaos`.
* `.rb` files require [Ruby](https://www.ruby-lang.org/en/) with the package `rexml`.

The plots for Figure 2-4 of [\[2\]](#ref2) are produced by `plotCompare.R` which needs the following data files in the working directory:
  * `SHM_full_1000_res.csv` and `heartbeats.csv` which are created by running `simulateSeidelThesis.mos` in OMShell (for further instructions see comments in this `.mos` file)
  * `DeepThought1000.out` and `DeepThought1000.out_per` which are provided in the folder `refData`

## Project structure

### Subprojects

This project has grown considerably since its first commit in January 2014 and has branched into two subprojects that are now kept and documented in separate repositories:

* The nonlinear measures for dynamical systems used to test the physiological plausibility of the model output now reside in the [python package nolds](https://github.com/CSchoel/nolds).
* A modular implementation of the cardiac conduction system that is part of the Seidel-Herzel model (SHM) now resides in the GitHub project [shm-conduction](https://github.com/CSchoel/shm-conduction) and is included in this project as a git submodule.
    To download it you can use the command `git submodule update --init`.

### Files and folders in this repository

* `SHM` contains the Modelica code for all versions of the model
  * `SHM/Kotani2005` contains the implementation according to [\[6\]](#ref6) (without noise)
  * `SHM/SeidelThesis` contains the implementation according to [\[1\]](#ref1) (again without noise)
  * `SHM/SchoelzelThesis` contains extensions to the `SeidelThesis` models
  * `SHM/SH1998` is planned to contain an implementation according to [\[4\]](#ref4) but is currently empty
  * `SHM/Shared` contains base classes and utility components that are shared between the different implementations
  * Each of `Kotani2005`, `SeidelThesis`. `SchoelzelThesis` and `SH1998` can contain the following subfolders:
    * `Components` contains individual components as modular building blocks for models
    * `Examples` contains full models that can be simulated
    * `Functions` contains function definitions
    * `Connectors` contains connectors that are used to connect components
* `img` contains icons as scalable vector graphics (SVG) files. These have been translated to Modelica with an (currently unpublished) export script for the vector graphics editor [Inkscape](https://inkscape.org/).
    The translated versions can be found as `annotation()` statements in the Modelica code.
* `scripts` contains various scripts and utility functions
  * `deploy.bat` and `deploy.sh` are small scripts to copy the model files to a "deploy" folder so that they can be opened with OMEdit without OMEdit mangling the original sources on an accidental save command.
  * `genSeidelPerfScript.rb` was used to generate the scripts `simulateSeidelThesis_perf_gen.mos` and `simulateSeidelThesis_perf_nobroad.mos` which contain performance test of the baroreceptor broadening function.
    This is a workaround for the non-functioning script `simulateSeidelThesis_perf.mos`.
  * `plotCompare.R` creates plots that compare the C implementation of Seidel against our Modelica version.
  * `plotKotani.R` creates plots that compare our Modelica version against a Java implementation that was developed as part of an (unpublished) Master's thesis at our lab.
  * `plotSingle.R` makes plots from a single dataset (C, Java or Modelica implementation)
  * `print_parameters.rb` used to extract parameters from Modelica-generated XML file
  * `setWd.R` small helper script to set the working directory to the output directory
  * `simulateKotani.mos` and `simulateSeidelThesis.mos` are scripts to run simulations of the full models in `Kotani2005` and `SeidelThesis` respectively.
  * `testHurst.R` and `testLyap.R` are small test scripts to compare the implementation of nonlinear measures in `nolds` against established R packages
* `refData` contains simulation results of the C implementation by H. Seidel
* `subprojects` contains projects that are related to this project but have evolved enough to be hosted as standalone repositories
  * `shm-conduction` contains a modular version of the cardiac conduction system of the SHM
* `tests/python` contains Python code to test the physiological plausibility of the model with regard to actual HRV parameters
  * `test.py` and `ompython_helper.py` build a test suite that uses the Python interface of OpenModelica
  * `extract_hrv.py` and `human_hrv.py` provide functions to create a database of healthy human HRV data from sources that can be downloaded from PyhsioNet

## Running tests

To run the test suite in `tests/python` change your working directory to this folder and from there run `python test.py`.
This will generate a folder called `test-output` that contains plots and data generated by the tests.
The tests should be mostly seen as regression tests that ensure that a change in the code will not change the simulation output in a significant way.
Although the tests use physiological measures and are designed to ultimately make the individual variables of the model more physiologically plausible, the values used for the test are by no means plausible.
This is mostly due to the fact that the model is missing any noise term in the current state, which of course has a substantial effect on any statistical tests.

## Comparison with data of human patients

Unfortunately, the experiments with data from healthy human subjects in `tests/python` are currently referencing already downloaded datasets from PhysioNet.
However, you should be able to perform the tests if you download the following datasets and change the paths in the scripts accordingly:

* [Fantasia database](https://physionet.org/content/fantasia/1.0.0/)
* [PTB Diagnostic ECG Database](https://physionet.org/content/ptbdb/1.0.0/)
* [MIT-BIH Normal Sinus Rhythm Database](https://www.physionet.org/content/nsrdb/1.0.0/)
* [Normal Sinus Rhythm RR Interval Database](https://physionet.org/content/nsr2db/1.0.0/)
* [Physiological Response to CHanges in Posture](https://physionet.org/content/prcp/1.0.0/)

With these databases the script `extract_hrv.py` creates a single uniformly formatted aggregated database which then can be used for analysis with the script `human_hrv.py`.
This analysis includes the following tasks:

* Create poincare plots, smoothed histograms, Q-Q plots, and CDF plots for all datasets.
* Filter datasets by SD1 and number of extrema in histogram in order to only keep datasets that are truly "normal" w.r.t. these parameters.
* Compute linear and nonlinear measures of HRV and output means or draw a comparison between the selected and excluded datasets.

## References

<a name="ref1">[1]</a> H. Seidel, “Nonlinear dynamics of physiological rhythms,” PhD thesis, Technische Universität Berlin, Berlin, Germany, 1997.

<a name="ref2">[2]</a> C. Schölzel, A. Goesmann, G. Ernst, and A. Dominik, “Modeling biology in Modelica: The human baroreflex,” in Proceedings of the 11th International Modelica Conference, Versailles, France, 2015, pp. 367–376, doi: [10.3384/ecp15118367](https://www.ep.liu.se/ecp/article.asp?issue=118%26article=39).

<a name="ref3">[3]</a> H. Seidel and H. Herzel, “Modelling heart rate variability due to respiration and baroreflex,” in Modelling the Dynamics of Biological Systems, E. Mosekilde and O. G. Mouritsen, Eds. Berlin, Heidelberg: Springer, 1995, pp. 205–229, doi: [10.1007/978-3-642-79290-8_11](https://doi.org/10.1007/978-3-642-79290-8_11).

<a name="ref4">[4]</a> H. Seidel and H. Herzel, “Bifurcations in a nonlinear model of the baroreceptor-cardiac reflex,” Physica D: Nonlinear Phenomena, vol. 115, no. 1–2, pp. 145–160, 1998, doi: [10.1016/S0167-2789(97)00229-7](https://doi.org/10.1016/S0167-2789%2897%2900229-7).

<a name="ref5">[5]</a> K. Kotani, K. Takamasu, Y. Ashkenazy, H. Stanley, and Y. Yamamoto, “Model for cardiorespiratory synchronization in humans,” Physical Review E, vol. 65, no. 5, p. 051923, 2002, doi: [10.1103/PhysRevE.65.051923](https://doi.org/10.1103/PhysRevE.65.051923).

<a name="ref6">[6]</a> K. Kotani, Z. Struzik, K. Takamasu, H. Stanley, and Y. Yamamoto, “Model for complex heart rate dynamics in health and diseases,” Physical Review E, vol. 72, no. 4, p. 041904, 2005, doi: [10.1103/PhysRevE.72.041904](https://doi.org/10.1103/PhysRevE.72.041904).

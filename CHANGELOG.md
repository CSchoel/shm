# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- nothing

### Changed

- nothing

### Fixed

- nothing

## [1.4]

### Added

- reference data from simulation of Seidel's original C code
- CHANGELOG and README files

### Changed

- removed unused scripts `fftTest.R`, `compareFrequencies.R`
- deploy script now does not remove whole deploy folder but only subfolders
- script to plot modular contraction examples is moved to subproject
- updates test script to use Python 3 with OMCSessionZMQ
- `test-output` folder is now create inside the repo instead of outside

### Fixed

- updates `.mos` scripts and Python test suite to current OpenModelica version and code structure

## [1.3]

### Added

- modular version of the contraction (or more aptly termed *conduction*) model with extension for premature ventricular contractions (PVCs)
  - implementation began in this repository, but model is now included as submodule with [a separate repository](https://github.com/CSchoel/shm-conduction)

### Changed

- some small simplifications for `Contraction2`

### Fixed

- `Contraction2` needed to use `pre()` in the equation for the variable `signal`, the model now compiles without errors
- `sinus_contraction` in `Contraction2` should only be true if there was a "fresh" sinus signal

## [1.2]

### Added

- extensive test suite with all HRV measures suggested by the Task Force of ESC and NASPE 1996
  - nonlinear measures were implemented in this repository, but are now available as separate [python package named nolds](https://github.com/CSchoel/nolds)
- scripts to obtain and analyze human reference data from PhysioNet
- model `Contraction2` that is more descriptive than previous contraction model (but does not compile currently)

### Changed

- nothing

### Fixed

- nothing

## [1.1]

### Added

- file output for heartbeat intervals to contraction model
- performance test for broadening function

### Changed

- makes plots more comprehensive and adds FFT-comparison
- improves documentation

### Fixed

- nothing

## [1.0]

### Added

- additional components and equations from Seidel's PhD thesis from 1997 (which actually contains a more recent version of the model than the journal paper from 1998)
  - adds saturation term to baroreceptor activity
  - folds baroreceptor activity with Green's function to simulate that baroreceptors are spatially distributed and therefore receive information at different times
  - adds saturation term to rate of Norepinephrine concentrations
  - adds Norepinephrine concentration in resistance vessels
  - models Acetylcholine concentration kinetics at sinus node instead of directly using parasympathetic signal
  - corrects sign error in formula for phase effectiveness curve
  - adds refractory time of ventricles and spontaneous action potential of AV node
  - adds mechanical respiratory influence on contractility
  - uses different saturation function for contractility
  - adds threshold term p0 for diastolic blood pressure
  - changes formula for respiratory phase
  - adds noise to heart beat period and respiratory cycle duration (not implemented)
- documentation for sympathetic system and parasympathetic system
- simulations are now identical to Seidel's implementation in C

### Changed

- complete change of folder/package structure to distinguish between `Kotani2005` and `SeidelThesis` branch of model

### Fixed

- equation in LinearNerveSignal did not inclue `topval`
- fuses double annotation declarations that were accidentally introduced to some models in Kotani2005
- DiscreteSignal should produce a `Boolean` value

## [0.6]

### Added

- initialization parameters for all components
- vector graphic icons for all components

### Changed

- nothing

### Fixed

- bug that lead to overdetermined initial conditions with new initialPressure parameter of BloodSystem
- LinearNerveSignal should only be determined via rate in order to allow initial value for NerveSystem activity
- uses `der(artery.pressure)` instead of `artery.rate` in Baroreceptor

## [0.5]

### Added

- full implementation of all model components present in Kotani 2005 without noise and without initialization parameters

### Changed

- nothing

### Fixed

- nothing

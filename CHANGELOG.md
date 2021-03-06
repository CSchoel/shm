# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

nothing

### Changed

nothing

### Fixed

nothing

## [1.7.0] - 2021-06-24

### Added

- optional noise terms for `SeidelThesis` model (affects `SinusNode` and `Lung` components)
- small script to compare reference and current plots
- support for OpenModelica 1.15-1.17 through ModelicaScriptingTools version 1.1.0
- README now contains information how to get `*_ann.txt` files required for the script `extract_hrv.py`
- `ScheduleInput` and `ScheduleOutput` connectors for `OriginalSHM` version of cardiac conduction model
- component tests in `SchoelzelThesis` are now part of the unit test suite and have reference data
- releases now include a FMU of `SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample`

### Changed

- changed default branch from `master` to `main`
- version numbering now also includes patch part
- former parameter `T_r` in `SeidelThesis.Components.Lung` is now a variable => some other parts of the code needed to use the new parameter `T_r0` instead
- simplified sinus node output
- escapes dots in variable filter used in `simulateSeidelThesis.mos`
- switched from Travis CI to GitHub Actions
- removed some alias variables from reference data
- unit tests now use nested test sets to better identify which model test failed
- updated component tests in `SchoelzelThesis`
- removed `use_single` parameter in `MultiDelayExample` in `SchoelzelThesis`

### Fixed

- some small bugs in `plotCompare.R`
- explicitly loads correct version of MSL in unit test script
- incorrect use of `redeclare` in `SHM.Kotani2005.Components.NeurotransmitterRelease`
- `t_next` in `SHM.SchoelzelThesis.Components.Contraction.Unidirectional.ManualDelay.MultiCD` needs to be public, because it is accessed in `ReferenceTimeDependendAVCD`
- incorrect use of `discrete` variables in `SchoelzelThesis` (must only be set in `when` equations)
- removed `partial` keyword from `MultiCD` and `SingleCD` in `SchoelzelThesis`
- moved `change(buffer[1])` event out of algorithm section in `MultiCD` in `SchoelzelThesis`
- adds start value for `discrete_outp`, removes start value for `continuous_outp`, and adds missing `pre()` in `SHM.SchoelzelThesis.Contraction.Unidirectional.BuiltinDelay.ConductionDelay`
- some models in `SchoelzelThesis` used `connect()` equations with items that are no connectors, these were replaced with normal equations using equals signs
- resets `t_next` to zero on signal collisions in `SHM.SchoelzelThesis.Components.Contraction.Bidirectional.ConductionDelay`
- the variables `tick` in `PacemakerMixin`and `refrac_signal` in `RefractoryPacemaker` need to be public within the `BidirectionalMixin` example in `SchoelzelThesis`
- due to a bug in OpenModelica, `refrac` and `pace` in the `RefractoryPacemaker` of the `BidirectionalMixin` package in `SchoelzelThesis` cannot be `replaceable`


## [1.6] - 2020-10-20

### Added

- subproject `shm-ref` that contains reference data from simulating the SHM
- Julia unit tests now also perform regression tests using data from `shm-ref`

### Changed

- models covered by unit tests now also have a MoST.jl variable filter annotation

### Fixed

- nothing

## [1.5] - 2020-10-20

### Added

- code by V. Blesius in `BlesiusThesis` that integrates `SHMConduction` and `SeidelThesis` in the hope of generating plausible HRT responses
- smylink `SHMConduction` that links to `subprojects/shm-conduction/SHMConduction`
- adds class from `SHMConduction` to `AVDelayExample` in `SchoelzelThesis` to test that the subproject can be simulated together with the main project
- unit test script using MoST.jl
- Travis CI script that calls Julia and Python unit tests
- experiment annotations for full model examples

### Changed

- adjusts Python unit tests to work with newer version of nolds
  - uses `fit="poly"` for `hurst_rs` call in Python unit tests
  - adjusts tolerance for RMSE of frequency domain to `1e-5` instead of `1e-6`
- adds newlines in printing of unit tests

### Fixed

- copy-paste error in readme: `SHM` is the main package, not `SHMConduction`
- `package.order` files now contain all classes and no extra classes
- parameters having modifiers for `start` value now instead have proper default values
- adds missing `start` and `fixed` values for variables in `SHMConduction` (not entirely sure why this is needed at some points)

### Removed

- old classes `AVConductionDelay` and `ModularConduction` in `SeidelThesis`, which have now been superseded by the models in `SchoelzelThesis` and `SHMConduction`

## [1.4] - 2020-05-26

### Added

- reference data from simulation of Seidel's original C code
- CHANGELOG, README, and LICENSE files

### Changed

- removed unused scripts `fftTest.R`, `compareFrequencies.R`
- deploy script now does not remove whole deploy folder but only subfolders
- script to plot modular contraction examples is moved to subproject
- updates test script to use Python 3 with OMCSessionZMQ
- `test-output` folder is now create inside the repo instead of outside

### Fixed

- updates `.mos` scripts and Python test suite to current OpenModelica version and code structure

## [1.3] - 2020-05-25

### Added

- modular version of the contraction (or more aptly termed *conduction*) model with extension for premature ventricular contractions (PVCs)
  - implementation began in this repository, but model is now included as submodule with [a separate repository](https://github.com/CSchoel/shm-conduction)

### Changed

- some small simplifications for `Contraction2`

### Fixed

- `Contraction2` needed to use `pre()` in the equation for the variable `signal`, the model now compiles without errors
- `sinus_contraction` in `Contraction2` should only be true if there was a "fresh" sinus signal

## [1.2] - 2016-08-03

### Added

- extensive test suite with all HRV measures suggested by the Task Force of ESC and NASPE 1996
  - nonlinear measures were implemented in this repository, but are now available as separate [python package named nolds](https://github.com/CSchoel/nolds)
- scripts to obtain and analyze human reference data from PhysioNet
- model `Contraction2` that is more descriptive than previous contraction model (but does not compile currently)

### Changed

- nothing

### Fixed

- nothing

## [1.1] - 2015-07-29

### Added

- file output for heartbeat intervals to contraction model
- performance test for broadening function

### Changed

- makes plots more comprehensive and adds FFT-comparison
- improves documentation

### Fixed

- nothing

## [1.0] - 2015-04-22

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

## [0.6] - 2014-12-06

### Added

- initialization parameters for all components
- vector graphic icons for all components

### Changed

- nothing

### Fixed

- bug that lead to overdetermined initial conditions with new initialPressure parameter of BloodSystem
- LinearNerveSignal should only be determined via rate in order to allow initial value for NerveSystem activity
- uses `der(artery.pressure)` instead of `artery.rate` in Baroreceptor

## [0.5] - 2014-07-04

### Added

- full implementation of all model components present in Kotani 2005 without noise and without initialization parameters

### Changed

- nothing

### Fixed

- nothing


[Unreleased]: https://github.com/CSchoel/shm/compare/v1.7.0..HEAD
[1.7.0]: https://github.com/CSchoel/shm/compare/1.6..v1.7.0
[1.6]: https://github.com/CSchoel/shm/compare/1.5..1.6
[1.5]: https://github.com/CSchoel/shm/compare/1.4..1.5
[1.4]: https://github.com/CSchoel/shm/compare/1.3..1.4
[1.3]: https://github.com/CSchoel/shm/compare/1.2..1.3
[1.2]: https://github.com/CSchoel/shm/compare/1.1..1.2
[1.1]: https://github.com/CSchoel/shm/compare/1.0..1.1
[1.0]: https://github.com/CSchoel/shm/compare/0.6..1.0
[0.6]: https://github.com/CSchoel/shm/compare/0.5..0.6
[0.5]: https://github.com/CSchoel/shm/releases/tag/0.5

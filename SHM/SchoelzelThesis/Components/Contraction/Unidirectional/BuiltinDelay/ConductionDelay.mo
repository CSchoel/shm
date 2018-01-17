within SHM.SchoelzelThesis.Components.Contraction.Unidirectional.BuiltinDelay;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
protected
  // We need to convert the discrete input into a continuous signal
  // to be able to delay it. Also we need to transform the dirac
  // impulses of the input to something that survives the discretization
  // and interpolation that is applied to delay-expressions.
  // An alternating step function is the easiest choice for this.
  Real continuous_inp(start=0) "auxiliary variable";
  Real continuous_outp(start=0);
  Boolean discrete_outp;
equation
  der(continuous_inp) = 0;
  when inp then
    reinit(continuous_inp, 1.0 - continuous_inp);
  end when;
  discrete_outp = continuous_outp > 0.5;
  outp = change(discrete_outp);
end ConductionDelay;

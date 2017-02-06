within SHM.Shared.Components.Test;
model DiracToSawtooth "small helper model to make discrete
  dirac impulses visible"
  SHM.Shared.Connectors.ExcitationInput dirac;
  parameter Real slope = -1;
  parameter Real start = 1;
  Real sawtooth;
equation
  der(sawtooth) = slope;
  when dirac then
    reinit(sawtooth, start);
  end when;
end DiracToSawtooth;

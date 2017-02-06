within SHM.SchoelzelThesis.Components.Contraction.Bidirectional;
model ConstantConductionDelay
  extends SHM.SchoelzelThesis.Components.Contraction.Bidirectional.
          ConductionDelay;
  parameter Real duration_constant = 1;
equation
  duration = duration_constant;
end ConstantConductionDelay;

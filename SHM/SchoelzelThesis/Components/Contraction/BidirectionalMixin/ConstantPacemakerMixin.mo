within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model ConstantPacemakerMixin
  extends SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin.
          PacemakerMixin;
  parameter Real T = 1;
equation
  der(phase) = T;
end ConstantPacemakerMixin;

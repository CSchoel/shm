within SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin;
model ConstantRefractoryMixin
  extends SHM.SchoelzelThesis.Components.Contraction.BidirectionalMixin.
          RefractoryMixin;
  parameter Real duration = 1;
equation
  T_refrac = duration;
end ConstantRefractoryMixin;

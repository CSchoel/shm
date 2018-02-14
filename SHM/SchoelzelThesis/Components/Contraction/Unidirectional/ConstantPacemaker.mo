within SHM.SchoelzelThesis.Components.Contraction.Unidirectional;
model ConstantPacemaker "pacemaker that generates signals at a regular frequency"
  extends SHM.SchoelzelThesis.Components.Contraction.Unidirectional.Pacemaker;
  parameter Real T = 1 "period between two generated signals";
equation
  der(phase) = 1/T;
  annotation(Documentation(info="<html>
    <p>Represents a pacemaker component with a constant cycle duration.</p>
    <p>This component will let all signals pass and additonally create
    a signal every T seconds.</p>
  </html>"));
end ConstantPacemaker;

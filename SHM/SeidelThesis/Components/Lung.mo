within SHM.SeidelThesis.Components;
model Lung "Lung model with simple sinus signal"
  parameter Real T_r = 4 "respiratory period";
  parameter Real r_start = 0 "respiratory phase shift in seconds";
  SHM.Shared.Connectors.NerveOutput signal "generated nerve signal";
  Real phi_r(start = r_start/T_r) "internal respiratory phase";
equation
  der(phi_r) = 1/T_r;
  when phi_r > 1 then
    reinit(phi_r,0);
  end when;
  signal.activation = 0.5 * (1 - sin(2*Modelica.Constants.pi*phi_r));
annotation(Documentation(info="<html>
  <p>Models the activity of the respiratory neurons as a simple sinus function with values between 0 and 1.</p>
</html>"));
end Lung;
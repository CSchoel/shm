within SHM.SeidelThesis.Components;
model SubstanceRelease "release of a hormone or neurotransmitter"
  parameter Real tau = 4 "time until concentration drops to zero without any nervous signal";
  parameter Real k_ex = 0.014 "scaling factor for excitatory influence";
  parameter Real k_in = 0.006 "scaling factor for inhibitory influence";
  parameter Real delay_ex = 2 "time until excitatory signal triggers substance release";
  parameter Real delay_in = 0.4 "time until inhibitory signal is recognized";
  parameter Boolean with_inhibition = true "if true, this model has excitatory *and* inhibitory influence, otherwise it just has excitatory influence";
  SHM.Shared.Connectors.NerveInput excitation "excitatory nerve input" annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.NerveInput inhibition(activation = inhibition_signal) if with_inhibition "inhibitory nerve input" annotation(Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SHM.Shared.Connectors.SubstanceConcentration con "concentration that is influenced by this component" annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real inhibition_signal "inhibitory signal"; //needed because conditionally defined variables can only occur in definition
protected
  Real factor "helper variable to enable switching inhibitory signal on or off";
equation
  if not with_inhibition then
    inhibition_signal = 0;
  end if;
  //negative sign needed because con.rate is a flow variable
  - tau * con.rate = - con.concentration + tanh(k_ex * delay(excitation.activation,delay_ex,delay_ex)) * factor;
  if with_inhibition then
    factor = (1 - tanh(k_in * delay(inhibition_signal,delay_in,delay_in)));
  else
    factor = 1;
  end if;
annotation(Documentation(info="<html>
  <p>Models the release of a transmitter substance. The release is triggered by an excitatory neural signal and can be inhibited by an inhibitory signal.</p>
</html>"));
end SubstanceRelease;
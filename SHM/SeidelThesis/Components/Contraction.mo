within SHM.SeidelThesis.Components;
model Contraction "contraction model for the heart"
  parameter Real T_refrac = 0.9 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Real T_av = 1.7 "av-node cycle duration";
  parameter Real initial_T = 1 "initial value for T";
  parameter Real initial_t_last = 0 "initial value for last ventricular contraction time";
  parameter Real k_av_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Real T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Real tau_av = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  discrete Real t_last "time of last contraction";
  discrete Real T_avc "atrioventricular conduction time (delay for sinus signal to trigger contraction)";
  input Boolean signal "the sinus signal";
  output Boolean contraction "true when a contraction is triggered";
  output Boolean av_contraction "true when the av-node triggers a contraction";
  output Boolean sinus_contraction "true when the sinus node triggers a contraction";
  discrete output Real T "duration of last heart cycle";
  Real T_passed "helper variable; time passed since last contraction";
  Real av_phase "helper variable; phase for av-node (contraction is triggered when this reaches 1)";
  Real sinus_phase "helper variable; phase for sinus node (contraction is triggered when this reaches 1)";
  Real refrac_countdown "helper variable; countdown for refractory period; if <= 0 then refractory period has passed";
initial equation
  t_last = initial_t_last;
  refrac_countdown = 0;
  sinus_phase = 0;
  av_phase = 0;
  T = initial_T;
  T_avc = 0;
equation
  der(av_phase) = 1/T_av "av_phase has constant slope";
  der(refrac_countdown) = if refrac_countdown > 0 then -1/T_refrac else 0 "refrac_countdown just counts down to <= 0";
  der(sinus_phase) = if T_avc > 0 then 1/T_avc else 0 "sinus_phase has variable slope 1/T_avc";
  contraction = av_contraction or sinus_contraction "contraction can come from av-node or sinus node";
  av_contraction = av_phase >= 1 "av-node contracts when av_phase reaches 1";
  sinus_contraction = sinus_phase >= 1 "sinus node contracts when sinus_phase reaches 1";
  T_passed = time - t_last;
  when signal and refrac_countdown <= 0 then //sinus signal is recognized
    if pre(T_avc) > 0 then
      T_avc = pre(T_avc) "a sinus signal is already on the way, so we do not touch the conduction time";
    else
      T_avc = T_avc0 + k_av_t * exp(-T_passed/tau_av) "'enables' sinus_phase which will trigger contraction if it reaches 1 faster than av_phase";
    end if;
  elsewhen contraction then
    T_avc = 0 "'disables' sinus_phase after contraction until new sinus signal is received";
  end when;
  when contraction then
    T = time-pre(t_last);
    t_last = time "record timestamp of contraction";
    reinit(av_phase,0) "reset av_phase";
    reinit(sinus_phase,0) "reset sinus_phase";
    reinit(refrac_countdown,T_refrac) "reset refrac_countdown";
  end when;
annotation(Documentation(info="<html>
  <p>Models the contraction of the heart as described in Seidel's thesis.</p>
  <p>The model takes into account the following effects:</p>
  <ul>
    <li>There is a refractory period of duration <b>T_refrac</b> after a contraction during which signals of the sinus node are ignored.
    <li>If no sinus-induced contraction occurs for a prolonged time span (namely <b>T_av</b>) the av-node initiates a contraction by itself.
  </ul>
  <p><i>Note: The formulas in this model differ from the formulas found in the c-implementation by Seidel because OpenModelica is currently
  not capable of handling discrete equation systems. Therefore it was necessary to introduce the continuous phases <b>av_phase</b>, 
  <b>sinus_phase</b> and <b>refrac_countdown</b>.</i></p>
</html>"));
end Contraction;
within SHM.SeidelThesis.Examples.ComponentTests;
model PhaseEffectivenessExample
  Real x_minus "phase effectiveness with negative sign";
  Real x_plus "phase effectiveness with positive sign";
  parameter Real m_minus = SHM.SeidelThesis.Functions.PEMean(100,true) "mean of m_minus";
  parameter Real m_plus = SHM.SeidelThesis.Functions.PEMean(100,false) "mean of m_plus";
equation
  x_minus = SHM.SeidelThesis.Functions.PhaseEffectiveness(time,true);
  x_plus = SHM.SeidelThesis.Functions.PhaseEffectiveness(time,false);
annotation(Documentation(info="<html>
  <p>Test model for the phase effectiveness curve that shows both the application of the curve to time and the function PEMean.</p>
  <p>This model also demonstrates that in Seidels thesis there was a wrong sign in the equation for the phase effectiveness.</p>
  <p>Since the phase effectiveness function is applied to a signal that lies between zero and one it is only sensible to
  simulate this model for one second.</p>
  <p style=\"color:red;\">This model does not have graphical annotations. It is only designed for testing the component.</p>
</html>"));
end PhaseEffectivenessExample;
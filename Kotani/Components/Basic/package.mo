within Kotani.Components;
package Basic
  connector BloodVessel "Blood vessel propagating blood pressure"
    Real pressure "blood pressure p";
    Real rate "rate of blood pressure dp/dt";
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, origin={-0.0,-0.2067}, fillColor={128,0,0}, fillPattern=FillPattern.Solid, extent={{-100.0,-27.0785},{100.0,27.0785}})}));
  end BloodVessel;

  model BloodSystem
    Kotani.Components.Basic.BloodVessel vessel annotation(Placement(visible=true, transformation(origin={-50.955,1.3022}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-100.0,0.0}, extent={{-18.0225,-18.0225},{18.0225,18.0225}}, rotation=0)));
  equation 
    vessel.rate=der(vessel.pressure);
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, fillColor={128,0,0}, fillPattern=FillPattern.Solid, extent={{-82.6823,-83.2796},{82.6823,83.2796}})}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end BloodSystem;

  model NerveSystem
    Kotani.Components.Basic.Nerve fiber annotation(Placement(visible=true, transformation(origin={-52.1829,22.5723}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-10.0,0.0}, extent={{-31.8945,-31.8945},{31.8945,31.8945}}, rotation=0)));
  equation 
    fiber.rate=der(fiber.activation);
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Rectangle(visible=true, origin={-66.0563,-0.0}, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-36.0563,-10.0},{36.0563,10.0}}),Rectangle(visible=true, origin={64.8437,-0.0}, fillColor={0,0,255}, fillPattern=FillPattern.Solid, extent={{-34.8437,-10.0},{34.8437,10.0}})}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end NerveSystem;

  model StaticBloodPressure
    parameter Real p=40;
    Kotani.Components.Basic.BloodVessel bloodVessel1 annotation(Placement(visible=true, transformation(origin={-80.0,30.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={0.0,-0.0}, extent={{-100.0,-100.0},{100.0,100.0}}, rotation=0)));
  equation 
    bloodVessel1.pressure=p;
    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end StaticBloodPressure;

  model LinearBloodPressure
    parameter Real t1=0;
    parameter Real t2=1;
    parameter Real baseval=0;
    parameter Real topval=100;
    Kotani.Components.Basic.BloodVessel vessel annotation(Placement(visible=true, transformation(origin={-73.1495,-5.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={0.0,-0.0}, extent={{-100.0,-100.0},{100.0,100.0}}, rotation=0)));
  equation 
    vessel.pressure=baseval + (if time < t1 then 0 else if time < t2 then (time - t1)*(topval - baseval)/(t2 - t1) else topval);
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, origin={-1.047,3.826}, points={{-98.953,-76.174},{-58.953,-76.174},{56.858,76.174},{101.047,76.174}}, thickness=1)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end LinearBloodPressure;

  connector RespiratoryPhase
    Real phase;
    Real rate;
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, fillColor={255,255,255}, fillPattern=FillPattern.Solid, extent={{-77.5146,-77.4919},{77.5146,77.4919}})}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end RespiratoryPhase;

  model TestSatSignal "Kotani.Functions.Sat(time, 2, 2);"
    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
    Kotani.Components.Basic.Nerve no annotation(Placement(visible=true, transformation(origin={148.5677,3.0386}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={100.0,2.8939}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.Saturation sat;
  equation 
    sat.sat=2;
    sat.satexp=2;
    sat.x=time;
    no.activation=sat.satx;
  end TestSatSignal;

  model Saturation
    Real x;
    Real sat;
    Real satexp;
    Real satx;
  equation 
    satx=x + (sat - x)*x^satexp/(sat^satexp + x^satexp);
    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end Saturation;

  model LinearNerveSignal
    parameter Real t1=0;
    parameter Real t2=1;
    parameter Real baseval=0;
    parameter Real topval=100;
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Line(visible=true, origin={3.3073,-7.0003}, points={{-103.307,-67.0},{-58.291,-67.0},{64.906,67.0},{96.693,67.0}}, thickness=1)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
    Kotani.Components.Basic.Nerve nerve1 annotation(Placement(visible=true, transformation(origin={148.2445,1.5564}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={0.0,-0.0}, extent={{-47.2263,-47.2263},{47.2263,47.2263}}, rotation=0)));
  equation 
    nerve1.activation=baseval + (if time < t1 then 0 else if time < t2 then (time - t1)*(topval - baseval)/(t2 - t1) else topval);
  end LinearNerveSignal;

  model Bla "Macht irgendeinen Bla"
    parameter Real blubb=10;
    annotation(Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end Bla;

end Basic;

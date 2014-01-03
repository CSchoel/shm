within Kotani;
package Components
  model Baroreceptors "Baroreceptors measuring blood pressure"
    parameter Real p0=50 "minimum blood pressure needed to generate signal";
    parameter Real k1=0.02 "sensitivity of baroreceptors to blood pressure level";
    parameter Real k2=0.00125 "sensitivity of baroreceptors to change in blood pressure";
    Kotani.Components.Basic.BloodVessel artery annotation(Placement(visible=true, transformation(origin={-3.0696,0.4341}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-0.0,0.0}, extent={{-100.0,-100.0},{100.0,100.0}}, rotation=0)));
    Kotani.Components.Basic.Nerve signal annotation(Placement(visible=true, transformation(origin={-1.8417,85.0801}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={0.0,100.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
  equation 
    signal.activation=(artery.pressure - p0)*k1 + artery.rate*k2;
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Text(visible=true, origin={-0.0,-73.1144}, fillPattern=FillPattern.Solid, extent={{-100.0,-26.8856},{100.0,26.8856}}, textString="%name", fontName="Arial")}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end Baroreceptors;

  model SympatheticSystem
    Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible=true, transformation(origin={17.8036,4.7749}, extent={{-14.85,-10.5},{14.85,10.5}}, rotation=0), iconTransformation(origin={0.0,100.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.NerveFiber baro annotation(Placement(visible=true, transformation(origin={-148.5677,35.5947}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-100.0,0.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.NerveFiber signal annotation(Placement(visible=true, transformation(origin={0.0,-104.6138}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-0.0,-100.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    parameter Real baro_influence=0.8;
    parameter Real resp_influence=0.0003;
    parameter Real v0=0.95;
  equation 
    signal.activation=max(0, v0 - baro_influence*baro.activation + resp_influence*(1 - resp.phase));
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, fillColor={255,255,255}, extent={{-85.0,-85.0},{85.0,85.0}}),Text(visible=true, origin={-1.9921,-3.6597}, fillPattern=FillPattern.Solid, extent={{-64.4172,-73.6597},{64.4172,73.6597}}, textString="S", fontName="Arial"),Polygon(visible=true, origin={-91.5481,19.7806}, fillColor={128,0,0}, fillPattern=FillPattern.Solid, points={{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth=Smooth.Bezier),Line(visible=true, origin={26.4142,-94.2358}, points={{-14.508,-4.718},{-6.306,6.394},{-3.66,-7.1},{4.013,8.511},{6.13,-8.423},{14.332,5.336}}, thickness=3)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end SympatheticSystem;

  model ParasympatheticSystem
    Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible=true, transformation(origin={17.8036,4.7749}, extent={{-14.85,-10.5},{14.85,10.5}}, rotation=0), iconTransformation(origin={0.0,100.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.NerveFiber baro annotation(Placement(visible=true, transformation(origin={-148.5677,35.5947}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-100.0,0.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.NerveFiber signal annotation(Placement(visible=true, transformation(origin={0.0,-104.6138}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-0.0,-100.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    parameter Real baro_influence=0.036;
    parameter Real resp_influence=0.0045;
    parameter Real v0=0;
    parameter Real scaling_factor=1.1;
  equation 
    signal.activation=max(0, scaling_factor*(v0 + baro_influence*baro.activation + resp_influence*(1 - resp.phase)));
    annotation(Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, fillColor={255,255,255}, extent={{-85.0,-85.0},{85.0,85.0}}),Text(visible=true, origin={5.5828,-3.6597}, fillPattern=FillPattern.Solid, extent={{-64.4172,-73.6597},{64.4172,73.6597}}, textString="P", fontName="Arial"),Polygon(visible=true, origin={-91.5481,19.7806}, fillColor={128,0,0}, fillPattern=FillPattern.Solid, points={{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth=Smooth.Bezier),Line(visible=true, origin={26.4142,-94.2358}, points={{-14.508,-4.718},{-6.306,6.394},{-3.66,-7.1},{4.013,8.511},{6.13,-8.423},{14.332,5.336}}, thickness=3)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end ParasympatheticSystem;

  model SimpleLung
    Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible=true, transformation(origin={0.0,-102.7206}, extent={{-14.85,-10.5},{14.85,10.5}}, rotation=0), iconTransformation(origin={0.0,-97.8291}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.Nerve baro annotation(Placement(visible=true, transformation(origin={-147.9538,0.4341}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-100.0,-0.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    parameter Real Tresp=3.5 "base duration of respiratory phase";
    parameter Real G=0.2 "scaling factor for influence of baroreceptor afferents";
    parameter Real nu_trig=1.3 "threshold for baroreceptor afferents";
    Real r;
  initial equation 
    r=0;
  equation 
    if r < 0.5 then
      der(r)=max(0, 1/Tresp - max(0, G*(baro.activation - nu_trig))) "expiration";
    else
      der(r)=1/Tresp "inspiration";
    end if;
    when r > 1 then
      reinit(r, 0);
    end when;
    resp.phase=cos(2*Modelica.Constants.pi*r);
    annotation(__Wolfram(itemFlippingEnabled=true), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, origin={31.429,0.0}, rotation=100, fillColor={0,255,255}, fillPattern=FillPattern.Solid, extent={{-71.626,-26.5365},{71.626,26.5365}}),Ellipse(visible=true, origin={-31.429,-0.0}, rotation=-100, fillColor={0,255,255}, fillPattern=FillPattern.Solid, extent={{71.626,-26.5365},{-71.626,26.5365}}),Polygon(visible=true, origin={-84.206,21.29}, fillColor={128,0,0}, fillPattern=FillPattern.Solid, points={{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth=Smooth.Bezier)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end SimpleLung;

  model SuperSimpleLung
    Kotani.Components.Basic.RespiratoryPhase resp annotation(Placement(visible=true, transformation(origin={0.0,-102.7206}, extent={{-14.85,-10.5},{14.85,10.5}}, rotation=0), iconTransformation(origin={0.0,-97.8291}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    Kotani.Components.Basic.Nerve baro annotation(Placement(visible=true, transformation(origin={-147.9538,0.4341}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0), iconTransformation(origin={-100.0,-0.0}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
    parameter Real Tresp=3.5 "base duration of respiratory phase";
    parameter Real G=0.2 "scaling factor for influence of baroreceptor afferents";
    parameter Real nu_trig=1.3 "threshold for baroreceptor afferents";
    Real r;
  protected 
    Real t0(start=0);
  equation 
    when r > 1 or initial() then
      t0=time;
    end when;
    r=(time - t0)*1/Tresp;
    resp.phase=cos(2*Modelica.Constants.pi*r);
    annotation(__Wolfram(itemFlippingEnabled=true), Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, preserveAspectRatio=true, initialScale=0.1, grid={10,10}), graphics={Ellipse(visible=true, origin={31.429,0.0}, rotation=100, fillColor={0,255,255}, fillPattern=FillPattern.Solid, extent={{-71.626,-26.5365},{71.626,26.5365}}),Ellipse(visible=true, origin={-31.429,-0.0}, rotation=-100, fillColor={0,255,255}, fillPattern=FillPattern.Solid, extent={{71.626,-26.5365},{-71.626,26.5365}}),Polygon(visible=true, origin={-84.206,21.29}, fillColor={128,0,0}, fillPattern=FillPattern.Solid, points={{-3.305,1.254},{-5.794,-1.633},{-5.794,-7.905},{-2.355,-11.29},{3.069,-11.29},{5.98,-7.905},{6.088,-1.789},{3.177,1.783},{2.119,8.398},{-0.28,14.904},{-1.188,9.72},{-1.718,5.752}}, smooth=Smooth.Bezier)}), Diagram(coordinateSystem(extent={{-148.5,-105.0},{148.5,105.0}}, preserveAspectRatio=true, initialScale=0.1, grid={5,5})));
  end SuperSimpleLung;

end Components;

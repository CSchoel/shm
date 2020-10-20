within SHM.Shared.Components.Noise;
partial model TriggeredNoise
  // NOTE: generator sample period must be smaller than trigger distances!
  replaceable Modelica.Blocks.Noise.NormalNoise generator;
  input Boolean trigger;
  discrete output Real noise(start=0, fixed=true);
protected
  discrete Real noise_raw(start=0, fixed=true);
equation
  when trigger then
    noise_raw = generator.r;
  end when;
end TriggeredNoise;

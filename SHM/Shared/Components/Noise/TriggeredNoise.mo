within SHM.Shared.Components.Noise;
partial model TriggeredNoise
  // NOTE: generator sample period must be smaller than trigger distances!
  parameter Boolean enableNoise = true "if false, no noise is generated and the output is 0";
  parameter Real samplePeriod = "sample period for noise generator (must be smaller than minimum distance between two trigger signals!)";
  replaceable Modelica.Blocks.Noise.NormalNoise generator(
    startTime=(if enableNoise then 0 else -1),
    samplePeriod=(if enableNoise then samplePeriod else 1e100),
    enableNoise=enableNoise
  );
  input Boolean trigger;
  discrete output Real noise(start=0, fixed=true);
protected
  discrete Real noise_raw(start=0, fixed=true);
equation
  when trigger then
    noise_raw = generator.y;
  end when;
end TriggeredNoise;

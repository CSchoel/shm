within SHM.Shared.Components.Noise;
model AutoregressiveGaussianDeg1
  extends TriggeredNoise(generator.sigma=sigma);
  parameter Real r_last "ratio of last difference that is kept";
  parameter Real sigma "sigma of gaussian";
  discrete Real noise_last "last noise value output by this component";
equation
  when trigger
    noise = r_last * pre(noise_last) + noise_raw;
    noise_last = noise;
  end when;
end AutoregressiveGaussianDeg1;

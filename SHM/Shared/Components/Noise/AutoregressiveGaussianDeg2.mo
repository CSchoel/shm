within SHM.Shared.Components.Noise;
model AutoregressiveGaussianDeg2
  extends TriggeredNoise(generator.sigma=sigma);
  parameter Real r_last1 "ratio of last difference that is kept";
  parameter Real r_last2 "ratio of second last difference that is kept";
  parameter Real sigma "sigma of gaussian";
  discrete Real noise_last1(start=0, fixed=true) "last noise value output by this component";
  discrete Real noise_last2(start=0, fixed=true) "second last noise value output by this component";
equation
  when trigger
    noise = r_last1 * pre(noise_last1) + r_last2 * pre(noise_last2) + noise_raw;
    noise_last1 = noise;
    noise_last2 = pre(noise_last1);
  end when;
end AutoregressiveGaussianDeg2;

%Script for computing SNR(Signal-Noise-Ratio)

function snr=SNR1(I,In)

% I: original signal
 % In: noisy signal(ie. original signal + noise signal)
 % snr=10*log(sigma2(I2)/sigma2(I2-I1))
 Ps=sum(sum(I.^2));%signal power
 Pn=sum(sum((In-I).^2));%noise power
 snr=10*log10(Ps/Pn);
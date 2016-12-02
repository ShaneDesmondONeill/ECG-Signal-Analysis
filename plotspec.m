function [ output_args ] = plotspec4( val, time )
%PLOTSPEC Takes the HRV and timestamp vectors (val, time) and uses the
%lomb funtion to obtain a periodogram scaled tranform for those vectors
 
[P,f] = plomb(val,time,'pd',[0.95, 1]);
 
figure(); %plots the transform as power spectrum density
plot(f,10*log(P)); 
title('Power Spectrum');
xlabel('Frequency (Hz)');
ylabel('Power'); 
axis tight;
 
 
end

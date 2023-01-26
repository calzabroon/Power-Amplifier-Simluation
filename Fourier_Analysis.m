clear all; clc;

load Sa1.mat;
Fs = 16000;
% sound(wavedata,Fs);
doc fdesign.lowpass.
d = fdesign.lowpass('Fp,Fst,Ap,Ast',100, 4800, 0.08, 58,Fs);

filt = design(d);

fvtool(filt);

filt
filt.order

cost(filt)

%%


% filt(wavedata)

plotfft(wavedata,1/48*Fs,[-Fs/2000 Fs/2000]);
% 
x = lowpass(wavedata,5000,Fs)

sound(x,Fs)

plotfft(x,1/Fs,[-9 9]);
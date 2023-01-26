clear all; clc;

I = 48;
Fs = 16000;
%%
%CIC interpolator
dCICCOMP = fdesign.ciccomp(1,'fp,fst,ap,ast',5000, 5500, 0.08, 58);
filtCICCOMP = design(dCICCOMP,'SystemObject',true);
%%
%2 order and cost
filtCICCOMP.order
length(filtCICCOMP)
filtCICCOMP.cost

fvtool(filtCICCOMP);
%%
%implement signal into lowpass and Interpolation
load Sa1.mat;

%interpolation
wavedata_48I = filtCICCOMP(wavedata);
%%
%analyse output
plot(wavedata_48I)
plotfft(wavedata_48I,1/FsI,[-FsI/2000 FsI/2000]);

%%

length(wavedata)
length(wavedata_low)
length(wavedata_48I)
length(wavedata_48I)/48
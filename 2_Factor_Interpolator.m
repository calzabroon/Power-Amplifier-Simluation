clear all; clc;

I = 48;
Fs = 16000;
FsI = Fs*I;
%%
%2 stage interpolator
d2 = fdesign.interpolator(I,'nyquist',I,'TW,Ast',1200,58,FsI)
filt2stage = design(d2,'multistage','Nstages',2,'SystemObject',true);
%%
%2 order and cost
filt2stage.order
length(filt2stage)
filt2stage.cost

fvtool(filt2stage);
%%
%implement signal into lowpass and Interpolation
load Sa1.mat;

wavedata_48I = filt2stage(wavedata);
%%
%analyse output
plot(wavedata_48I);
plotfft(wavedata_48I,1/FsI,[-FsI/2000 FsI/2000]);
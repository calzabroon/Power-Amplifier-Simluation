clear all; clc;

load Sa1.mat;
%%
I = 48;
Fs = 16000;
FsI = Fs*I;

d = fdesign.interpolator(I,'lowpass','Fp,Fst,Ap,Ast',5000,6200,0.08,58,FsI);
filt = design(d,SystemObject = true);
%%
filt.order
length(filt)
filt.cost
%%
fvtool(filt);
%%
wavedata_48I = filt(wavedata);

plot(wavedata_48I)
plotfft(wavedata_48I,1/FsI,[-FsI/2000 FsI/2000]);
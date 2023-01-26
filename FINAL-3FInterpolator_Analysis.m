clear all; clc;

load Sa1.mat;
%%
I = 48;
Fs = 16000;
FsI = Fs*I;
%%
%design 3 stage interpolator
d = fdesign.interpolator(I,'lowpass','Fp,Fst,Ap,Ast',5000,6200,0.08,58,FsI)
filt3stage = design(d,'multistage','Nstages',3,'SystemObject',true)
%%
%pass signal through interpolator
wavedata_48I = filt3stage(wavedata);
%%
%analyse interpolator signal
% plot(wavedata_48I)
% plotfft(wavedata_48I,1/FsI,[-FsI/2000 FsI/2000]);
%%
%create sputious frequencies created in transmission
t = 0:1/FsI:8-1/FsI;
spur = .004*sin(16e3*2*pi*t)+.004*sin(50e3*2*pi*t)+.004*sin(100e3*2*pi*t)+.004*sin(150e3*2*pi*t);
%add to interpolator data
wavedata_spur = wavedata_48I + spur'
%%
plotfft(wavedata_spur,1/FsI,[-FsI/2000 FsI/2000]);
%%
%design 3-stage decimator
D = I/2
FsD = FsI/2;
d2 = fdesign.decimator(D,'lowpass','Fp,Fst,Ap,Ast',5000,6200,0.08,58,FsD)
filt2 = design(d2,'multistage','Nstages',3,'SystemObject',true)
%%
%pass interpolated signal through decimator
wavedata_D = filt2(wavedata_spur);
%%
%plot decimator signal
plot(wavedata_spur)
plot(wavedata_D)
plotfft(wavedata_D,1/Fs,[-16 16]);
%%
%cost of decimator
filt2.order
length(filt2)
filt2.cost
%%
%plot decimator
fvtool(filt2);
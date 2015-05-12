clear,clc,clf,echo on 
S=16000;
f=[1600];
F=f/S;

ns=wavread('NoisySignal.wav');		% Read Noisy Signal
ns=ns';
N=length(ns);n=0:N-1;

% Design IIR Butterworth using Bilinear Transformation
% to remove hum
clf;
TY='bs';             % type of filter:  'lp' 'hp' 'bp' 'bs'
fp=[ 1850 ];            % filter passband cut-off frequencies
fs=[ 750 ];            % filter stopband cut-off frequencies
A=[1 20];
[n1, d1] = dfdiir('bw',TY,'bili',A,S,fp,fs);
tfplot('z',n1,d1,[0 0.5],0,3),pause;
nsf=filter(n1,d1,ns);
%
% Plot speech, speech + hum and filtered speech
% Listen to filtered speech
%
clf; figure(1); subplot(3,1,1)
h = spectrum.welch; Hpsd = psd(h,ns,'Fs',S); 
plot(Hpsd); axis([0 8 -100 -30]);
subplot(3,1,2);
h = spectrum.welch; Hpsd = psd(h,nsf,'Fs',S); 
plot(Hpsd); axis([0 8 -100 -30]); pause;
%sound(nsf,S);

echo off
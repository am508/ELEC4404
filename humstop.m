%Where we think the hum is
hum = 800;

%Get the sampling frequency of the noisy signal
[y, Fs] = audioread('NoisySignal.wav');

%Listen to original signal
player = audioplayer(y, Fs);
play(player);
pause; 

%To convert from Hz to normalized frequency (required by Matlab filters),
%multiply by 2 and then divide by the sampling frequency 
Fn = hum*2/Fs;

%Now we can create a bandpass filter, note that you have to specify a range
%around 800Hz
Fnl = (hum-50)*2/Fs;
Fnh = (hum+50)*2/Fs;

%Create the filter
%Parameters are:( filter order, [low cutoff, high cutoff], type)
[b a] = butter(3,[Fnl, Fnh], 'stop');

%Apply the filter
dataOut = filter(b,a,y);

%Listen to filtered sound
player = audioplayer(dataOut, Fs);
play(player);
pause;

%TODO
%Figure out the optimum filter order and cutoff frequencies

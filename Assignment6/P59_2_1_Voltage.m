% Antonio Larios ENGR 516 Summer 2019
% Assignment 6
% 59.2.1
%%
% Generate a noisy tone that represents a measured voltage. Make the following parameters set-able from
% near the top of your program:

% a) Plot time history as well as the frequency spectra for each.
% b) Determine the signal to noise ratio from the frequency spectra. Do this in an automated way not by
% eye
% c) In separate studies, change the signal duration, sampling frequency, tone frequency over ranges of about
% 10 levels to determine if or how these changes effect the signal to noise ratio of the voltage. Plot how
% this effects impact the signal to noise ratio in a way that clearly illustrates the impacts of the parameters
% understudy.
% d) Determine and write empirical formulas for the signal to noise ratio.
clear;

fs = 1000; % sampling frequency, Hz
duration = 2; % signal duration, s
fc = 25; % tone frequency, Hz
A_tone = 2; % tone amplitude, V
A_noise = 0.02; % RMS noise level, V
N = duration*1000;
[f,t] = freqtime(1/fs,N);
voltage = A_tone*sin(2*pi*fc*t) + A_noise*randn(size(t));
VOLTAGE = fft(voltage)*(2/N);

% b) Determine the signal to noise ratio
voltageRMS = sqrt(mean(((A_tone*sin(2*pi*fc*t)).^2)));
noiseRMS = sqrt(mean(((A_noise*randn(size(t))).^2)));
SNR = 10*log10((voltageRMS^2/noiseRMS^2));

zf(1) = figure(1);clf;
za(1) = axes;
zp(1) = plot(t,voltage);
grid on;
xlabel('Time, s');
ylabel('Voltage, V');
set(za(1),'position',[.09 .59 .85 .38])

za(2) = axes; 
zp(2) = plot(f,abs(VOLTAGE));
grid on;
xlabel('Frequency, Hz');
ylabel('Voltage, V');
set(za(2),'position',[.09 .1 .85 .38])

ss = 'Voltage';
figsize = [8 6];
set(zf(1),'paperorientation','portrait')
set(zf(1),'papersize',figsize)
set(zf(1),'paperposition',[0 0 figsize]) %x start, y start, x length, y length
print(zf(1),'-dpng','-r300','-painters',ss)

function [f,t] = freqtime(si,N)
t = [0:N-1]'*si;
f = [0:N-1]'*(1/(si*N));
end

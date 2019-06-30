% Antonio Larios ENGR 516 Summer 2019
% Assignment 6
% 59.2.1

% d) Determine and write empirical formulas for the signal to noise ratio.
clear;

fs = 1000; % sample frequency, Hz (samples per unit time)
duration = 2; % signal duration, s
fc = 25; % tone frequency component, Hz
A_tone = 2; % tone amplitude, V
A_noise = 0.02; % RMS noise level, V
N = duration*fs; % number of samples
[f,t] = freqtime(1/fs,N);

% a) Plot time history as well as the frequency spectra for each.
voltage = A_tone*sin(2*pi*fc*t) + A_noise*randn(size(t));
VOLTAGE = fft(voltage)*(2/N);


% b) Determine the signal to noise ratio
voltageRMS = sqrt(mean(((A_tone*sin(2*pi*fc*t)).^2)));
noiseRMS = sqrt(mean(((A_noise*randn(size(t))).^2)));
SNR = 10*log10((voltageRMS^2/noiseRMS^2));

% c) Trade study: signal duration
durStudy = linspace(2,20000,10); % signal duration extended, s
N_durStudy = durStudy*fs; % number of samples

f_durStudy = cell(ones(1,1));
t_durStudy = cell(ones(1,1));

for k = 1:length(durStudy)
    [f_durStudy{:,k},t_durStudy{:,k}] = freqtime(1/fs,N_durStudy(k));
    voltageRMS_durStudy(k) = sqrt(mean(((A_tone*sin(2*pi*fc*t_durStudy{:,k})).^2)));
    noiseRMS_durStudy(k) = sqrt(mean(((A_noise*randn(size(t_durStudy{:,k}))).^2)));
    SNR_durStudy(k) = 10*log10((voltageRMS_durStudy(k)).^2./(noiseRMS_durStudy(k)).^2);
end


% c) Trade study: tone frequency
fcStudy = [0.5 1 2 5 10 20 50 100 200 400]; % tone frequency component, Hz
for k = 1:length(fcStudy)
    voltageRMS_fcStudy(k) = sqrt(mean(((A_tone*sin(2*pi*fcStudy(k)*t)).^2)));
    SNR_fcStudy(k) = 10*log10((voltageRMS_fcStudy(k)).^2./noiseRMS^2);
    SNR_MATLAB(k) = snr(voltageRMS_fcStudy(k),noiseRMS);
end


% c) Trade study: sampling frequency
fsStudy = [100 200 500 1000 2000 5000 10000 20000 50000 100000]; % sample frequency, Hz
N_fsStudy = duration.*fsStudy; % number of samples

f_fsStudy = cell(size(fsStudy));
t_fsStudy = cell(size(fsStudy));

for k = 1:length(fsStudy)
    [f_fsStudy{:,k},t_fsStudy{:,k}] = freqtime(1/fsStudy(k),N_fsStudy(k));
    voltageRMS_fsStudy(k) = sqrt(mean(((A_tone*sin(2*pi*fc*t_fsStudy{:,k})).^2)));
    noiseRMS_fsStudy(k) = sqrt(mean(((A_noise*randn(size(t_fsStudy{:,k}))).^2)));
    SNR_fsStudy(k) = 10*log10(((voltageRMS_fsStudy(k)).^2./(noiseRMS_fsStudy(k)).^2));
    SNR_MATLAB_fsStudy(k) = snr(voltageRMS_fsStudy(k),noiseRMS_fsStudy(k));
end


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

ss1 = 'Voltage';
figsize = [8 6];
set(zf(1),'paperorientation','portrait')
set(zf(1),'papersize',figsize)
set(zf(1),'paperposition',[0 0 figsize]) %x start,y start,x length,y length
print(zf(1),'-dpng','-r300','-painters',ss1)

zf(2) = figure(2);clf;
za(3) = axes;
zp(3) = plot(durStudy, SNR_durStudy,'o');
grid on;
xlabel('Duration, s');
ylabel('SNR');
set(za(3),'position',[.59 .59 .4 .4])

za(4) = axes;
zp(4) = semilogx(fcStudy, SNR_fcStudy,'o');
grid on;
xlabel('Tone Frequency, Hz');
ylim([36 38]);
ylabel('SNR');
set(za(4),'position',[.08 .59 .4 .4])

za(5) = axes;
zp(5) = loglog(fsStudy, SNR_fsStudy,'o');
grid on;
xlabel('Sample Frequency, Hz');
ylabel('SNR');
set(za(5),'position',[.34 .1 .38 .38])

ss2 = 'TradeStudies';
figsize = [8 6];
set(zf(2),'paperorientation','portrait')
set(zf(2),'papersize',figsize)
set(zf(2),'paperposition',[0 0 figsize]) %x start,y start,x length,y length
print(zf(2),'-dpng','-r300','-painters',ss2)

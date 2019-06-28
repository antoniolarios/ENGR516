% Antonio Larios ENGR 516 Summer 2019
% Assignment 6
% 59.6.1

% Use the following lines of code to generate a noisy tone that represents the displacement of a vibrating
% surface measured by a laser vibrometer.

% a) Calculate the velocity and acceleration by time domain differentiation.
% b) Plot all three time histories as well as the frequency spectra for each. Be sure to have something like
% 20 to 50 cycles shown and set the limits of the frequency domain vector to be from zero to about 3 times
% the tone frequency
% c) Determine the signal to noise ratio from the frequency spectra.
% d) Change the frequency of the tone, fc and determine if this changes the signal to noise ratio of the
% velocity and acceleration.
% e) Determine an empirical formula for the signal to noise ratio that includes the tone frequency.

A_tone = 2;
A_noise = .2;
displacement = A_tone*sin(2*pi*fc*t) + A_noise*randn(size(t));



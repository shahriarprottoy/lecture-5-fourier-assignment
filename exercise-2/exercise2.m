%% Exercise 2 - Find Two Frequencies with the FFT
% Author: MD Shahriar Fardin Protya
% Course: Digital Signal Processing, Savonia UAS

clear; clc; close all;

fs = 200;                       % Sampling frequency (Hz)
T = 1;                          % Recording length (s)
t = 0:1/fs:T-1/fs;              % 200 samples

x = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*40*t);

%% Time domain plot
figTime = figure('Name', 'Time domain');
plot(t, x, 'b', 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal in the Time Domain: 0.8 sin(2\pi15t) + 0.4 sin(2\pi40t)');
legend('x(t)');
saveas(figTime, 'time-domain-signal.png');

%% Single-sided amplitude spectrum
N = length(x);
Y = fft(x);

P2 = abs(Y/N);                  % Two-sided spectrum
P1 = P2(1:N/2+1);               % Keep 0 ... fs/2
P1(2:end-1) = 2*P1(2:end-1);    % Double everything except DC and Nyquist

f = fs*(0:N/2)/N;               % Frequency axis (Hz)

figSpec = figure('Name', 'Spectrum');
stem(f, P1, 'r', 'filled', 'MarkerSize', 4);
grid on;
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Single-Sided Amplitude Spectrum (fs = 200 Hz, N = 200)');
legend('|X(f)|');
xlim([0 fs/2]);
saveas(figSpec, 'two-frequency-spectrum.png');

%% Find and print the two largest peaks
[pk, idx] = maxk(P1, 2);
fprintf('Bin spacing: df = fs/N = %d/%d = %.2f Hz\n', fs, N, fs/N);
for i = 1:2
    fprintf('Peak %d: f = %5.1f Hz, amplitude = %.3f\n', i, f(idx(i)), pk(i));
end

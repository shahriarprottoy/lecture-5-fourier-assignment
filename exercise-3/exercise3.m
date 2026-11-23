%% Exercise 3 - Investigate Spectral Leakage
% Author: MD Shahriar Fardin Protya
% Course: Digital Signal Processing, Savonia UAS

clear; clc; close all;

fs = 200;                       % Sampling frequency (Hz)
d = 6;                          % Last digit of my student number
f2 = 13.2 + 0.17*d;             % = 14.22 Hz (not a whole number of cycles in 1 s)

fprintf('d = %d, f2 = %.2f Hz\n\n', d, f2);

fig = figure('Name', 'Leakage comparison', 'Position', [100 50 900 850]);

%% 1) One-second recording
T = 1;
t = 0:1/fs:T-1/fs;
x1 = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*f2*t);
[f, P] = singleSided(x1, fs, length(x1));

subplot(3,1,1);
stem(f, P, 'b', 'filled', 'MarkerSize', 4); hold on;
xline(f2, 'r--', 'LineWidth', 1.2); xline(15, 'k:', 'LineWidth', 1.2); hold off;
grid on; xlim([0 30]); ylim([0 0.9]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title(sprintf('1 s recording: N = %d, bin spacing = %.2f Hz', length(x1), fs/length(x1)));
legend('Spectrum', sprintf('True f_2 = %.2f Hz', f2), '15 Hz', 'Location', 'northwest');
printPeaks('1 s recording', f, P);

%% 2) Four-second recording (same fs and frequencies)
T = 4;
t = 0:1/fs:T-1/fs;
x4 = 0.8*sin(2*pi*15*t) + 0.4*sin(2*pi*f2*t);
[f, P] = singleSided(x4, fs, length(x4));

subplot(3,1,2);
stem(f, P, 'b', 'filled', 'MarkerSize', 3); hold on;
xline(f2, 'r--', 'LineWidth', 1.2); xline(15, 'k:', 'LineWidth', 1.2); hold off;
grid on; xlim([0 30]); ylim([0 0.9]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title(sprintf('4 s recording: N = %d, bin spacing = %.2f Hz', length(x4), fs/length(x4)));
legend('Spectrum', sprintf('True f_2 = %.2f Hz', f2), '15 Hz', 'Location', 'northwest');
printPeaks('4 s recording', f, P);

%% 3) Zero-padding the 1 s recording: fft(x, 4*length(x))
M = 4*length(x1);
[f, P] = singleSided(x1, fs, M);

subplot(3,1,3);
plot(f, P, 'm', 'LineWidth', 1.3); hold on;
xline(f2, 'r--', 'LineWidth', 1.2); xline(15, 'k:', 'LineWidth', 1.2); hold off;
grid on; xlim([0 30]); ylim([0 0.9]);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title(sprintf('1 s recording zero-padded to %d points: point spacing = %.2f Hz', M, fs/M));
legend('Zero-padded spectrum', sprintf('True f_2 = %.2f Hz', f2), '15 Hz', 'Location', 'northwest');

sgtitle(sprintf('Spectral Leakage: 15 Hz + %.2f Hz (fs = %d Hz)', f2, fs));
saveas(fig, 'leakage-comparison.png');

%% Local functions
function [f, P1] = singleSided(x, fs, M)
    % Single-sided amplitude spectrum with an M-point FFT.
    % Divide by the ORIGINAL length so zero-padding does not change amplitudes.
    N = length(x);
    Y = fft(x, M);
    P2 = abs(Y/N);
    P1 = P2(1:M/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:M/2)/M;
end

function printPeaks(label, f, P)
    band = (f >= 10) & (f <= 20);
    fb = f(band); Pb = P(band);
    [pk, idx] = maxk(Pb, 2);
    fprintf('%s: peaks at %.2f Hz (%.3f) and %.2f Hz (%.3f)\n', ...
            label, fb(idx(1)), pk(1), fb(idx(2)), pk(2));
end

%% Exercise 4 - Compare the DTFT and DFT
% Author: MD Shahriar Fardin Protya
% Course: Digital Signal Processing, Savonia UAS

clear; clc; close all;

x = [1 1 1 1];
n = 0:length(x)-1;

%% DTFT at 1000 frequencies between -pi and pi
w = linspace(-pi, pi, 1000);
X = x * exp(-1j * (n.' * w));       % X(w) = sum of x[n] e^(-j w n)

%% DFT with 4 and 64 points
X4  = fft(x, 4);
X64 = fft(x, 64);

% DFT bin k is at w = 2*pi*k/N. fftshift moves the bins to -pi ... pi
% so they line up with the DTFT plot.
w4  = 2*pi*(-2:1)/4;                % -pi, -pi/2, 0, pi/2
w64 = 2*pi*(-32:31)/64;

fig = figure('Name', 'DTFT vs DFT', 'Position', [100 50 900 850]);

subplot(3,1,1);
plot(w, abs(X), 'b', 'LineWidth', 1.5);
grid on; xlim([-pi pi]); ylim([0 4.5]);
xticks(-pi:pi/2:pi);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
xlabel('Angular frequency (rad/sample)'); ylabel('Magnitude');
title('DTFT of x = [1 1 1 1] (1000 points)');
legend('|X(e^{j\omega})|');

subplot(3,1,2);
plot(w, abs(X), 'b', 'LineWidth', 1); hold on;
stem(w4, abs(fftshift(X4)), 'r', 'filled', 'LineWidth', 1.5); hold off;
grid on; xlim([-pi pi]); ylim([0 4.5]);
xticks(-pi:pi/2:pi);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
xlabel('Angular frequency (rad/sample)'); ylabel('Magnitude');
title('DFT with fft(x,4) on top of the DTFT');
legend('DTFT', '|fft(x,4)|');

subplot(3,1,3);
plot(w, abs(X), 'b', 'LineWidth', 1); hold on;
stem(w64, abs(fftshift(X64)), 'm', 'filled', 'MarkerSize', 3); hold off;
grid on; xlim([-pi pi]); ylim([0 4.5]);
xticks(-pi:pi/2:pi);
xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'});
xlabel('Angular frequency (rad/sample)'); ylabel('Magnitude');
title('DFT with fft(x,64) on top of the DTFT');
legend('DTFT', '|fft(x,64)|');

sgtitle('DTFT vs DFT of x = [1 1 1 1]');
saveas(fig, 'dtft-dft-comparison.png');

%% Print results
fprintf('|fft(x,4)|  = %s\n', mat2str(round(abs(X4), 3)));
fprintf('Max of |DTFT| = %.2f at w = 0\n', max(abs(X)));

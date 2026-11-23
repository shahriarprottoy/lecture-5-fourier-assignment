%% Exercise 1 - Build a Square Wave from Harmonics (Fourier Series)
% Author: MD Shahriar Fardin Protya
% Course: Digital Signal Processing, Savonia UAS
%
% A square wave (amplitude 1, frequency 1 Hz) is approximated by adding
% its odd harmonics:  x(t) = (4/pi) * sum over odd k of sin(2*pi*k*t)/k

clear; clc; close all;

t = linspace(-1, 1, 4000);      % Time axis: two periods of a 1 Hz wave
H_values = [1 3 9 25];          % Highest harmonic used in each approximation

fig = figure('Name', 'Square wave comparison', 'Position', [100 100 1000 650]);

for i = 1:length(H_values)
    H = H_values(i);
    x = zeros(size(t));

    % Add the odd harmonics k = 1, 3, 5, ..., H
    for k = 1:2:H
        x = x + (4/pi) * sin(2*pi*k*t) / k;
    end

    % Ideal square wave for comparison
    ideal = sign(sin(2*pi*t));

    subplot(2, 2, i);
    plot(t, ideal, 'k--', 'LineWidth', 1); hold on;
    plot(t, x, 'b', 'LineWidth', 1.3); hold off;
    grid on;
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('H = %d  (%d odd harmonics)', H, (H+1)/2));
    legend('Ideal square wave', 'Fourier approximation', 'Location', 'southwest');
    ylim([-1.5 1.5]);

    % Print the highest value: shows the overshoot near the jumps
    fprintf('H = %2d: maximum value = %.3f\n', H, max(x));
end

sgtitle('Square Wave Approximation with Odd Harmonics');

saveas(fig, 'square-wave-comparison.png');

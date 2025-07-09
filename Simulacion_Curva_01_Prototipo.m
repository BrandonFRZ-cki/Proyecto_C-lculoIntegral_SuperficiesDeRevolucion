% ===== Curva generatriz de la torre de enfriamiento =====
clc; clear; close all;

% === Parámetros reales ===
a = 33.23;      % radio mínimo en m
c = 97.2;       % parámetro vertical

% === Rango según el corte original: desde x = -5 a x = 137.5 m ===
x = linspace(-5, 137.5, 1000);
r = a * sqrt(1 + (x.^2) / c^2);  % fórmula del hiperboloide girado
    
% === Gráfica estilizada ===
figure('Color','w', 'Name','Curva Generatriz', 'NumberTitle','off');
plot(x, r, 'Color', [0.1 0.3 0.7], 'LineWidth', 2);
hold on;

% Reflejar la curva para mostrar revolución
plot(x, -r, 'Color', [0.7 0.1 0.1], 'LineWidth', 2, 'LineStyle', '--');

xlabel('x (altura en m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Radio r(x) (m)', 'FontSize', 12, 'FontWeight', 'bold');
title('Curva generatriz del hiperboloide recortado', ...
    'FontSize', 14, 'FontWeight', 'bold');

grid on;
axis equal;
legend('r(x)', '-r(x) (simetría para revolución)', 'Location', 'northeast');

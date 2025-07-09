% ===== Torre de enfriamiento (hiperboloide recortado) =====
clc; clear; close all;

% === Parámetros geométricos reales ===
a = 33.23;     % radio mínimo (m)
b = 33.23;
c = 97.2;      % estiramiento vertical

% === Corte asimétrico: desde -5 m hasta 137.5 m (mismo que el original) ===
x_min = -5;
x_max = 137.5;

% === Malla más fina para suavidad ===
step = 1;
[X, Y, Z] = meshgrid(x_min:step:x_max, -80:step:80, -80:step:80);

% === Ecuación implícita del hiperboloide ===
V = (Y.^2)/(a^2) + (Z.^2)/(b^2) - (X.^2)/(c^2);

% === Visualización ===
figure('Color','w', 'Name','Torre de Enfriamiento 3D', 'NumberTitle','off');
p = patch(isosurface(X, Y, Z, V, 1));
isonormals(X, Y, Z, V, p);

% === Estética ===
set(p, ...
    'FaceColor', [0.2 0.5 0.8], ...     % azul acero
    'EdgeColor', 'none', ...
    'FaceAlpha', 0.95);                % casi opaco

% Base transparente (opcional)
hold on;
[xc, yc] = meshgrid(-80:1:80);
z_base = ones(size(xc)) * Z(1,1,1);
r_base = sqrt((xc.^2 + yc.^2));
mask = (r_base <= a * sqrt(1 + (x_min^2)/c^2)); % base circular
surf(z_base, xc, yc, 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'FaceColor', [0 0 0]);

% === Cámara, luz y aspecto ===
daspect([1 1 1]);
view([-45 20]);             % ángulo 3D atractivo
camlight('right');
camlight('left');
lighting gouraud;

% === Ejes y título estilizados ===
xlabel('x (altura en m)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y', 'FontSize', 12, 'FontWeight', 'bold');
zlabel('z', 'FontSize', 12, 'FontWeight', 'bold');
title('Simulación 3D: Torre de Enfriamiento Nuclear', ...
    'FontSize', 14, 'FontWeight', 'bold', 'Color', [0.1 0.1 0.5]);

grid on;
axis tight;
% ---------------------------------------
% RESOLUCION MEDIANTE CODIGO:

% Funciones
r = @(x) a .* sqrt(1 + (x.^2) / c^2);
rp = @(x) (a .* x) ./ (c^2 .* sqrt(1 + (x.^2)/c^2));
integrando = @(x) 2 * pi .* r(x) .* sqrt(1 + (rp(x)).^2);

% Cálculo numérico
x_min = -5;
x_max = 137.5;
area_superficie = integral(integrando, x_min, x_max);

fprintf('Área de la superficie: %.2f m^2\n', area_superficie);

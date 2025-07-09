% Parámetros
a = 33.23; b = 33.23; c = 97.2; % radios

% Malla tridimensional (ahora el eje principal es X)
[X, Y, Z] = meshgrid(-137.5:5:137.5, -80:5:80, -80:5:80);

% Función implícita rotada: eje principal en X
V = (Y.^2)/(a^2) + (Z.^2)/(b^2) - (X.^2)/(c^2);

% Extraer superficie
p = patch(isosurface(X, Y, Z, V, 1));
set(p, 'FaceColor', 'w', 'EdgeColor', 'k');

% Estilo
daspect([1 1 1]);
view(3);
camlight;
lighting gouraud;
xlabel('x'); ylabel('y'); zlabel('z');
title('Torre de enfriamiento girando respecto a x');

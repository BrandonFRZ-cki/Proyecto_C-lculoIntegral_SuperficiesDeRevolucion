# 🧊 Torres de Enfriamiento como Superficies de Revolución

Este proyecto presenta el modelado de una **torre de enfriamiento nuclear** como una **superficie de revolución hiperboloide**, integrando conceptos de cálculo integral, modelado computacional y construcción a escala.

---

## 📘 Descripción General

Las torres de enfriamiento son estructuras utilizadas en plantas nucleares e industriales para disipar el calor sobrante. Su diseño tipo **hiperboloide de revolución** no es solo estético, sino altamente funcional: permite una ventilación natural eficiente, estabilidad estructural y menor consumo de materiales.

En este proyecto se analiza una torre con **medidas reales**, se realiza su simulación en MATLAB, se calcula su **área superficial exacta**, y se construye una **maqueta a escala** con una altura de 20 cm.

---
## 🧊 Medidas reales de una torre de enfriamiento nuclear
Estas dimensiones corresponden a torres de enfriamiento de tipo hiperboloide de tiro natural, usadas en centrales nucleares como la de Niederaussem (Alemania) o la de Kalisindh (India). Son estructuras de referencia internacional.
| Elemento                             | Valor típico (real)                 |
| ------------------------------------ | ----------------------------------- |
| **Altura total**                     | 142.5 m                             |
| **Radio mínimo (cintura)**           | 33.23 m                             |
| **Radio máximo (base o boca)**       | \~50 m                              |
| **Diámetro mínimo (cintura)**        | \~66.46 m                           |
| **Diámetro máximo (boca/base)**      | \~100 m                             |
| **Altura de cintura (mínimo radio)** | \~60–70 m desde la base             |
| **Espesor promedio de pared**        | 0.25–0.5 m (superior), 1.5 m (base) |
| **Área superficial externa**         | \~38,000 m²                         |
| **Volumen interno de aire**          | \~200,000 m³                        |


---
## 🧮 Modelo Matemático

### 🔹 Paso 1: Definir la curva generatriz
La torre se genera al rotar la siguiente curva en torno al eje **x**:

$$r(x) = a \cdot \sqrt{1 + \frac{x^2}{c^2}}$$


Donde:
- Radio mínimo (en la cintura de la grafica completa)
$$ a = 33.23$$ 
- Factor de estiramiento vertical
$$ c = 97.2 m $$  
Intervalo real de la torre
$$ x -5, 137.5m$$ 

### 🔹 Paso 2: Definir el intervalo de integración

$$x_{\text{min}} = -5, \quad x_{\text{max}} = 137.5
$$

$$h = x_{\text{max}} - x_{\text{min}} = 142.5
$$

### 🔹 Paso 3: Calcular la derivada de 𝑟(𝑥)
$$r'(x) = \frac{a \cdot x}{c^2 \cdot \sqrt{1 + \frac{x^2}{c^2}}}
$$

### 🔹 Paso 4: Plantear la integral de superficie de revolución
- Fromula
$$S = 2 \pi \int_{x_1}^{x_2} r(x) \cdot \sqrt{1 + \left(r'(x)\right)^2} \, dx
$$
- Remplazado
$$S = 2\pi \int_{-5}^{137.5} 
\left(
a \cdot \sqrt{1 + \frac{x^2}{c^2}} \cdot 
\sqrt{1 + \left( \frac{a \cdot x}{c^2 \cdot \sqrt{1 + \frac{x^2}{c^2}}} \right)^2}
\right)
\, dx
$$

### 🔹 Paso 5: Resolver la integral numéricamente
$$S \approx 38307.27\,\text{m}^2
$$


---

### 🟩 Resultado del cálculo en MATLAB:


Área de la superficie: $$38307.27 m^2$$

```matlab

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

```

## 💻 Código MATLAB

### Prototipo 1
Este script genera una torre de enfriamiento en 3D:

```matlab
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

```
![alt text](image-3.png)

## Simulación Final
### Curva Generatriz

```matlab
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

```
![alt text](image-4.png)

### Superficie

```matlab
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



```

![alt text](image-5.png)
![alt text](image-6.png)





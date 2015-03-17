% EJERCICIOS RESUELTOS DE VISIÓN POR COMPUTADOR
% Autores: Gonzalo Pajares y Jesús Manuel de la Cruz
% Copyright RA-MA, 2007
% Ejercicio 5.16: Suavizado y Realzado: histograma ecualización

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.11.5 Histogramas: ecualización
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Histograma para 10 niveles de gris

close all; clear all;
B = [0 0 1 2 6; 1 3 3 1 3; 2 2 4 3 3; 2 4 5 4 3; 1 5 5 4 4];

L = 10; %numero de niveles de gris
%creamos un vector para contar los valores
H = zeros(1,L);

[m,n] = size(B);

%calculo del histograma
for i=1:1:m
    for j=1:1:n
      H(B(i,j)+1) = H(B(i,j)+1) + 1;  
    end
end

x = 0:1:L-1;
figure; bar(x,H,'k','LineWidth',2)

%calculo de la probabilidad
p = H/(m*n);

%calculo de la probabilidad acumulada
P = zeros(1,L);
for i=1:1:L
    if i == 1
        P(i) = p(i);
    else
        P(i) = P(i-1) + p(i);
    end 
end

% calculo de la funcion de distribucion
gmax = 9; gmin = 0;
for i=1:1:L
  F(i) = floor((gmax - gmin)*P(i) + gmin);
end

disp('Ecualización de histograma (F(g)):'); disp(F);

%generamos la imagen resultante de la ecualización

BEq = zeros(m,n);
for i=1:1:m
    for j=1:1:n
        if B(i,j) == 0
            BEq (i,j) = F(1);
        elseif B(i,j) == 1
            BEq (i,j) = F(2);
        elseif B(i,j) == 2
            BEq (i,j) = F(3);
        elseif B(i,j) == 3
            BEq (i,j) = F(4);
        elseif B(i,j) == 4
            BEq (i,j) = F(5);
        elseif B(i,j) == 5
            BEq (i,j) = F(6);
        elseif B(i,j) == 6
            BEq (i,j) = F(7);
        elseif B(i,j) == 7
            BEq (i,j) = F(8);
        elseif B(i,j) == 8
            BEq (i,j) = F(9);
        elseif B(i,j) == 9
            BEq (i,j) = F(10);
        end
            
    end
end

%calculo del nuevo histograma
HEq = zeros(1,L);
for i=1:1:m
    for j=1:1:n
      HEq(BEq(i,j)+1) = HEq(BEq(i,j)+1) + 1;  
    end
end

x = 0:1:L-1;

figure; bar(x,HEq,'k','LineWidth',2)

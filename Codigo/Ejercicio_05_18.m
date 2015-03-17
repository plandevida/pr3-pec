% EJERCICIOS RESUELTOS DE VISIÓN POR COMPUTADOR
% Autores: Gonzalo Pajares y Jesús Manuel de la Cruz
% Copyright RA-MA, 2007
% Ejercicio 5.18: Histogramas: correspondencia

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.11.6 Histogramas: correspondencia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Histograma para 10 niveles de gris
close all; clear all;
A = [1 1 0 1 4; 2 2 2 3 5; 2 2 3 2 4; 4 4 1 2 1; 3 4 1 2 5];

B = [4 3 2 5 7; 7 8 4 4 7; 6 5 4 9 3; 9 6 5 2 8; 8 8 7 7 6];

L = 10; %numero de niveles de gris
%creamos un vector para contar los valores
Ha = zeros(1,L);
Hb = zeros(1,L);

[m,n] = size(B);

%calculo de los histogramas
for i=1:1:m
    for j=1:1:n
      Ha(A(i,j)+1) = Ha(A(i,j)+1) + 1;  
      Hb(B(i,j)+1) = Hb(B(i,j)+1) + 1;  
    end
end

x = 0:1:L-1;
figure; bar(x,Ha,'k','LineWidth',2)
figure; bar(x,Hb,'k','LineWidth',2)

%calculo de las probabilidades
pa = Ha/(m*n); pb = Hb/(m*n);

%calculo de la probabilidad acumulada
Pa = zeros(1,L); Pb = zeros(1,L);
for i=1:1:L
    if i == 1
        Pa(i) = pa(i);
        Pb(i) = pb(i);
    else
        Pa(i) = Pa(i-1) + pa(i);
        Pb(i) = Pb(i-1) + pb(i);
    end 
end

% busqueda del matching de histogramas

Matching = zeros(1,L);

for i=1:1:L
    b = Pb(i); indice = 1;
    a = Pa(1);
    d1 = abs(a-b);
    for j=1:1:L
      a = Pa(j);
      d = abs(a-b); 
      if d < d1 
          d1 = d;
          indice = j;
      end
    end
    Matching(i) = indice; 
end

Bt = zeros(m,n);

for i=1:1:m
    for j=1:1:n
      Bt(i,j) = Matching (B(i,j)+1)-1; 
    end
end

Ht = zeros(1,L);

%calculo de los histogramas
for i=1:1:m
    for j=1:1:n
      Ht(Bt(i,j)+1) = Ht(Bt(i,j)+1) + 1;  
    end
end

disp('Probabilidad acumulada A: '); disp(Pa);
disp('Probabilidad acumulada B: '); disp(Pb);
disp('Imagen transformada Bt: '); disp(Bt);

figure; bar(x,Ht,'k','LineWidth',2)

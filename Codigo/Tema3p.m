close all; clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

I = double(II(:,:,1));

[M,N] = size(I);

% exponente m
m1 = 1/2; % raíz cuadrada
m2 = 2;   % cuadrada

L = 255; %255 niveles de gris
for i=1:1:M
    for j=1:1:N
        Res1(i,j) = L^(1-m1)*I(i,j)^m1;
        Res2(i,j) = L^(1-m2)*I(i,j)^m2;
        Res3(i,j) = L*log(1+I(i,j))/log(1+L);
      
    end
end
Im1 = mat2gray(Res1);
Im2 = mat2gray(Res2);
Im3 = mat2gray(Res3);

subplot(2,2,1); imshow(II);  title('imagen original');
subplot(2,2,2); imshow(Im1); title('raíz cuadrada');
subplot(2,2,3); imshow(Im2); title('cuadrada');
subplot(2,2,4); imshow(Im3); title('logarítmica');
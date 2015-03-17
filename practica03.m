% suavizado
% lectura de la imagen original
I  = imread('Tema04a.jpg','jpeg');
Ir = double(I(:,:,1));

% corrupción por ruido blanco gaussiano de media cero y varianza 0.05
J = mat2gray(imnoise(I,'gaussian',0,0.05));

Jr = J(:,:,1);

%% suavizado promedio de vecindad

% nucleo del filtro
size = 3;
h = fspecial('average',size);

% Imagen suavizada
Is = mat2gray(conv2(Jr,h,'same'));
%%

%% suvizado gausiano
% nucleo del filtro gaussianao
w = 3; sigma = 5;
ww = 2*w + 1;
[x,y] = meshgrid(-w:w, -w:w);
m = 1/(2*pi) * exp( -(x.^2 + y.^2)/2/sigma^2);
g = m / sum(sum(m));

size = 5;
h = fspecial('average',size);

% Imagen suavizada con g
Ih = mat2gray(conv2(Jr,h,'same'));
%%

figure(1);
subplot(2,2,1); imshow(I);  title('imagen original');
subplot(2,2,2); imshow(Jr); title('imagen ruidosa');
subplot(2,2,3); imshow(Is); title('imagen suavizada h = promedio');
subplot(2,2,4); imshow(Ih); title('imagen suavizada g = gaussiana');

% histogramas
%% lectura de las imgágenes
clear all;
I = imread('Tema04b-lzda.jpg','jpeg');
D = imread('Tema04b-Dcha.jpg','jpeg');

Izda = I(:,:,1);
Dcha = D(:,:,1);

figure(2);
subplot(2,2,1); imshow(Izda); title('Imagen Izda de un par stereo');
subplot(2,2,2); imshow(Dcha); title('Imagen Dcha de un par stereo');
subplot(2,2,3); imhist(Izda); title('Histograma Izda de un par stereo');
subplot(2,2,4); imhist(Dcha); title('Histograma Dcha de un par stereo');

% ecualización de histograma
Jzda = histeq(Izda);

figure(3);
subplot(2,2,1); imshow(Izda); title('Imagen Izda de un par stereo');
subplot(2,2,2); imshow(Jzda); title('Imagen Izda de un par stereo ecualizada');
subplot(2,2,3); imhist(Izda); title('Histograma imagen Izda');
subplot(2,2,4); imhist(Jzda); title('Histograma imagen Izda ecualizada');

% expansión de histograma
Izda = I(:,:,1); 

figure(4);
subplot(2,2,1); imshow(Izda); title('Imagen oscurecida');
subplot(2,2,2); imhist(Izda); title('Histograma');


Izda = double(Izda);

MIN_IN = min(min(Izda)); MAX_IN = max(max(Izda));
MIN_OUT = 0; MAX_OUT = 255;

[M,N] = size(Izda);

for i=1:1:M
    for j=1:1:N
      J(i,j) = ((Izda(i,j)-MIN_IN)./(MAX_IN-MIN_IN)).*((MAX_OUT-MIN_OUT)+MIN_OUT);
    end
end

J = uint8(J);

subplot(2,2,3); imshow(J); title('Imagen histograma expandido');
subplot(2,2,4); imhist(J); title('Histograma');

% filtrado homomórfico
clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

figure(5);
subplot(1, 2, 1); imshow(II);

I = double(II(:,:,1));

[M,N] = size(I);

%filtrado homomórfico

I1=log(I+1);
I1_fft=fftshift(fft2(I1));

% diseño del núcleo del filtro paso bajo
R = 100; %radio

FiltroPB = ones(M,N);
for i=1:1:M
    for j=1:1:N
       d = sqrt((i-M/2)^2 + (j-N/2)^2);
       if d < R 
          FiltroPB(i,j) = 0; 
       end
    end
end
FiltroPA = 1 - FiltroPB;

I1_filtrada = I1_fft.*FiltroPA;
I1_restaurada=abs(ifft2(I1_filtrada));

I11_restaurada = exp(I1_restaurada)-1;
Im=mat2gray(I11_restaurada);

subplot(1, 2, 2); imshow(Im);

%% función radiométrica
clear all;

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

figure(6);
subplot(2,2,1); imshow(II);  title('imagen original');
subplot(2,2,2); imshow(Im1); title('raíz cuadrada');
subplot(2,2,3); imshow(Im2); title('cuadrada');
subplot(2,2,4); imshow(Im3); title('logarítmica');
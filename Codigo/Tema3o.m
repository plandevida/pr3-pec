close all; clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

figure; imshow(II);

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

figure; imshow(Im)
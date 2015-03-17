close all; clear all;

% lectura de la imagen original
II = imread('Tema04b-lzda.jpg','jpeg');

I = II(:,:,1); 

subplot(2,2,1); imshow(I); title('Imagen oscurecida');
subplot(2,2,2); imhist(I); title('Histograma');


I = double(I);

MIN_IN = min(min(I)); MAX_IN = max(max(I));
MIN_OUT = 0; MAX_OUT = 255;

[M,N,s] = size(I);

for i=1:1:M
    for j=1:1:N
      J(i,j) = ((I(i,j)-MIN_IN)./(MAX_IN-MIN_IN)).*((MAX_OUT-MIN_OUT)+MIN_OUT);
    end
end

J = uint8(J);

subplot(2,2,3); imshow(J); title('Imagen histograma expandido');
subplot(2,2,4); imhist(J); title('Histograma');

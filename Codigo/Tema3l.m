
% lectura de la imagen original
I = imread('Tema04b-lzda.jpg','jpeg');
D = imread('Tema04b-Dcha.jpg','jpeg');

Izda = I(:,:,1); Dcha = D(:,:,1);

subplot(2,2,1); imshow(Izda); title('Imagen Izda de un par stereo');
subplot(2,2,2); imshow(Dcha); title('Imagen Dcha de un par stereo');
subplot(2,2,3); imhist(Izda); title('Histograma Izda de un par stereo');
subplot(2,2,4); imhist(Dcha); title('Histograma Dcha de un par stereo');

% ecualización de histograma
Jzda = histeq(Izda);

figure;
subplot(2,2,1); imshow(Izda); title('Imagen Izda de un par stereo');
subplot(2,2,2); imshow(Jzda); title('Imagen Izda de un par stereo ecualizada');
subplot(2,2,3); imhist(Izda); title('Histograma imagen Izda');
subplot(2,2,4); imhist(Jzda); title('Histograma imagen Izda ecualizada');

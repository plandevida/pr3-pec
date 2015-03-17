
% lectura de la imagen original
I  = imread('Tema04a.jpg','jpeg');
Ir = double(I(:,:,1));

% corrupción por ruido blanco gaussiano de media cero y varianza 0.05
J = mat2gray(imnoise(I,'gaussian',0,0.05));

Jr = J(:,:,1);

% nucleo del filtro gaussianao
w = 3; sigma = 5;
ww = 2*w + 1;
[x,y] = meshgrid(-w:w, -w:w);
m = 1/(2*pi) * exp( -(x.^2 + y.^2)/2/sigma^2);
g = m / sum(sum(m));

% representación 3D
figure; meshz(g);

size = 5;
h = fspecial('average',size);


% Imagen suavizada con g
Ig = mat2gray(conv2(Jr,g,'same'));

% Imagen suavizada con h
Ih = mat2gray(conv2(Jr,h,'same'));


subplot(2,2,1); imshow(I);  title('imagen original');
subplot(2,2,2); imshow(Jr); title('imagen ruidosa');
subplot(2,2,3); imshow(Ih); title('imagen suavizada g = gaussiana');
subplot(2,2,4); meshz(g);   title('representación 3D');


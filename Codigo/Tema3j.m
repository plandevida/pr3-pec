
% lectura de la imagen original
I  = imread('Tema04a.jpg','jpeg');
Ir = double(I(:,:,1));

% corrupción por ruido blanco gaussiano de media cero y varianza 0.05
J = mat2gray(imnoise(I,'gaussian',0,0.05));

Jr = J(:,:,1);

% nucleo del filtro
h = (1/9)*[1 1 1; 1 1 1; 1 1 1];

%size = 3;
% h = fspecial('average',size);


% Imagen suavizada
Is = mat2gray(conv2(Jr,h,'same'));

subplot(2,2,1); imshow(I);  title('imagen original');
subplot(2,2,2); imshow(Jr);  title('imagen ruidosa');
subplot(2,2,3); imshow(Is);   title('imagen suavizada h = promedio');


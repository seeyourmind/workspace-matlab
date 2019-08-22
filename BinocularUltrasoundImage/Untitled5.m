clear, close, clc;
%% RGB color space
i = imread('shishi1.jpg');
rgbf = figure(1),set(rgbf,'Name','RGB color space'),
subplot(311),imshow(i(:,:,1));
subplot(312),imshow(i(:,:,2));
subplot(313),imshow(i(:,:,3));
%% Lab color space
cform = makecform('srgb2lab');
lab = applycform(i,cform);
labf = figure(2),set(labf,'Name','Lab color space'),
subplot(311),imshow(lab(:,:,1));
subplot(312),imshow(lab(:,:,2));
subplot(313),imshow(lab(:,:,3));
%% HSV color space
hsv = rgb2hsv(i);
hsvf = figure(3),set(hsvf,'Name','HSV color space'),
subplot(311),imshow(hsv(:,:,1));
subplot(312),imshow(hsv(:,:,2));
subplot(313),imshow(hsv(:,:,3));
%% method test



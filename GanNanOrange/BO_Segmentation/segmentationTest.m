clc;clear all;
I = imread('QQͼƬ20180514101659.jpg');
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
gray = lab_he(:,:,3);
imshow(gray);
level = graythresh(gray);BW = im2bw(I,level);BW = ~BW;
imshow(BW);
addpath(genpath('C:\workspace-Matlab\gg\threshod'));
% example on real image
close all;
clear all;

%I = imread('test1.bmp');
%seg = chenvese(I,'whole',400,0.2,'multiphase'); 
%-- End
I = imread('.\image\1.png');
figure,imshow(I);
I = OTSU3(I);
seg = chenvese(I,'large',10000,0.02,'chan');

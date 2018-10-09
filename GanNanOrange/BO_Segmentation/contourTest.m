clc;clear all;
I=imread('QQͼƬ20180514101659.jpg');
hsi_i = rgb2hsi(I);
gray = hsi_i(:,:,1);

%{
gray1 = rgb2gray(I);
gray1 = I(:,:,2);
gray2 = rgb2hsi(I);
%gray2 = 0.6*gray2(:,:,1) + 0.4*gray2(:,:,2);
%gray2 = histeq(gray2);
[x y x] = size(gray2);
grayH = gray2(:,:,1);
grayS = gray2(:,:,2);
grayW = 0.6*gray2(:,:,1) + 0.4*gray2(:,:,2);
%}
%{
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
gray = lab_he(:,:,3);
%}
figure;
%subplot(221);imshow(I);
level = graythresh(gray);BW = im2bw(I,level);%�����䷽�
BW = ~BW;
subplot(221);imshow(BW);
se = strel('diamond', 8);
BW = imerode(BW, se);%��ʴ
subplot(222);imshow(BW);
[B L] = bwboundaries(BW);%��ȡ����
subplot(223);imshow(label2rgb(L, @jet, [.5 .5 .5]));
hold on
for k = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end%����ѭ����ʾ�������
IBW = bwlabel(BW, 8);
stats=regionprops(IBW,'Area');%������ͨ�������
areaArray = cell2mat(struct2cell(stats));
maxArea = max(areaArray);
BW = bwareaopen(BW, maxArea);%ɾ��С�������
subplot(224);imshow(BW);
BW = imdilate(BW, se);
%{
figure;
imshow(BW);
%}


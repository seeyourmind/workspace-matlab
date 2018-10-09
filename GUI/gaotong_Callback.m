function varargout=gaotong_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
axes(handles.axes1);
hold off;
imagesc(myImage);
colormap gray; axis off;  axis equal;

s=fftshift(fft2(myImage));
[a,b]=size(s); 
a0=round(a/2);
b0=round(b/2); 
w=10; 
for i=1:a
for j=1:b         
distance=sqrt((i-a0)^2+(j-b0)^2);         
if distance>=w/2 h=1;         
else h=0;         
end;         
m(i,j)=h*s(i,j);     
end; 
end; 
axes(handles.axes2);
imshow(m);
%m=uint8(real(ifft2(ifftshift(m))));  
m=ifft2(ifftshift(m));

 axes(handles.axes3);
imshow(s);
% colormap gray; axis off;  axis equal;


axes(handles.axes4);
% hold off;
imagesc(m);
% colormap gray; axis off;  axis equal;




% subplot(2,2,1); imshow(I);title('原图像');
% subplot(2,2,2); imshow(s); title('图像傅里叶变换所得频谱'); 
% subplot(2,2,3); imshow(m); title('滤波所得图像'); 
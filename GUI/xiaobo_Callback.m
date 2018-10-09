function varargout=xiaobo_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
axes(handles.axes1);
hold off;
imagesc(myImage);
colormap gray; axis off;  axis equal;

[cA,cH,cV,cD] = dwt2(myImage,'db1','mode','sym');


axes(handles.axes2);
imshow(cH);
% colormap gray; axis off;  axis equal;


axes(handles.axes3);
imagesc(cD);
% colormap gray; axis off;  axis equal;




% subplot(2,2,1); imshow(I);title('原图像');
% subplot(2,2,2); imshow(s); title('图像傅里叶变换所得频谱'); 
% subplot(2,2,3); imshow(m); title('滤波所得图像'); 
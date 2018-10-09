function varargout=salt_pepper_stew_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
axes(handles.axes1);
hold off;
imagesc(myImage);
colormap gray; axis off;  axis equal;

J1=imnoise(myImage,'gaussian',0.01);
axes(handles.axes2);
hold off;
imagesc(J1);
colormap gray; axis off;  axis equal;

function varargout=guss_stew_Callback(h, eventdata, handles)
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

% J2=imnoise(I1,'salt & pepper',0.02);
% PSF = fspecial('motion',20,45);
% J3 = imfilter(I1,PSF,'replicate');

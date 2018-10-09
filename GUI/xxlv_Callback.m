function varargout=xxlv_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
axes(handles.axes1);
hold off;
imagesc(myImage);
colormap gray; axis off;  axis equal;

s=myImage;
[a,b]=size(s); 

for i=2:a-2
for j=2:b-2
X=[s(i-1,j-1) s(i-1,j) s(i-1,j+1) s(i,j-1) s(i,j) s(i,j+1) s(i+1,j-1) s(i+1,j) s(i+1,j+1)];
w=round(median(X));
m(i,j)=w;
end; 
end; 

axes(handles.axes2);
imshow(m);
axis off;  axis equal;


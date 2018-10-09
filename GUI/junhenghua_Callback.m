function varargout=junhenghua_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
A=myImage;
% A=double(I);
[m,n]=size(A);
a = zeros(3,256);
for i=1:1:m
  for j=1:1:n
    a(1,A(i,j)+1)=a(1,A(i,j)+1)+1;  %统计
 end
end
for i=1:256
  a(1,i)=a(1,i)/(m*n);          %原图个点概率  1
end
for i=1:1:256
 if i==1 a(2,i)=a(1,i);
 else
a(2,i)=a(1,i)+a(2,i-1);     %原始累计直方图  2
end
end
for i=1:1:256
  a(3,i)=round(255*a(2,i)); %向下取整     3
end
for i=1:1:m
  for j=1:1:n
  B(i,j)=a(3,A(i,j)+1);
 end
end
P=uint8(B);
axes(handles.axes1);
hold off;
imagesc(A);
axes(handles.axes2);
hold off;
imagesc(imhist(A));
axes(handles.axes3);
hold off;
imagesc(P);
axes(handles.axes4);
hold off;
imagesc(imhist(P));
% subplot(2,2,1);imshow(I);
% subplot(2,2,2);imhist(I);
% subplot(2,2,3);imshow(P);
% subplot(2,2,4);imhist(P);


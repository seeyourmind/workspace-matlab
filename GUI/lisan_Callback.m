function varargout=lisan_Callback(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=open(h, eventdata, handles);
axes(handles.axes1);
hold off;
imagesc(myImage);
colormap gray; axis off;  axis equal;

s=dct2(myImage);
% [a,b]=size(s); 
% a0=round(a/2);
% b0=round(b/2); 
% w=10; 
% for i=1:a
% for j=1:b         
% distance=sqrt((i-a0)^2+(j-b0)^2);         
% if distance<=w/2 h=1;         
% else h=0;         
% end;         
% m(i,j)=h*s(i,j);     
% end; 
% end; 
%m=uint8(real(ifft2(ifftshift(m))));  
m=idct2(s);


axes(handles.axes2);
imshow(s);
% colormap gray; axis off;  axis equal;


axes(handles.axes3);
imagesc(m);
% colormap gray; axis off;  axis equal;




% subplot(2,2,1); imshow(I);title('Ô­Í¼Ïñ');
% subplot(2,2,2); imshow(s); title('Í¼Ïñ¸µÀïÒ¶±ä»»ËùµÃÆµÆ×'); 
% subplot(2,2,3); imshow(m); title('ÂË²¨ËùµÃÍ¼Ïñ'); 
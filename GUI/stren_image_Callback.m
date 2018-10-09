function varargout=stren_image_Callback(h, eventdata, handles)
[fileName,pathName]=uigetfile('*.jpg;*.jpeg;*.tif;*.tiff;*.bmp;*.png;*.pcx','Select an Image');
if fileName==0
   [fileName,pathName]=uigetfile('*.jpg;*.jpeg;*.tif;*.tiff;*.bmp;*.png;*.pcx','Select an Image');
else
   PF=[pathName,fileName];
   ext=PF(findstr(PF,'.')+1:end);
   PFinfo=imfinfo(PF);
   if strcmp(PFinfo.ColorType,'truecolor')>0
      myImage=imread(PF);
      myImage=mean(myImage,3);       
   elseif strcmp(PFinfo.ColorType,'grayscale')>0
      myImage=imread(PF);
   elseif strcmp(PFinfo.ColorType,'indexed')>0
      [myImage,MAP]=imread(PF);
      myImage =ind2gray(myImage,MAP);
   end
end

a=80;         %图像变换参数设定
b=130;
Mf=255;
c=50;
d=200;
Mg=255;
A=myImage;
% A=imread('rice.png','png');         %读入图像
[m,n]=size(A);
for i=1:1:m                %灰度调整
    for j=1:1:n
       if A(i,j)<a
            B(i,j)=(c/a)*A(i,j);
        elseif (A(i,j)>=a)&(A(i,j)<b)
            B(i,j)=(A(i,j)-a)*(d-c)/(b-a)+c;
        else
            B(i,j)=(A(i,j)-b)*(Mg-d)/(Mf-b)+d;
        end
    end
end
uint8(A);    uint8(B);
% imwrite(B,'fig21.png');            %图像保存
% subplot(2,2,1);   imshow(A);    %显示调整前后图像及其直方图
% subplot(2,2,2);   imshow(B);
% subplot(2,2,3);   plot([0,a,b,Mf],[0,c,d,Mg],'r');
axes(handles.axes1);
hold off;
imagesc(A);
axes(handles.axes2);
hold off;
imagesc(B);
axes(handles.axes3);
hold off;
plot([0,a,b,Mf],[0,c,d,Mg],'r')
% imagesc(plot([0,a,b,Mf],[0,c,d,Mg],'r'));
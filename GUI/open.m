function [fileName,pathName]=open(h, eventdata, handles)
global myImage imageSize fg dilationWidth fileName;
[fileName,pathName]=uigetfile('*.jpg;*.jpeg;*.tif;*.tiff;*.bmp;*.png;*.pcx','Select an Image');
if fileName==0
  if ~exist('myImage','var')
       myImage=[]; 
   end
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
imageSize=size(myImage);
if max(imageSize)>256
    myImage=imresize(myImage,256/max(imageSize),'bilinear');
    imageSize=size(myImage);
end
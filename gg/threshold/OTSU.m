function [ oo, levelo, object, background ] = OTSU( im )
%OTSU 最大类间方差法
%   im:待处理图片 oo:处理后图片 levelo:阈值
    object = im;
    background = im;
    
    [x,y,z] = size(im);
    if z~=1
        oo = rgb2gray(im);
    else
        oo = im;
    end
    levelo = graythresh(oo);
    levelo = floor(levelo*256);
    [m,n] = size(oo);
    for a=1:m;
       for b=1:n;
           if oo(a,b)>=levelo;
               oo(a,b)=0;
               object(a,b,1) = 0;
               object(a,b,2) = 0;
               object(a,b,3) = 0;
           else
               oo(a,b)=255;
               background(a,b,1) = 0;
               background(a,b,2) = 0;
               background(a,b,3) = 0;
           end
       end
    end
end   
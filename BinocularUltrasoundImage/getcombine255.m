function [ imgsrc ] = getcombine255( imgsrc, img1, img2 )
%GETCOMBINE255 此处显示有关此函数的摘要
%   此处显示详细说明
    [m n c] = size(imgsrc);
    [m1 n1 c1] = size(img1);
    [m2 n2 c2] = size(img2);
    if c~=1 || c1~=1 || c2~=1
        error('please mark sure you input the gray image for each parameter!');
    end
    if m~=m1 || m~=m2 || m1~=m2
        error('please mark sure you input parameters have same size!');
    end
    for i=1:m
        for j=1:n
            if imgsrc(i,j)==255 && img1(i,j)~=255 && img2(i,j)~=255
                imgsrc(i,j)=255;
            else
                imgsrc(i,j)=0;
            end
        end
    end
end


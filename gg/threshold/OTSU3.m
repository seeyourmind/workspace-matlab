function [ object, background ] = OTSU3( img )
%OTSU3 此处显示有关此函数的摘要
%   此处显示详细说明
    background = img;
    object = img;
    J = img;
    R = J(:,:,1);
    G = J(:,:,2);
    B = J(:,:,3);
    
    G = DynamicMean(G);
    R = DynamicMean(R);
    B = DynamicMean(B);
    
    [or,rt] = OTSU(R);
    [og,gt] = OTSU(G);
    [ob,bt] = OTSU(B);
    
    [m,n] = size(or);

    for i=1:m
        for j=1:n
            if or(i,j)==og(i,j)&&or(i,j)==ob(i,j)&&or(i,j)==255
                background(i,j,1) = 0;
                background(i,j,2) = 0;
                background(i,j,3) = 0;
            else
                object(i,j,1) = 0;
                object(i,j,2) = 0;
                object(i,j,3) = 0;
            end
        end
    end
    
end


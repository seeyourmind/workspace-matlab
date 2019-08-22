function [ xy ] = getpoints( img )
%GETPOINTS 此处显示有关此函数的摘要
%   此处显示详细说明
    [rows cols] = find(img==255);
    points = [rows cols];
    x1 = points(find(points(:,1)==min(rows)),:);
    x1 = x1(1,:);
    x2 = points(find(points(:,1)==max(rows)),:);
    x2 = x2(1,:);
    x3 = points(find(points(:,2)==min(cols)),:);
    x3 = x3(1,:);
    x4 = points(find(points(:,2)==max(cols)),:);
    x4 = x4(1,:);
    xy = [x1;x4;x2;x3;x1];

end


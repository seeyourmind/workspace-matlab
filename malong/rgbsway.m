function [ proprotion ] = rgbsway( img1, img2, name )
%GETMOVEDTHINGPLUS 此处显示有关此函数的摘要
%   此处显示详细说明
    %% 读取图片
    img_a = imread(img1);
    img_b = imread(img2);
    %% 取灰度图像
    ab_a = double(rgb2gray(img_a));
    ab_b = double(rgb2gray(img_b));
    row = size(ab_a, 1);
    col = size(ab_a, 2);
    %% 计算两张图的欧氏距离
    ab_a_re = reshape(ab_a, row*col, 1);
    ab_b_re = reshape(ab_b, row*col, 1);
    ab_c_re = zeros(row*col, 1);
    for i=1:row*col
        for j=1
            %ab_c_re(i,j) = nthroot(power(ab_a_re(i,j)-ab_b_re(i,j), 2), 2);
            ab_c_re(i,j) = sqrt((ab_a_re(i,j)-ab_b_re(i,j))^2);
        end
    end
    %% 使用Kmeans分类
    kc = 2;
    [cluster_idx cluster_center] = kmeans(ab_c_re,kc,'distance','sqEuclidean', ...
                                          'Replicates',3);
    %% 定位
    pixel_labels = reshape(cluster_idx,row,col);
    % Create RGB label using pixel_labels
    rgb_label = repmat(pixel_labels,[1,1,3]);
    % 读取分类，并在原图中标记
    colors = img_a;
    points_white = length(find(rgb_label==kc));
    points_black = length(find(rgb_label~=kc));
    if points_white < points_black
        proprotion = points_white/points_black;
        if proprotion < 0.1
            colors(rgb_label ~= kc) = 0;
            colors(rgb_label == kc) = 255;
        else
            colors(:,:,:) = 255;
        end
    else
        temp = points_white;
        points_white = points_black;
        points_black = temp;
        proprotion = points_white/points_black;
        if proprotion < 0.1
            colors(rgb_label ~= kc) = 255;
            colors(rgb_label == kc) = 0;
        else
            colors(:,:,:) = 255;
        end
    end
    segmented_images = colors;
    figure('name',name,'Numbertitle','off'),
    imshow(segmented_images);
end

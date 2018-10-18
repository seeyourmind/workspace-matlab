function getmovedthing( img1, img2, name )
%GET �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    %% ��ȡͼƬ
    img_a = imread(img1);
    img_b = imread(img2);
    %% ת����ɫ�ռ�ΪLAB
    cform = makecform('srgb2lab');
    lab_a = applycform(img_a, cform);
    lab_b = applycform(img_b, cform);
    %% ȡABͨ��
    ab_a = double(lab_a(:,:,2:3));
    ab_b = double(lab_b(:,:,2:3));
    row = size(ab_a, 1);
    col = size(ab_a, 2);
    %% ��������ͼ��ŷ�Ͼ���
    ab_a_re = reshape(ab_a, row*col, 2);
    ab_b_re = reshape(ab_b, row*col, 2);
    ab_c_re = zeros(row*col, 2);
    for i=1:row*col
        for j=1:2
            %ab_c_re(i,j) = nthroot(power(ab_a_re(i,j)-ab_b_re(i,j), 2), 2);
            ab_c_re(i,j) = sqrt((ab_a_re(i,j)-ab_b_re(i,j))^2);
        end
    end
    %% ʹ��Kmeans����
    kc = 2;
    [cluster_idx cluster_center] = kmeans(ab_c_re,kc,'distance','sqEuclidean', ...
                                          'Replicates',3);
    %% ��λ
    pixel_labels = reshape(cluster_idx,row,col);
    segmented_images = cell(1,kc);
    % Create RGB label using pixel_labels
    rgb_label = repmat(pixel_labels,[1,1,3]);

    for k = 1:kc
        colors = img_a;
        colors(rgb_label ~= k) = 0;
        colors(rgb_label == k) = 255;
        segmented_images{k} = colors;
    end
    figure('name',name,'Numbertitle','off'),
    imshow(segmented_images{2});
    %subplot(122),imshow(segmented_images{1});
    %subplot(133),imshow(segmented_images{3});
    count_img = segmented_images{2};
    [m n] = size(count_img);
    white_points = 0;
    black_points = 0;
    for i=1:m
        for j=1:n
            if count_img(i,j) == 0
                black_points = black_points + 1;
            else
                white_points = white_points + 1;
            end
        end
    end
end


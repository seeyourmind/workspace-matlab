clear all; close all; clc;
%% 参数配置
FOCUS = 80.0;
BASELINE = 6.0;
alpha = 0.2;
%% 读取、缩放图像
il = imread('图片1l.png');
ir = imread('图片1r.png');
ics = imread('cs.png');
il = imresize(il, [400,400]);
ir = imresize(ir, [400,400]);
ics = imresize(ics, [200, 200]);
%% 确定探头位置
igL = probe(il);
igR = probe(ir);
xyL = getpoints(igL);
xyR = getpoints(igR);
%% 计算超声平面方程
[coors3d onePlex] = plex2camera(xyL, xyR, size(il,1), size(il,2));
[U S V] = svd(coors3d);
%% 计算超声融合矩阵
uv = zeros(size(ics));
for i = 1:size(ics,2)
    for j=1:size(ics,1)
        x = onePlex*i;
        y = onePlex*j;
        z = -(V(1,4)*x+V(2,4)*y+V(4,4))/V(3,4);
        uv(j,i,1) = abs(FOCUS*x/z);
        uv(j,i,2) = abs(FOCUS*(x-BASELINE)/z);
        uv(j,i,3) = abs(FOCUS*y/z);
    end
end
%% 超声融合
start_x = xyL(1,1);
start_y = xyL(1,2);
dst_img = zeros(size(il));
for i=1:size(uv,1)
    for j=1:size(uv,2)
        u = round(uv(i,j,1) - uv(i,j,3) + start_x)<0;
        if u<=0 
            u=1; 
        end
        v = round(uv(i,j,1) + uv(i,j,3) + start_y);
        fprintf('u=%d, \tv=%d\n',u,v);
        dst_img(u,v,:) = ics(i,j,:);
    end
end
subplot(221),imshow(il);
subplot(222),imshow(ics);
subplot(223),hold on,imshow(igR),plot(xyL(:,2),xyL(:,1)),plot(xyR(:,2),xyR(:,1)),hold off;
subplot(224),imshow(dst_img);



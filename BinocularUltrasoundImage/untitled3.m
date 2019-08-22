clear all; close all; clc;
%{
cs = imread('cs.png');
%imshow(cs);
alpha = 0.0;
alpha_ = -pi*10/180;
[m,n,c] = size(cs);
x = zeros(m,n);
y = zeros(m,n);
for i=1:m
    for j=1:n
        if(j-1==0)
            alpha = pi*0/180;
        elseif(i-1==0)
            alpha = pi*90/180;
        else
            alpha = atan(((j-1)*1.0)/(i-1));
        end
        d = sqrt(power(i-1,2)+power(j-1,2));
        x(i,j) = d*cos(alpha+alpha_);
        y(i,j) = d*sin(alpha+alpha_);
    end
end
x_length = max(max(x))-min(min(x));
y_length = max(max(y))-min(min(y));
for i=1:m
    for j=1:n
        x(i,j) = round(n*x(i,j)/x_length);
        y(i,j) = round(m*y(i,j)/y_length);
    end
end
cs_ = imresize(cs,[m*2,n*2]);
y0 = m;
x0 = floor(n-n/2);
for i=1:m
    for j=1:n
        x_ = x0+x(i,j);
        x__ = floor(x_);
        if(x__<0)
            x__=0;
        end
        y_ = y0+y(i,j);
        y__ = floor(y_);
        if(y__<0)
            y__=0;
        end
        cs_(y__+1,x__+1,1) = cs(i,j,1);
        cs_(y__+1,x__+1,2) = cs(i,j,2);
        cs_(y__+1,x__+1,3) = cs(i,j,3);
        %cs_(i,j,2) = 255;
    end
end
imshow(cs_);
%}
%% 读取超声、背景和遮罩
cs = imread('siatcs_copy.png');
%background = imread('imgl.png');
background = imread('jpg2.jpg');
%background = imresize(background, 0.1);
h = figure(1),
set(h,'name','原始图像','Numbertitle','off'), 
imshow(background),hold on
scatter(86,186,'r');
hold off
%
cs_sector = imread('siatcs_sector_copy.png');
cs_sector = rgb2gray(cs_sector);
csresize = 340;
cs = imresize(cs,[csresize,csresize]);
cs_sector = imresize(cs_sector, [csresize,csresize]);
[m,n,c] = size(cs);
%
%% 像素点转相机
%plexesL = [[112.51936, 112.45586];[109.48787, 104.68765];[191.86888, 72.538971]];
%plexesR = [[93.622993, 112.60995];[90.510231, 104.76581];[172.68176, 72.158051]];
plexesL = [[99.654816,150.16751];[94.651764,141.72487];[215.5076,70.106598]];
plexesR = [[69.139099,150.25458];[64.118835,141.8511];[185.14618,69.549042]];
cameraL = zeros(3,4);
cameraR = zeros(3,4);
[h, w, c] = size(background);
u0 = w/2;
v0 = h/2;
oneplex = 10.0/15.0;
baseline = 6.0;
focus = 80.0;
for i=1:3
    delta = oneplex*(plexesL(i,1) - plexesR(i,1));
    cameraL(i,1)=oneplex*baseline*(plexesL(i,1)-u0)/delta;
    cameraL(i,2)=oneplex*baseline*(plexesL(i,2)-v0)/delta;
    cameraL(i,3)=baseline*focus/delta;
    cameraL(i,4) = 1.0;
    cameraR(i,1)=oneplex*baseline*(plexesR(i,1)-u0)/delta;
    cameraR(i,2)=oneplex*baseline*(plexesR(i,2)-v0)/delta;
    cameraR(i,3)=baseline*focus/delta;
    cameraL(i,4) = 1.0;
end
%% 求平面方程的四个坐标系数
factors = null(cameraL);
factors = factors/factors(4);
factors = [-0.0044, 0.0006, -0.0112, 1];

%% 平面坐标
panel_x = zeros(1,n);
panel_y = zeros(m,1);
panel_z = zeros(m,n);
oneplexforcamera = (cameraL(1,1)-cameraL(2,1))/(plexesL(1,1)-plexesL(2,1));
for i=1:m
    for j=1:n
        panel_x(1,j) = oneplexforcamera*(j-1);
        panel_y(i,1) = oneplexforcamera*(i-1);
        panel_z(i,j) = -(factors(1)*oneplexforcamera*(j-1)+factors(2)*oneplexforcamera*(i-1)+factors(4))/factors(3);
    end
end
h = figure(2),
set(h,'name','平面坐标（相机坐标系）','Numbertitle','off'),
plot3(panel_x, panel_y, panel_z);
%% 像素坐标
plex_u_l = zeros(m,n);
plex_u_r = zeros(m,n);
plex_v = zeros(m,n);
for i=1:m
    for j=1:n
        plex_u_l(i,j) = focus*panel_x(j)/panel_z(i,j);
        plex_u_r(i,j) = focus*(panel_x(j)-baseline)/panel_z(i,j);
        plex_v(i,j) = focus*panel_y(i)/panel_z(i,j);
    end
end
h=figure(3),
set(h,'name','平面坐标（像素坐标系）','Numbertitle','off'),
scatter(reshape(plex_u_l,1,m*n), reshape(plex_v,m*n,1),1);
%
%% 标准化
plex_u_l_length = max(max(plex_u_l))-min(min(plex_u_l));
plex_v_length = max(max(plex_v))-min(min(plex_v));
for i=1:m
    for j=1:n
        plex_u_l(i,j) = n*plex_u_l(i,j)/plex_u_l_length;
        plex_v(i,j) = m*plex_v(i,j)/plex_v_length;
    end
end
h=figure(4),
set(h,'name','标准化平面坐标（像素坐标系）','Numbertitle','off'),
scatter(reshape(plex_u_l,1,m*n), reshape(plex_v,m*n,1),1);
%
%% 求融合坐标
alpha = 0.0;
alpha_ = pi*(30)/180;
[m,n,c] = size(cs);
x = zeros(m,n);
y = zeros(m,n);
z = uint8(zeros(m,n,3));
z_ = background;
for i=1:m
    for j=1:n
        if(j-1==0)
            alpha = pi*0/180;
        elseif(i-1==0)
            alpha = pi*90/180;
        else
            %alpha = atan(((j-1)*1.0)/(i-1));
            alpha = atan(plex_u_l(i,j)/plex_v(i,j));
        end
        d = sqrt(power(plex_u_l(i,j),2)+power(plex_v(i,j),2));
        x(i,j) = d*cos(alpha-alpha_);
        y(i,j) = d*sin(alpha-alpha_);
    end
end
%
%% 标准化坐标值
x_length = max(max(x))-min(min(x));
y_length = max(max(y))-min(min(y));
for i=1:m
    for j=1:n
        %x(i,j) = floor(x(i,j));
        %y(i,j) = floor(y(i,j));
        x(i,j) = n*x(i,j)/x_length;
        y(i,j) = m*y(i,j)/y_length;
    end
end
%
%% 叠加超声
y0 = 218;%132;%49-40;%50
x0 = 44;%169-30;%140
for i=1:m
    for j=1:n
        x_ = floor(x0+x(i,j));
        if(x_<0)
            x_=0;
        end
        y_ = floor(y0+y(i,j));
        if(y_<0)
            y_=0;
        end
        % 根据遮罩判断
        if(cs_sector(i,j)==255)
            z_(x_+1,y_+1,1)= 0.8*background(x_+1,y_+1,1)+0.7*cs(i,j,1);
            z_(x_+1,y_+1,2)= 0.8*background(x_+1,y_+1,2)+0.7*cs(i,j,2);
            z_(x_+1,y_+1,3)= 0.8*background(x_+1,y_+1,3)+0.7*cs(i,j,3);
            %{
            z_(x_+1,y_+1,1)= 0.6*background(x_+1,y_+1,1)+0.4*cs(i,j,1);
            z_(x_+1,y_+1,2)= 0.6*background(x_+1,y_+1,2)+0.4*cs(i,j,2);
            z_(x_+1,y_+1,3)= 0.6*background(x_+1,y_+1,3)+0.4*cs(i,j,3);
            %}
            z(i,j,1)= 0.6*background(x_+1,y_+1,1)+0.4*cs(i,j,1);
            z(i,j,2)= 0.6*background(x_+1,y_+1,2)+0.4*cs(i,j,2);
            z(i,j,3)= 0.6*background(x_+1,y_+1,3)+0.4*cs(i,j,3);
            %{
            temp1 = 1.0*double(background(x_+1,y_+1,1))+0.9*double(cs(i,j,1));
            temp2 = 1.0*double(background(x_+1,y_+1,2))+0.9*double(cs(i,j,2));
            temp3 = 1.0*double(background(x_+1,y_+1,3))+0.9*double(cs(i,j,3));
            if round(temp1)<=255 && round(temp2)<=255 && round(temp3)<=255
                background(x_+1,y_+1,1) = round(temp1);
                background(x_+1,y_+1,2) = round(temp2);
                background(x_+1,y_+1,3) = round(temp3);
            else
                background(x_+1,y_+1) = 255;
                background(x_+1,y_+1,2) = 255;
                background(x_+1,y_+1,3) = 255;
            end
            %}
            %{
            background(x_+1,y_+1,1) = 0.6*background(x_+1,y_+1,1)+0.4*cs(i,j,1);
            background(x_+1,y_+1,2) = 0.6*background(x_+1,y_+1,2)+0.4*cs(i,j,2);
            background(x_+1,y_+1,3) = 0.6*background(x_+1,y_+1,3)+0.4*cs(i,j,3);
            %
            background(y_+1,x_+1,1) = cs(i,j,1);
            background(y_+1,x_+1,2) = cs(i,j,2);
            background(y_+1,x_+1,3) = cs(i,j,3);
            %}
        end
        %cs_(i,j,2) = 255;
    end
end
%{
figure,
subplot(131),imshow(background(:,:,1));
subplot(132),imshow(background(:,:,2));
subplot(133),imshow(background(:,:,3));
figure,imshow(background);
%}
h = figure(4),
set(h, 'name', '融合图', 'Numbertitle', 'off'),
%subplot(121),imshow(z);
%subplot(122),imshow(z_);
imshow(z_);
imwrite(z_,'822Ldone.png');
%{
subplot(221),imshow(background(:,:,1));
subplot(222),imshow(background(:,:,2));
subplot(223),imshow(background(:,:,3));
subplot(224),imshow(background);
%}
%xlswrite('z-mat.xlsx',z(:,:,3),5);
%imwrite(background, 'img3l_fusion.png');
%}
%{
for i=1:m
    for j=1:n
        %background(i,j,1) = 0.5*background(i,j,1)+0.5*cs(i,j,1);
        %{
        background(i,j,1) = 0.5*background(i,j,1)+0.5*cs(i,j,1);
        background(i,j,2) = 0.5*background(i,j,2)+0.5*cs(i,j,2);
        background(i,j,3) = 0.5*background(i,j,3)+0.5*cs(i,j,3);
        %}
    end
end
imshow(background);
%}

            
        
function fg=get_fg_directional(small_window)

% The algorithm parameters:
% 1. Parameters of edge detecting filters:
%    X-axis direction filter:
     Nx1=3;Sigmax1=1;Nx2=5;Sigmax2=1;Theta1=pi/2;
%    Y-axis direction filter:
     Ny1=3;Sigmay1=1;Ny2=5;Sigmay2=1;Theta2=0;
% 2. The thresholding parameter alfa:
     alfa=0.1;
%figure(5);
%colormap gray;
%hold off;
% X-axis direction edge detection
%subplot(3,1,1);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(small_window,filterx,'same');
%imagesc(Ix);
%title('Ix');

% Y-axis direction edge detection
%subplot(3,1,2)
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(small_window,filtery,'same'); 
%imagesc(Iy);
%title('Iy');

my_size=size(small_window);
% Norm of the gradient (Combining the X and Y directional derivatives)
%subplot(3,1,3);
NVIx=abs(Ix);
NVIy=abs(Iy);
NVIxx=abs(0.707*(Ix-Iy));
NVIyy=abs(0.707*(Ix+Iy));
%imagesc(NVI);
%title('Norm of Gradient');
%fg=ones(my_size(1),my_size(2))-NVI/max(max(NVI));
fg(:,:,1)=exp(-NVIx/max(max(NVIx)));
fg(:,:,2)=exp(-NVIy/max(max(NVIy)));
fg(:,:,3)=exp(-NVIxx/max(max(NVIxx)));
fg(:,:,4)=exp(-NVIyy/max(max(NVIyy)));
NVI=sqrt(Ix.*Ix+Iy.*Iy);
fg(:,:,5)=exp(-NVI/max(max(NVI)));

% This function returns a 2D edge detector (first order derivative
% of 2D Gaussian function) with size n1*n2; theta is the angle that
% the detector rotated counter clockwise; and sigma1 and sigma2 are the
% standard deviation of the Gaussian functions.
function h = d2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        u = r * [j-(n1+1)/2 i-(n2+1)/2]';
        h(i,j) = gauss(u(1),sigma1)*dgauss(u(2),sigma2);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));

function h = dd2dgauss(n1,sigma1,n2,sigma2,theta)
r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        u = r * [j-(n1+1)/2 i-(n2+1)/2]';
        h(i,j) = gauss(u(1),sigma1)*ddgauss(u(2),sigma2);
    end
end
h = h / sqrt(sum(sum(abs(h).*abs(h))));

function y = ddgauss(x,std)
y = -x *dgauss(x,std) / std^2 - gauss(x,std) / std^2;


function y = dgauss(x,std)
y = -x * gauss(x,std) / std^2;

function y = gauss(x,std)
y = exp(-x^2/(2*std^2)) / (std*sqrt(2*pi));
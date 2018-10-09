% This code is used to generate the 3D object segmentation results
% The input will be a binary volume including an object inside, the voxels of the object is 1, and the background is 0.

clear;
load object3D1; % This .mat file contains a 3D matrix object3D

% Initial boundary is a sphere
minX=min(find(sum(sum(object3D,3),2)));
maxX=max(find(sum(sum(object3D,3),2)));
minY=min(find(sum(sum(object3D,3),1)));
maxY=max(find(sum(sum(object3D,3),1)));
minZ=min(find(sum(sum(object3D,2),1)));
maxZ=max(find(sum(sum(object3D,2),1)));

% radius 
radius=max([maxX-minX, maxY-minY, maxZ-minZ])+2; 

% center
center=round([(maxX+minX)/2,(maxY+minY)/2,(maxZ+minZ)/2]);

% size of the volume
vSize=size(object3D);

initialSphere=zeros(vSize);
for i=1:vSize(1)
    if abs(center(1)-i)<=radius
        localRadius=sqrt(radius^2-(center(1)-i)^2);
        for j=1:round(2*pi*localRadius)+1
            deltaY=localRadius*sin(j/localRadius);
            deltaZ=localRadius*cos(j/localRadius);
            initialSphere(i,round(center(2)+deltaY),round(center(3)+deltaZ))=1;
        end
    end
end


                        

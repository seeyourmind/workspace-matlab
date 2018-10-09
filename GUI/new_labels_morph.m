%This program is using dilation to find the outer shape and inner shape of the boundary
%The difference between this function and labels_morph is that the times can be decided here
%as m, so m is half of the width of the belt.

function [labels,collapsed]=new_labels_morph(bw,m)

old_bw=bw;
image_size=size(bw);
se=[0 0 1 1 1 0 0
    0 1 1 1 1 1 0
    1 1 1 1 1 1 1
    1 1 1 1 1 1 1
    1 1 1 1 1 1 1
    0 1 1 1 1 1 0
    0 0 1 1 1 0 0];

for i=1:m
    bw=imdilate(bw,se);
end

labels=bw;

bw1=bwfill(bw,1,1,8);

seedx=0;
seedy=0;
flag=0;
inner_flag=0;
for i=2:image_size(1)-1
    for j=2:image_size(2)-1
        if bw1(i,j)==1 & (bw1(i-1,j)==0 |bw1(i,j-1)==0|bw1(i,j+1)==0|bw1(i+1,j)==0)
            labels(i,j)=2;
            inner_flag=1;
        end
        if bw1(i,j)==0 & flag==0
            seedx=i;
            seedy=j;
            flag=1;
        end
    end
end

if seedx>0 
    bw2=bwfill(bw,seedy,seedx,8);
else
    bw2=bw;
end

for i=2:image_size(1)-1
    for j=2:image_size(2)-1
        if bw2(i,j)==1 & (bw2(i-1,j)==0 |bw2(i,j-1)==0|bw2(i,j+1)==0|bw2(i+1,j)==0)
            labels(i,j)=3;
        end
    end
end

%if the result is too small
collapsed=0;
if inner_flag==0
    bw3=bwfill(old_bw,1,1,8);
    old_bw=0*old_bw;
    for i=2:image_size(1)-1
        for j=2:image_size(2)-1
            if bw3(i,j)==0 & (bw3(i-1,j)==1 |bw3(i,j-1)==1|bw3(i,j+1)==1|bw3(i+1,j)==1)
                old_bw(i,j)=1;
        
            elseif bw3(i,j)==0 
                old_bw(i,j)=-1;
            end
        end
    end
    labels=(double(labels)+double(old_bw));
    collapsed=1;
end

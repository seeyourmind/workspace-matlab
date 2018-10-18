clear all; clc;
img_a_s = dir('same/*-1.jpg');
img_b_s = dir('same/*-2.jpg');
proprotions = {};
for i=1:length(img_a_s)
    file_a = [img_a_s(i).folder, '\', img_a_s(i).name];
    file_b = [img_b_s(i).folder, '\', img_b_s(i).name];
    proprotions{i, 1} = getmovedthingplus(file_a, file_b, img_a_s(i).name);
    proprotions{i, 2} = img_a_s(i).name;
end

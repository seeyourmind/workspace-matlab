function varargin=������(h, eventdata, handles, varargin)  %��������Ҫ��Ӣ�ĸ�д 
%�˴������㷨����clear \clear all\clc������ɾ��
%***************************************************************

%***************************************************************

%***************************************************************

axes(handles.axes1);
imagesc(img);       %ͼ����ʾ��������1��  imgΪͼ��洢����

axes(handles.axes2);
imagesc(img);       %ͼ����ʾ��������2��  imgΪͼ��洢����

axes(handles.axes3);
imagesc(img);    %ͼ����ʾ��������3��  imgΪͼ��洢����        

axes(handles.axes4);
imagesc(img);       %ͼ����ʾ��������4��  imgΪͼ��洢����

edit(new_transform.m);%�༭ �����ú����Ͳ˵�����
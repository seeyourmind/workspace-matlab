function varargin=new_transform(h, eventdata, handles, varargin)
edit;%���㷨�༭
name=get(handles.edit_name,'String');
str1=name;
str2='(gcbo,[],guidata(gcbo))';
str=[str1,str2];
new_transform=uimenu(gcf,'Label',name,'callback',str);
% new_transform=uicontrol('style','pushbutton');
% set(new_transform,'Label',name,'callback',str);


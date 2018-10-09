function varargout = interface(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

b1=imread('1.jpg');
a1=imread('2.jpg');
c1=imread('3.jpg');
d1=imread('4.jpg');
e1=imread('5.jpg');
f1=imread('6.jpg');
g1=imread('7.jpg');
h1=imread('8.jpg');
i1=imread('9.jpg');
j1=imread('10.jpg');
k1=imread('11.jpg');
l1=imread('12.jpg');
m1=imread('13.jpg');
n1=imread('14.jpg');

set(handles.pushbutton_load,'CData',a1);
set(handles.pushbutton2,'CData',b1);
set(handles.pushbutton3,'CData',c1);
set(handles.pushbutton4,'CData',d1);
set(handles.pushbutton5,'CData',e1);
set(handles.pushbutton6,'CData',f1);
set(handles.pushbutton7,'CData',g1);
set(handles.pushbutton8,'CData',h1);
set(handles.pushbutton9,'CData',i1);
set(handles.pushbutton10,'CData',j1);
set(handles.pushbutton21,'CData',k1);
set(handles.pushbutton22,'CData',l1);
set(handles.pushbutton_gcbac,'CData',m1);
set(handles.pushbutton_growcut,'CData',n1);

% set(gcf,'menubar','none');%
% file=uimenu(gcf,'Label','文件');%uimenu uicontrol§ìì§§§
% change=uimenu(gcf,'Label','图像变换');
% stren=uimenu(gcf,'Label','图像增强');
% recover=uimenu(gcf,'Label','图像恢复');
% graphcut=uimenu(gcf,'Label','图像分割');
% help=uimenu(gcf,'Label','help');
% 
% 
% new=uimenu(file,'Label','新建');
% Mfile=uimenu(new,'Label','&M-File','Callback','edit');
% open=uimenu(file,'Label','打开');
% Ofile=uimenu(open,'Label','M-open','callback','interface(''loadImage_Callback'',gcbo,[],guidata(gcbo))');
% exit=uimenu(file,'Label','退出','Callback','exit');
% 
% 
% fuliye=uimenu(change,'Label','傅里叶变换','callback','interface(''pushbutton3_fft_Callback'',gcbo,[],guidata(gcbo))');
% xiaobo=uimenu(change,'Label','小波变换','callback','interface(''pushbutton4_xiaobo_Callback'',gcbo,[],guidata(gcbo))');
% lisan=uimenu(change,'Label','离散变换','callback','interface(''pushbutton5_lisan_Callback'',gcbo,[],guidata(gcbo))');
% 
% junhenghua=uimenu(stren,'Label','均衡化','callback','interface(''pushbutton_junhenhua_Callback'',gcbo,[],guidata(gcbo))');
% kongyulvbo=uimenu(stren,'Label','空域滤波');%%
% xianxinglvbo=uimenu(kongyulvbo,'Label','线性滤波');%%
% Xpinghua=uimenu(xianxinglvbo,'Label','线性平滑滤波');
% Xruihua=uimenu(xianxinglvbo,'Label','线性锐化滤波');
% Fxianxinglvbo=uimenu(kongyulvbo,'Label','非线性滤波');%%
% Fpinghua=uimenu(Fxianxinglvbo,'Label','非线性平滑滤波');
% Fruihua=uimenu(Fxianxinglvbo,'Label','非线性锐化滤波');
% pingyulvbo=uimenu(stren,'Label','频域滤波');
% ditonglvbo=uimenu(pingyulvbo,'Label','低通滤波','callback','interface(''pushbutton21_ditong_Callback'',gcbo,[],guidata(gcbo))');
% gaotonglvbo=uimenu(pingyulvbo,'Label','高通滤波','callback','interface(''pushbutton22_gaotong_Callback'',gcbo,[],guidata(gcbo))');
% 
% 
% 
% gcbac=uimenu(graphcut,'Label','动态轮廓检测','Callback','interface(''initialization_Callback'',gcbo,[],guidata(gcbo))');
% growcut=uimenu(graphcut,'Label','前景背景区分');


myImage=imread('DAME_FLOWER.jpg');
axes(handles.axes2);
imagesc(myImage);

myImage=imread('DAME_EAGLE.jpg');
axes(handles.axes3);
imagesc(myImage);

myImage=imread('DAME_PEPPERS.jpg');
axes(handles.axes4);
imagesc(myImage);
% axes(handles.axes3);
% imagesc('DAME_EAGLE.jpg');
% 
% axes(handles.axes4);s
% imagesc('DAME_PEPPER');

function varargout = interface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function varargout = loadImage_Callback(h, eventdata, handles, varargin) %2
global myImage imageSize fg dilationWidth fileName;                      %myimage  imageSize fg dilationWidth fileName
%pause(3);3
[fileName,pathName]=uigetfile('*.jpg;*.jpeg;*.tif;*.tiff;*.bmp;*.png;*.pcx','Select an Image');%ìì§

if fileName==0       %fileNameuigetfileìì§ìì
   if ~exist('myImage','var')
       myImage=[]; 
   end
else
   PF=[pathName,fileName];
   ext=PF(findstr(PF,'.')+1:end);% png,figext findstr
   PFinfo=imfinfo(PF);%PFinfo
   if strcmp(PFinfo.ColorType,'truecolor')>0  %§ìì
      myImage=imread(PF);
      myImage=mean(myImage,3);       %
   elseif strcmp(PFinfo.ColorType,'grayscale')>0
      myImage=imread(PF);
   elseif strcmp(PFinfo.ColorType,'indexed')>0
      [myImage,MAP]=imread(PF);
      myImage =ind2gray(myImage,MAP);%
   end
end

imageSize=size(myImage);
if max(imageSize)>256
    myImage=imresize(myImage,256/max(imageSize),'bilinear');%256  imresizeAMììB
    imageSize=size(myImage);
end
axes(handles.axes1);
hold off;
imagesc(myImage);%
colormap gray; axis off;  axis equal;%???
fg=get_fg_directional(myImage);

%**********************************************************
function varargout = replay_Callback(h, eventdata, handles, varargin)
global M;
replaySetting=[1 1 1 1:length(M)];
%set(handles.status,'String',' Replaying the deformation of the active contour ...');
movie(handles.axes1,M,replaySetting,4);
% set(handles.status,'String',' ');

%****************************************************************
function varargout = initialization_Callback(h, eventdata, handles, varargin)
global myImage imageSize initBW bw fileName;
if fileName==0       %fileNameuigetfileìì§ìì
   if ~exist('myImage','var')
       myImage=[]; 
   end
end
axes(handles.axes1);
imagesc(myImage);
colormap gray; axis off;  axis equal;
% set(handles.status,'String',' Drawing intitial contour...');
[junk,py,px]=roipoly;
s=size(px);
p=zeros(2,s(1));
p(1,:)=px';
p(2,:)=py';
p=round(p);

bw=zeros(imageSize);
for i=1:s(1)-1
    bw=line_up(bw,p(:,i),p(:,i+1));
    line(py,px,'color','r','markersize',3);
end
initBW=bw;

% set(handles.status,'String',' You can start deformation now.');
set(handles.pushbutton_start,'Enable','on');
% set(handles.pushbutton_save,'Enable','off');


function varargout = saveResult_Callback(h, eventdata, handles, varargin)% 3 View DEMO Result  tagpushbutton_save
global M dilationWidth fileName;
n=length(fileName);
saveName=fileName(1:n-4);%


view=1;
if view>0
    load(saveName);%M§
    fileExist=exist([saveName '.mat']);%ìììì2  ìì0 ¨¨ìì1
    if fileExist==2
        replaySetting=[1 1 1 1:length(M) length(M) length(M)];
%         set(handles.edit_width,'String',dilationWidth); 
%         set(handles.status,'String',' Replaying the pre-saved deformation of active conoturs');
        movie(handles.axes5,M,replaySetting,4);%Play recorded movie frames
        set(handles.status,'String',' ');
    else
        set(handles.status,'String','No pre-saved deformation available! ');
    end
else
    save(saveName, 'M', 'dilationWidth');%Save workspace variables on disk
    set(handles.pushbutton_save,'Enable','off');
end


% --- Executes on button press in pushbutton_init2.
function pushbutton_init2_Callback(hObject, eventdata, handles)
growcut_test(hObject, eventdata, handles);
% set(handles.pushbutton_save,'Enable','off');



%*********************************************************
function varargout = start_Callback(h, eventdata, handles, varargin)
global myImage imageSize initBW bw fg dilationWidth user_want_stop;
global M;
% set(handles.status,'String',' Active contours deforming ...');
dilationWidth = round(str2double('9'));
se=ones(dilationWidth);
%se=makeSE(dilationWidth);

set(handles.pushbutton_stop,'Enable','on');

old_bw=initBW;
M=moviein(1);
movie_index=1;
axes(handles.axes1);

M(movie_index)=getframe;


user_want_stop=0;
A=[0;0];
a_index=0;
while(user_want_stop==0)
    old_cost=Inf;
    while(user_want_stop==0)
        bw=double(imdilate(bw,se));  %扩展    
        bw1=double(bwfill(bw,1,1,8));
        if min(min(bw1))>0
            break;
        end
        
        labels=bw+bw1;
        %tic;
        labels=getlabels(labels);
        %toc;
        
        if a_index>0 %there is hard constrains
           for i=1:a_index
              labels=add_constrain(labels,A(:,i));
           end
        end
        
        %figure(1);
        %imagesc(labels);
        
        %tic;
        [bw,cost]=new_cut_8(double(labels),fg);
        
        axes(handles.axes1);
        hold off;
        imagesc(myImage);
        axis equal;axis off;
        colormap gray;
        hold on;
        for i=2:imageSize(1)-1
            for j=2:imageSize(2)-1
                if bw(i,j)==1
                    plot(j,i,'b.','markersize',5);
                end
            end
        end
        
                
        if a_index>0
            plot(A(2,:),A(1,:),'rx');
        end
        movie_index=movie_index+1;
        M(movie_index)=getframe;
        
        if sum(sum(abs(old_bw-bw)))<1 | old_cost<=cost
            break;
        else
            old_bw=bw;
            old_cost=cost;
        end        
    end
    if user_want_stop==0
%         set(handles.status,'String',' Please input new hard constraint, press right button if none...');
        [init_x,init_y,button]=ginput(1);
        if(button>2)
            break;
        end
        a_index=a_index+1;
        A(:,a_index)=round([init_y;init_x]);
    else
        break;
    end
end


set(handles.pushbutton_replay,'Enable','on');
% set(handles.pushbutton_save,'Enable','on');
set(handles.pushbutton_stop,'Enable','off');

if user_want_stop==1
%     set(handles.status,'String',' Active contours deformed!');
% else
%     set(handles.status,'String',' Active contours stopped!');
    user_want_stop=0;
end

%********************************************************************
function varargout = exit_Callback(h, eventdata, handles, varargin)
delete(handles.figure1);

%********************************************************************
function varargout = stop_Callback(h, eventdata, handles, varargin)
global user_want_stop;
user_want_stop=1;
%*********************************************************************




% --- Executes on button press in pushbutton_gcbac.
function pushbutton_gcbac_Callback(hObject, eventdata, handles)
set(handles.pushbutton_init,'enable','on');
set(handles.pushbutton_init2,'enable','off');
% hObject    handle to pushbutton_gcbac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_growcut.
function pushbutton_growcut_Callback(hObject, eventdata, handles)
set(handles.pushbutton_init2,'enable','on');
set(handles.pushbutton_init,'enable','off');
% hObject    handle to pushbutton_growcut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% --------------------------------------------------------------------
function pushbutton_junhenhua_Callback(hObject, eventdata, handles)
global myImage imageSize initBW bw fg dilationWidth user_want_stop;
junhenghua_Callback(hObject, eventdata, handles);
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton26.
function pushbutton21_ditong_Callback(hObject, eventdata, handles)
ditong_Callback(hObject, eventdata, handles);
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton22_gaotong_Callback(hObject, eventdata, handles)
gaotong_Callback(hObject, eventdata, handles);
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function pushbutton3_fft_Callback(hObject, eventdata, handles)
fft_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton27.
function pushbutton5_lisan_Callback(hObject, eventdata, handles)
lisan_Callback(hObject, eventdata, handles);
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton4_xiaobo_Callback(hObject, eventdata, handles)
imshow('rice.png');
xiaobo_Callback(hObject, eventdata, handles);

% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name as text
%        str2double(get(hObject,'String')) returns contents of edit_name as a double


% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --------------------------------------------------------------------
function Xpinghua_Callback(hObject, eventdata, handles)
xxlv_Callback(hObject, eventdata, handles);
% hObject    handle to Xpinghua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Fruihua_Callback(hObject, eventdata, handles)
fxxlv_Callback(hObject, eventdata, handles);
% hObject    handle to Fruihua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%   
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 10-May-2017 09:13:47

% Begin initialization code - DO NOT EDIT
addpath(genpath(pwd));
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function filedir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filedir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over filedir.
function filedir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to filedir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.beforeimg,'reset');
cla(handles.afterimg,'reset');
cla(handles.texturepanel,'reset');
set(handles.beforeimg,'visible','off');
set(handles.afterimg,'visible','off');
set(handles.texturepanel,'visible','off');
set(handles.welcome,'visible','off');

[fname,fdir] = uigetfile('*.jpg;*.png;*.bmp;*.tif','Í¼Æ¬Ñ¡Ôñ','');
if exist(strcat(fdir,fname))
    set(handles.filedir,'string',strcat(fdir,fname));
    set(handles.filedir,'foregroundcolor','black');
end


% --- Executes on button press in openfile.
function openfile_Callback(hObject, eventdata, handles)
% hObject    handle to openfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.beforeimg,'reset');
cla(handles.afterimg,'reset');
cla(handles.texturepanel,'reset');
set(handles.beforeimg,'visible','off');
set(handles.afterimg,'visible','off');
set(handles.texturepanel,'visible','off');
set(handles.welcome,'visible','off');

imgdir = get(handles.filedir,'string');
I = imread(imgdir);
axes(handles.beforeimg);
imshow(I);


% --- Executes on button press in threshold.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.beforeimg,'reset');
cla(handles.afterimg,'reset');
cla(handles.texturepanel,'reset');
set(handles.beforeimg,'visible','off');
set(handles.afterimg,'visible','off');
set(handles.texturepanel,'visible','off');
set(handles.welcome,'visible','off');

imgdir = get(handles.filedir,'string');
I = imread(imgdir);
axes(handles.beforeimg);
imshow(I);
thrimg = OTSU3(I);
axes(handles.afterimg);
imshow(thrimg);

% --- Executes on button press in cvmodel.
function cvmodel_Callback(hObject, eventdata, handles)
% hObject    handle to cvmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.beforeimg,'reset');
cla(handles.afterimg,'reset');
cla(handles.texturepanel,'reset');
set(handles.beforeimg,'visible','off');
set(handles.afterimg,'visible','off');
set(handles.texturepanel,'visible','off');
set(handles.welcome,'visible','off');

imgdir = get(handles.filedir,'string');
I = imread(imgdir);
I = OTSU3(I);
mask = 'large';
num_iter = 10000;
mu = 0.02;
method = 'chan';
%%
%-- Default settings
%   length term mu = 0.2 and default method = 'chan'
  if(~exist('mu','var')) 
    mu=0.2; 
  end
  
  if(~exist('method','var')) 
    method = 'chan'; 
  end

%-- End default settings

%%
%-- Initializations on input image I and mask
%  resize original image
   s = 200./min(size(I,1),size(I,2)); % resize scale
   if s<1
       I = imresize(I,s);
   end
  
%   auto mask settings
  if ischar(mask)
      switch lower (mask)
          case 'small'
              mask = maskcircle2(I,'small');
          case 'medium'
              mask = maskcircle2(I,'medium');
          case 'large'
              mask = maskcircle2(I,'large');              
          case 'whole'
              mask = maskcircle2(I,'whole'); 
              %mask = init_mask(I,30);      
          case 'whole+small'
              m1 = maskcircle2(I,'whole');
              m2 = maskcircle2(I,'small');
              mask = zeros(size(I,1),size(I,2),2);
              mask(:,:,1) = m1(:,:,1);
              mask(:,:,2) = m2(:,:,2);
          otherwise
              error('unrecognized mask shape name (MASK).');
      end
  else
      if s<1
          mask = imresize(mask,s);
      end
      if size(mask,1)>size(I,1) || size(mask,2)>size(I,2)
          error('dimensions of mask unmathch those of the image.')
      end
      switch lower(method)
          case 'multiphase'
              if  (size(mask,3) == 1)  
                  error('multiphase requires two masks but only gets one.')
              end
      end

  end       

  
switch lower(method)
    case 'chan'
        if size(I,3)== 3
            P = rgb2gray(uint8(I));
            P = double(P);
        elseif size(I,3) == 2
            P = 0.5.*(double(I(:,:,1))+double(I(:,:,2)));
        else
            P = double(I);
        end
        layer = 1;
        
    case 'vector'
        s = 200./min(size(I,1),size(I,2)); % resize scale
        I = imresize(I,s);
        mask = imresize(mask,s);
        layer = size(I,3);
        if layer == 1
            display('only one image component for vector image')
        end
        P = double(I);
            
    case 'multiphase'
        layer = size(I,3);
        if size(I,1)*size(I,2)>200^2
            s = 200./min(size(I,1),size(I,2)); % resize scale
            I = imresize(I,s);
            mask = imresize(mask,s);
        end
            
        P = double(I);  %P store the original image
    otherwise
        error('!invalid method')
end
%-- End Initializations on input image I and mask

%%
%--   Core function
switch lower(method)
    case {'chan','vector'}
        %-- SDF
        %   Get the distance map of the initial mask
        
        mask = mask(:,:,1);
         phi0 = bwdist(mask)-bwdist(1-mask)+im2double(mask)-.5; 
%         phi0 = bwdist(mask)-bwdist(1-mask)+im2double(mask)+16; 
        %   initial force, set to eps to avoid division by zeros
        force = eps; 
        %-- End Initialization

        axes(handles.beforeimg);
        %-- Main loop
          for n=1:num_iter
              inidx = find(phi0>=0); % frontground index
              outidx = find(phi0<0); % background index
              force_image = 0; % initial image force for each layer 
              for i=1:layer
                  L = im2double(P(:,:,i)); % get one image component
                  c1 = sum(sum(L.*Heaviside(phi0)))/(length(inidx)+eps); % average inside of Phi0
                  c2 = sum(sum(L.*(1-Heaviside(phi0))))/(length(outidx)+eps); % average outside of Phi0
                  force_image=-(L-c1).^2+(L-c2).^2+force_image; 
                  % sum Image Force on all components (used for vector image) 
                  % if 'chan' is applied, this loop become one sigle code as a
                  % result of layer = 1
              end

              % calculate the external force of the image 
              force = mu*kappa(phi0)./max(max(abs(kappa(phi0))))+1/layer.*force_image;

              % normalized the force
              force = force./(max(max(abs(force))));

              % get stepsize dt
              dt=0.5;
              
              % get parameters for checking whether to stop
              old = phi0;
              phi0 = phi0+dt.*force;
              new = phi0;
              indicator = checkstop(old,new,dt);

              % intermediate output
              if(mod(n,20) == 0) 
                 showphi(I,phi0,n);  
              end;
              if indicator % decide to stop or continue 
                  showphi(I,phi0,n);

                  %make mask from SDF
                  seg = phi0<=0; %-- Get mask from levelset

                  axes(handles.afterimg); imshow(seg);  

                  return;
              end
          end;
          showphi(I,phi0,n);

          %make mask from SDF
          seg = phi0<=0; %-- Get mask from levelset

          axes(handles.afterimg); imshow(seg);  
    case 'multiphase'
        %-- Initializations
        %   Get the distance map of the initial masks
        mask1 = mask(:,:,1);
        mask2 = mask(:,:,2);
        phi1=bwdist(mask1)-bwdist(1-mask1)+im2double(mask1)-.5;%Get phi1 from the initial mask 1
        phi2=bwdist(mask2)-bwdist(1-mask2)+im2double(mask2)-.5;%Get phi1 from the initial mask 2
        
        %-- Display settings
        
        axes(handles.beforeimg);
        %-- End display settings
        
        %Main loop
        for n=1:num_iter
              %-- Narrow band for each phase
              nb1 = find(phi1<0.6 & phi1>=-0.6); %narrow band of phi1
              inidx1 = find(phi1>=0); %phi1 frontground index
              outidx1 = find(phi1<0); %phi1 background index

              nb2 = find(phi2<0.6 & phi2>=-0.6); %narrow band of phi2
              inidx2 = find(phi2>=0); %phi2 frontground index
              outidx2 = find(phi2<0); %phi2 background index
              %-- End initiliazaions on narrow band

              %-- Mean calculations for different partitions
              %c11 = mean (phi1>0 & phi2>0)
              %c12 = mean (phi1>0 & phi2<0)
              %c21 = mean (phi1<0 & phi2>0)
              %c22 = mean (phi1<0 & phi2<0)

              cc11 = intersect(inidx1,inidx2); %index belong to (phi1>0 & phi2>0)
              cc12 = intersect(inidx1,outidx2); %index belong to (phi1>0 & phi2<0)
              cc21 = intersect(outidx1,inidx2); %index belong to (phi1<0 & phi2>0)
              cc22 = intersect(outidx1,outidx2); %index belong to (phi1<0 & phi2<0)
              
              f_image11 = 0;
              f_image12 = 0;
              f_image21 = 0;
              f_image22 = 0; % initial image force for each layer 
              
              for i=1:layer
                  L = im2double(P(:,:,i)); % get one image component
          
              if isempty(cc11)
                  c11 = eps;
              else
                  c11 = mean(L(cc11));
              end
              
              if isempty(cc12)
                  c12 = eps;
              else
                  c12 = mean(L(cc12)); 
              end
              
              if isempty(cc21)
                  c21 = eps;
              else
                  c21 = mean(L(cc21));
              end
              
              if isempty(cc22)
                  c22 = eps;
              else
                  c22 = mean(L(cc22));
              end
              
              %-- End mean calculation

              %-- Force calculation and normalization
              % force on each partition
              
              f_image11=(L-c11).^2.*Heaviside(phi1).*Heaviside(phi2)+f_image11;
              f_image12=(L-c12).^2.*Heaviside(phi1).*(1-Heaviside(phi2))+f_image12;
              f_image21=(L-c21).^2.*(1-Heaviside(phi1)).*Heaviside(phi2)+f_image21;
              f_image22=(L-c22).^2.*(1-Heaviside(phi1)).*(1-Heaviside(phi2))+f_image22;
              end
              
                  % sum Image Force on all components (used for vector image)
                  % if 'chan' is applied, this loop become one sigle code as a
                  % result of layer = 1
 
              % calculate the external force of the image 
              
              % curvature on phi1
              curvature1 = mu*kappa(phi1);
              curvature1 = curvature1(nb1);
              % image force on phi1
              fim1 = 1/layer.*(-f_image11(nb1)+f_image21(nb1)-f_image12(nb1)+f_image22(nb1));
              fim1 = fim1./max(abs(fim1)+eps);

              % curvature on phi2
              curvature2 = mu*kappa(phi2);
              curvature2 = curvature2(nb2);
              % image force on phi2
              fim2 = 1/layer.*(-f_image11(nb2)+f_image12(nb2)-f_image21(nb2)+f_image22(nb2));
              fim2 = fim2./max(abs(fim2)+eps);

              % force on phi1 and phi2
              force1 = curvature1+fim1;
              force2 = curvature2+fim2;
              %-- End force calculation

              % detal t
              dt = 1.5;
              
              old(:,:,1) = phi1;
              old(:,:,2) = phi2;

              %update of phi1 and phi2
              phi1(nb1) = phi1(nb1)+dt.*force1;
              phi2(nb2) = phi2(nb2)+dt.*force2;
              
              new(:,:,1) = phi1;
              new(:,:,2) = phi2;
              
              indicator = checkstop(old,new,dt);

              if indicator 
                 showphi(I, new, n);
                 %make mask from SDF
                 seg11 = (phi1>0 & phi2>0); %-- Get mask from levelset
                 seg12 = (phi1>0 & phi2<0);
                 seg21 = (phi1<0 & phi2>0);
                 seg22 = (phi1<0 & phi2<0);

                 se = strel('disk',1);
                 aa1 = imerode(seg11,se);
                 aa2 = imerode(seg12,se);
                 aa3 = imerode(seg21,se);
                 aa4 = imerode(seg22,se);
                 seg = aa1+2*aa2+3*aa3+4*aa4;
                
                 axes(handles.afterimg); imagesc(seg);axis image; 

                  return
              end
              % re-initializations
              phi1 = reinitialization(phi1, 0.3);%sussman(phi1, 0.6);%
              phi2 = reinitialization(phi2, 0.3);%sussman(phi2,0.6);

              %intermediate output
              if(mod(n,20) == 0) 
                 phi(:,:,1) = phi1;
                 phi(:,:,2) = phi2;
                 showphi(I, phi, n);
              end;
          end;
          phi(:,:,1) = phi1;
          phi(:,:,2) = phi2;
          showphi(I, phi, n);
          %make mask from SDF
        seg11 = (phi1>0 & phi2>0); %-- Get mask from levelset
        seg12 = (phi1>0 & phi2<0);
        seg21 = (phi1<0 & phi2>0);
        seg22 = (phi1<0 & phi2<0);

        se = strel('disk',1);
        aa1 = imerode(seg11,se);
        aa2 = imerode(seg12,se);
        aa3 = imerode(seg21,se);
        aa4 = imerode(seg22,se);
        seg = aa1+2*aa2+3*aa3+4*aa4;
        %seg = bwlabel(seg);
        axes(handles.afterimg); imagesc(seg);axis image; 
end
       %}

% --- Executes on button press in texturepanel.
function texture_Callback(hObject, eventdata, handles)
% hObject    handle to texturepanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.beforeimg,'reset');
cla(handles.afterimg,'reset');
cla(handles.texturepanel,'reset');
set(handles.beforeimg,'visible','off');
set(handles.afterimg,'visible','off');
set(handles.texturepanel,'visible','off');
set(handles.welcome,'visible','off');

imgdir = get(handles.filedir,'string');
T = Texture(imgdir);
T = Tresult(T);
I = imread(imgdir);
axes(handles.beforeimg);
imshow(I);
set(handles.tcontrast,'string',['Contrast:',char(9),num2str(T.Contrast.mean)]);
set(handles.tcorrelation,'string',['Correlation:',num2str(T.Correlation.mean)]);
set(handles.tenergy,'string',['Energy:',char(9),num2str(T.Energy.mean)]);
set(handles.thomogeneity,'string',['Homogeneity:',num2str(T.Homogeneity.mean)]);
set(handles.tmaxp,'string',['MaxProbability:',num2str(T.MaxProbability.mean)]);
set(handles.tentropy,'string',['Entropy:',num2str(T.Entropy.mean)]);
set(handles.tresult,'string',['Result:',num2str(T.Result)]);
set(handles.texturepanel,'visible','on');

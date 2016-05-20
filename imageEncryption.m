function varargout = imageEncryption(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageEncryption_OpeningFcn, ...
                   'gui_OutputFcn',  @imageEncryption_OutputFcn, ...
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

function imageEncryption_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.loadImage=0;            %����ͼ��״̬
handles.encryption=0;           %����״̬
handles.imageSource=0;          %ԭʼͼ��
handles.EncryptionImage=0;      %���ܺ�
handles.EncryptionWay=0;        %���ܷ���
handles.unEncryptionImage=0;    %���ܺ��ͼ��

guidata(hObject, handles);

function varargout = imageEncryption_OutputFcn(hObject, eventdata, handles) 
%����ͼ���
set(handles.imageSrc,'Visible','off');
set(handles.imageDst,'Visible','off');
set(handles.imageUnEncryption,'Visible','off');

set(handles.imageSrc_hist,'Visible','off');
set(handles.imageDst_hist,'Visible','off');
set(handles.imageUnEncryption_hist,'Visible','off');

set(handles.beforeEncryptionCorr,'Visible','off');
set(handles.afterEncryptionCorr,'Visible','off');
set(handles.unEncryptionCorr,'Visible','off');

%���ر����ı�
set(handles.imageSrc_text,'Visible','off');
set(handles.imageDst_text,'Visible','off');
set(handles.imageUnEncryption_text,'Visible','off');

set(handles.imageSrcHist_text,'Visible','off');
set(handles.imageDstHist_text,'Visible','off');
set(handles.imageUnEncryptionHist_text,'Visible','off');

set(handles.beforeEncryptionCorr_text,'Visible','off');
set(handles.afterEncryptionCorr_text,'Visible','off');
set(handles.unEncryptionCorr_text,'Visible','off');

varargout{1} = handles.output;

%--------------------------------------------------------------------
%λ������
function localEncryption_Callback(hObject, eventdata, handles)
if handles.loadImage==0                     %ͼ���Ƿ�������
    warndlg('��ѡ��ͼ��');
    return;
end
imgDst=imread(handles.imagePath);           %��ȡͼ��
if size(imgDst,3)==3
    imgDst=rgb2gray(imgDst);
end
based=str2num(get(handles.haltonBased,'string'));   %��ȡhalton���л���
if based<=1 || based>=1000 || based~=fix(based)
    warndlg('����ӦΪ(1,1000)֮���������');
    return;
end
imgDst=locationExchange(imgDst,based);              %λ������(�����ҡ�������)
axes(handles.imageDst);                             %��ʾԭʼͼ��
imshow(imgDst);
set(handles.imageDst_text,'Visible','on');

axes(handles.imageDst_hist);                        %��ʾԭʼͼ��ֱ��ͼ
imhist(imgDst);
set(handles.imageDstHist_text,'Visible','on');

handles.EncryptionImage=imgDst;                     %��ȡ����ͼ��
handles.EncryptionWay=1;                            %���ܷ���
handles.encryption=1;                               %���Ϊ�Ѽ���
msgbox('���ܳɹ���','��ʾ');

guidata(hObject, handles);
% --------------------------------------------------------------------
%��������
function pixelEncryption_Callback(hObject, eventdata, handles)
if handles.loadImage==0
    warndlg('��ѡ��ͼ��');
    return;
end
imgDst=imread(handles.imagePath);
if size(imgDst,3)==3
    imgDst=rgb2gray(imgDst);
end
based=str2num(get(handles.haltonBased,'string'));
if based<=1 || based>=1000 || based~=fix(based)
    warndlg('����ӦΪ(1,1000)֮���������');
    return;
end
imgDst=pixelEncryption(imgDst,based);
axes(handles.imageDst);
imshow(imgDst);
set(handles.imageDst_text,'Visible','on');

axes(handles.imageDst_hist);
imhist(imgDst);
set(handles.imageDstHist_text,'Visible','on');
handles.EncryptionImage=imgDst;
handles.EncryptionWay=2;
handles.encryption=1;
msgbox('���ܳɹ���','��ʾ');

guidata(hObject, handles);
% --------------------------------------------------------------------
%���������ң���λ������
function pixellocationEncryption_Callback(hObject, eventdata, handles)
if handles.loadImage==0
    warndlg('��ѡ��ͼ��');
    return;
end

imgDst=imread(handles.imagePath);
if size(imgDst,3)==3
    imgDst=rgb2gray(imgDst);
end

based=str2num(get(handles.haltonBased,'string'));
if based<=1 || based>=1000 || based~=fix(based)
    warndlg('����ӦΪ(1,1000)֮���������');
    return;
end

imgDst=pixelEncryption(imgDst,based);               %����������
imgDst=locationExchange(imgDst,based);              %��λ������
axes(handles.imageDst);
imshow(imgDst);
set(handles.imageDst_text,'Visible','on');

axes(handles.imageDst_hist);
imhist(imgDst);
set(handles.imageDstHist_text,'Visible','on');
handles.EncryptionImage=imgDst;
handles.EncryptionWay=3;
handles.encryption=1;
msgbox('���ܳɹ���','��ʾ');

guidata(hObject, handles);
% --------------------------------------------------------------------
%��λ�����ң�����������
function locationpixelEncryption_Callback(hObject, eventdata, handles)
if handles.loadImage==0
    warndlg('��ѡ��ͼ��');
    return;
end

imgDst=imread(handles.imagePath);
if size(imgDst,3)==3
    imgDst=rgb2gray(imgDst);
end

based=str2num(get(handles.haltonBased,'string'));
if based<=1 || based>=1000 || based~=fix(based)
    warndlg('����ӦΪ(1,1000)֮���������');
    return;
end

imgDst=locationExchange(imgDst,based);          %��λ������
imgDst=pixelEncryption(imgDst,based);           %����������
axes(handles.imageDst);
imshow(imgDst);
set(handles.imageDst_text,'Visible','on');

axes(handles.imageDst_hist);
imhist(imgDst);
set(handles.imageDstHist_text,'Visible','on');
handles.EncryptionImage=imgDst;
handles.EncryptionWay=4;
handles.encryption=1;
msgbox('���ܳɹ���','��ʾ');

guidata(hObject, handles);
% --------------------------------------------------------------------
%����ͼ��
function openFile_Callback(hObject, eventdata, handles)
[file_name,path_name]=uigetfile('*.bmp;*.jpg;*.png;*.jpeg;*.tif;*.gif','ѡ��ͼ��');
if (file_name==0)                                     	%�Ƿ�·��
    warndlg('��ѡ��ͼ��');
    handles.loadImage=0;                              	%����ʧ��
    return;
end

handles.imagePath=fullfile(path_name,file_name);    	%�ϳ�·������ȡԴͼ��
handles.loadImage=1;                                  	%����ɹ�
imgSrc=imread(handles.imagePath);
if size(imgSrc,3)==3
    imgSrc=rgb2gray(imgSrc);
end

axes(handles.imageSrc);
imshow(imgSrc);
set(handles.imageSrc_text,'Visible','on');

axes(handles.imageSrc_hist);
handles.imageSource=imgSrc;                             %ԭʼͼ��
imhist(imgSrc);
set(handles.imageSrcHist_text,'Visible','on');

guidata(hObject,handles);
% --------------------------------------------------------------------
%�˳�ϵͳ
function exitSystem_Callback(hObject, eventdata, handles)
inf=questdlg('�Ƿ��˳���','�ر����','��','��','��');  	 %�˳�ʱ����ʾ��Ϣ
if strcmp(inf,'��')
    clear all;
    close all;                                      	%�ر����д���
end

% --------------------------------------------------------------------
function imageEncryption_CreateFcn(hObject, eventdata, handles)

% --------------------------------------------------------------------
function author_Callback(hObject, eventdata, handles)
msgbox(['Copyright (C) 2016 xxx'],'������Ϣ');

% --------------------------------------------------------------------
function safetyAnalysis_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function imgHist_Callback(hObject, eventdata, handles)
msgbox('ͼ��ֱ��ͼ�ѿ�����','��ʾ');

% --------------------------------------------------------------------
function unEncryption_Callback(hObject, eventdata, handles)
if handles.loadImage==0
    warndlg('��ѡ��ͼ��');
    return;
end
if handles.encryption==0
    warndlg('���ȼ���ͼ��');
    return;
end
based=str2num(get(handles.haltonBased,'string'));
if based<=1 || based>=1000 || based~=fix(based)
    warndlg('����ӦΪ(1,1000)֮���������');
    return;
end
EncryWay=handles.EncryptionWay;
imgDst=handles.EncryptionImage;
if EncryWay==1                                  %λ������
    imgDst=locationUnExchange(imgDst,based);
elseif EncryWay==2                              %��������
    imgDst=pixelUnEncryption(imgDst,based);
elseif EncryWay ==3                             %��λ�����ң�����������
    imgDst=pixelUnEncryption(imgDst,based);     %�Ƚ�������
    imgDst=locationUnExchange(imgDst,based);    %�ٽ���λ��
elseif EncryWay==4                              %���������ң���λ������
    imgDst=locationUnExchange(imgDst,based);    %�Ƚ���λ��
    imgDst=pixelUnEncryption(imgDst,based);     %�ٽ�������
end

handles.unEncryptionImage=imgDst;               %���ܺ�ͼ��
axes(handles.imageUnEncryption);
imshow(imgDst);
set(handles.imageUnEncryption_text,'Visible','on');

axes(handles.imageUnEncryption_hist);
imhist(imgDst);
set(handles.imageUnEncryptionHist_text,'Visible','on');

guidata(hObject,handles);

% --------------------------------------------------------------------
%����Է���
function correlationAnalysis_Callback(hObject, eventdata, handles)
if handles.encryption==0
	warndlg('���ȼ���ͼ��');
    return;
end

imgSrc=handles.imageSource;         %ԭʼͼ��
imgEnc=handles.EncryptionImage;     %����ͼ��
imgUnE=handles.unEncryptionImage;   %����ͼ��

[rows,clos]=size(imgSrc);

totalNumber=1000;                                       %������������
edgeDist=10;                                            %�����±�Խ��

randX=ceil((rows-edgeDist)*rand(totalNumber,1))+1;
randY=ceil((clos-edgeDist)*rand(totalNumber,1))+1;

plot1X=randX;
plot1Y=randY;
plot2X=randX;
plot2Y=randY;
plot3X=randX;
plot3Y=randY;
%------------------------------------------------------------------
%��������ˮƽ�����
for i=1:totalNumber
    plot1X(i,1)=imgSrc(randX(i,1),randY(i,1));
    plot1Y(i,1)=imgSrc(randX(i,1),randY(i,1)+1);
   	plot2X(i,1)=imgEnc(randX(i,1),randY(i,1));
    plot2Y(i,1)=imgEnc(randX(i,1),randY(i,1)+1);
   	plot3X(i,1)=imgUnE(randX(i,1),randY(i,1));
    plot3Y(i,1)=imgUnE(randX(i,1),randY(i,1)+1);
end

axes(handles.beforeEncryptionCorr);         %ԭʼ
plot(plot1X,plot1Y,'.');
set(handles.beforeEncryptionCorr_text,'Visible','on');
%------------------------------------------------------------------
axes(handles.afterEncryptionCorr);          %����
plot(plot2X,plot2Y,'.');
set(handles.afterEncryptionCorr_text,'Visible','on');
%------------------------------------------------------------------
axes(handles.unEncryptionCorr);             %����
plot(plot3X,plot3Y,'.');
set(handles.unEncryptionCorr_text,'Visible','on');
guidata(hObject,handles);

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Encryption_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
web https://www.baidu.com/

% --------------------------------------------------------------------
function Contact_Callback(hObject, eventdata, handles)
web https://www.baidu.com/

% --------------------------------------------------------------------
function haltonBased_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function haltonBased_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

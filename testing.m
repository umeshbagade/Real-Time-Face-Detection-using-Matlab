function varargout = testing(varargin)
% TESTING MATLAB code for testing.fig
%      TESTING, by itself, creates a new TESTING or raises the existing
%      singleton*.
%
%      H = TESTING returns the handle to a new TESTING or the handle to
%      the existing singleton*.
%
%      TESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTING.M with the given input arguments.
%
%      TESTING('Property','Value',...) creates a new TESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testing

% Last Modified by GUIDE v2.5 07-Jun-2021 15:00:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_OutputFcn, ...
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


% --- Executes just before testing is made visible.
function testing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testing (see VARARGIN)

% Choose default command line output for testing
handles.output = hObject;
axes(handles.axes1);
imshow('blank.jpg');
axis off;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
%preview(handles.vid);
guidata(hObject, handles);


% --- Executes on button press in face.
function face_Callback(hObject, eventdata, handles)
% hObject    handle to face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 5;
start(handles.vid);
while(1)

facedetector = vision.CascadeObjectDetector;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(facedetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'Face');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
stop(handles.vid),clear handles.vid %, ,delete(handles.vid)
guidata(hObject, handles);


% --- Executes on button press in eyes.
function eyes_Callback(hObject, eventdata, handles)
% hObject    handle to eyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 2;
start(handles.vid);
while(1)
bodyDetector = vision.CascadeObjectDetector('EyePairBig');
bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'EYE');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in mouth.
function mouth_Callback(hObject, eventdata, handles)
% hObject    handle to mouth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
handles.vid.Timeout = 2;
start(handles.vid);
while(1)
bodyDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
%bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'MOUTH');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in nose.
function nose_Callback(hObject, eventdata, handles)
% hObject    handle to nose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to eyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
handles.vid.Timeout = 2;
start(handles.vid);
while(1)
bodyDetector = vision.CascadeObjectDetector('Nose');
%bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'NOSE');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in recognision.
function recognision_Callback(hObject, eventdata, handles)
% hObject    handle to recognision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all;

clc;
c=webcam;
load bro;
faceDetector=vision.CascadeObjectDetector;
while true
    e=c.snapshot;
    bboxes =step(faceDetector,e);
    if(sum(sum(bboxes))~=0)
    es=imcrop(e,bboxes(1,:));
    es=imresize(es,[227 227]);
    label=classify(bro,es);
    image(e);
    title(char(label));
    drawnow;
    else
        image(e);
        title('No Face Detected');
    end
end



% --- Executes on button press in addnewuser.
function addnewuser_Callback(hObject, eventdata, handles)
% hObject    handle to addnewuser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
warning off;
cao=webcam;
faceDetector=vision.CascadeObjectDetector;
c=50;
prompt = {'Enter Your Name : '};
dlgtitle = 'Add Data';
definput = {'Anonymous user'};
dims = [1 40];
opts.Interpreter = 'tex';
name = string(inputdlg(prompt,dlgtitle,dims,definput,opts));
mkdir('database',name);
name =strcat('database/',name)
temp=0;
while true
    e=cao.snapshot;
    bboxes =step(faceDetector,e);
    if(sum(sum(bboxes))~=0)
    if(temp>=c)
        break;
    else
    es=imcrop(e,bboxes(1,:));
    es=imresize(es,[227 227]);
    filename=strcat(num2str(temp),'.bmp');
    imwrite(es,name+"/"+filename);
    temp=temp+1;
    imshow(es);
    drawnow;
    end
    else
        imshow(e);
        drawnow;
    end
end


% --- Executes on button press in train.
function train_Callback(hObject, eventdata, handles)
% hObject    handle to train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = msgbox('Please wait 5 minutes before clicking on other button');
clc
warning off
g=alexnet;
layers=g.Layers;

files = dir('D:\Program Files\MATLAB\R2019b\bin\database')
dirFlags = [files.isdir]
subFolders = files(dirFlags)
count = 0;
for k = 1 : length(subFolders)
  if (subFolders(k).name) ~= '.'
    count=count+1;
    fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
  end
end

layers(23)=fullyConnectedLayer(count);
layers(25)=classificationLayer;
allImages=imageDatastore('database','IncludeSubfolders',true, 'LabelSource','foldernames');
opts=trainingOptions('sgdm','InitialLearnRate',0.001,'MaxEpochs',20,'MiniBatchSize',64);
bro=trainNetwork(allImages,layers,opts);
save bro;
clear all;

function varargout = tes(varargin)
% TES MATLAB code for tes.fig
%      TES, by itself, creates a new TES or raises the existing
%      singleton*.
%
%      H = TES returns the handle to a new TES or the handle to
%      the existing singleton*.
%
%      TES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TES.M with the given input arguments.
%
%      TES('Property','Value',...) creates a new TES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tes

% Last Modified by GUIDE v2.5 09-Jan-2018 08:35:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tes_OpeningFcn, ...
                   'gui_OutputFcn',  @tes_OutputFcn, ...
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


% --- Executes just before tes is made visible.
function tes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tes (see VARARGIN)

% Choose default command line output for tes
vol = 2.5;
set(handles.slider15,'value',vol);
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.wav'},'File Selector');
handles.fullpathname = strcat(pathname, filename);

set(handles.text3, 'String',handles.fullpathname) %showing fullpathname
guidata(hObject,handles)

function play_equalizer(hObject, handles)
global player;
[handles.y,handles.Fs] = audioread(handles.fullpathname);
handles.Volume=get(handles.slider15,'value');
%handles.y=handles.y(NewStart:end,:); 
handles.g1=get(handles.slider3,'value');
handles.g2=get(handles.slider4,'value');
handles.g3=get(handles.slider5,'value');
handles.g4=get(handles.slider7,'value');
handles.g5=get(handles.slider8,'value');
handles.g6=get(handles.slider9,'value');
handles.g7=get(handles.slider10,'value');
handles.g8=get(handles.slider11,'value');
handles.g9=get(handles.slider6,'value');
handles.g10=get(handles.slider12,'value');

set(handles.text16, 'String',handles.g1);
set(handles.text19, 'String',handles.g2);
set(handles.text20, 'String',handles.g3);
set(handles.text21, 'String',handles.g4);
set(handles.text22, 'String',handles.g5);
set(handles.text23, 'String',handles.g6);
set(handles.text24, 'String',handles.g7);
set(handles.text25, 'String',handles.g8);
set(handles.text26, 'String',handles.g9);
set(handles.text27, 'String',handles.g10);

handles.g1=10^(handles.g1/10);
handles.g2=10^(handles.g2/10);
handles.g3=10^(handles.g3/10);
handles.g4=10^(handles.g4/10);
handles.g5=10^(handles.g5/10);
handles.g6=10^(handles.g6/10);
handles.g7=10^(handles.g7/10);
handles.g8=10^(handles.g8/10);
handles.g9=10^(handles.g9/10);
handles.g10=10^(handles.g10/10);

cut_off=200; %cut off low pass dalama Hz
%order 16;
orde=16;
a=fir1(orde,cut_off/(handles.Fs/2),'low');
y1=handles.g1*filter(a,1,handles.y);

% %bandpass1
f1=201;
f2=400;
b1=fir1(orde,[f1/(handles.Fs/2) f2/(handles.Fs/2)],'bandpass');
y2=handles.g2*filter(b1,1,handles.y);
% 
% %bandpass2
f3=401;
f4=800;
b2=fir1(orde,[f3/(handles.Fs/2) f4/(handles.Fs/2)],'bandpass');
y3=handles.g3*filter(b2,1,handles.y);
% 
% %bandpass3
 f4=801;
f5=1500;
 b3=fir1(orde,[f4/(handles.Fs/2) f5/(handles.Fs/2)],'bandpass');
 y4=handles.g4*filter(b3,1,handles.y);
% 
% %bandpass4
 f5=1501;
f6=3000;
 b4=fir1(orde,[f5/(handles.Fs/2) f6/(handles.Fs/2)],'bandpass');
 y5=handles.g5*filter(b4,1,handles.y);
% 
% %bandpass5
  f7=3001;
f8=5000;
  b5=fir1(orde,[f7/(handles.Fs/2) f8/(handles.Fs/2)],'bandpass');
  y6=handles.g6*filter(b5,1,handles.y);
% 
% %bandpass6
  f9=5001;
f10=7000;
  b6=fir1(orde,[f9/(handles.Fs/2) f10/(handles.Fs/2)],'bandpass');
  y7=handles.g7*filter(b6,1,handles.y);
% 
% %bandpass7
  f11=7001;
f12=10000;
  b7=fir1(orde,[f11/(handles.Fs/2) f12/(handles.Fs/2)],'bandpass');
  y8=handles.g8*filter(b7,1,handles.y);
% 
 % %bandpass8
  f13=10001;
f14=15000;
  b8=fir1(orde,[f13/(handles.Fs/2) f14/(handles.Fs/2)],'bandpass');
  y9=handles.g9*filter(b8,1,handles.y);
% 
 %highpass
cut_off2=15000;
c=fir1(orde,cut_off2/(handles.Fs/2),'high');
y10=handles.g10*filter(c,1,handles.y);
%handles.yT=y1+y2+y3+y4+y5+y6+y7;
 handles.yT=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
player = audioplayer(handles.Volume*handles.yT, handles.Fs);
%player = audioplayer(handles.yT, handles.Fs);
 subplot(2,1,1);
 plot(handles.y);
 subplot(2,1,2);
 plot(handles.yT);

guidata(hObject,handles)
%[y, Fs] = audioread(fullpathname);
% = audioplayer(y, Fs);
%play(player);
%play(player);
%save suara;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global player;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%equalizer_play();
play_equalizer(hObject, handles); 
play(player);
guidata(hObject,handles)

%t=0:1/handles.Fs:(length(handles.player)-1)/handles.Fs;
%plot(handles.yT,handles.axes2);
%set(handles.axes2);
%handles.yT(handles.axes2);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles); 
pause(player);
guidata(hObject,handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles); 
stop(player);
guidata(hObject,handles)



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles); 
resume(player);
guidata(hObject,handles)



% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Pop.
function Pop_Callback(hObject, eventdata, handles)
% hObject    handle to Pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = -1.5;
g2 = 3.9;
g3 = 5.4;
g4 = 4.5;
g5 =  0.9;
g6 = -1.5;
g7 = -1.8;
g8= -2.1;
g9 = -2.1;
g10 = -0.3;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);
set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);


% --- Executes on button press in Reggae.
function Reggae_Callback(hObject, eventdata, handles)
g1 = 0;
g2 = 0;
g3 = -0.3;
g4 = -2.7;
g5 =  0;
g6 = 2.1;
g7 = 4.5;
g8= 3;
g9 = 0.6;
g10 = 0;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);

set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);
% hObject    handle to Reggae (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Rock.
function Rock_Callback(hObject, eventdata, handles)
% hObject    handle to Rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4.5;
g2 = -3.6;
g3 = -6.6;
g4 = -2.7;
g5 =  2.1;
g6 = 6;
g7 = 7.5;
g8= 7.8;
g9 =7.8;
g10 = 8.1;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);

set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);

% --- Executes on button press in Techno.
function Techno_Callback(hObject, eventdata, handles)
% hObject    handle to Techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4.8;
g2 = 4.2;
g3 = 1.5;
g4 = -2.4;
g5 =  -3.3;
g6 = -1.5;
g7 = 1.5;
g8= 5.1;
g9 = 5.7;
g10 = 5.4;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);

set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);

% --- Executes on button press in Party.
function Party_Callback(hObject, eventdata, handles)
% hObject    handle to Party (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 5.4;
g2 = 0;
g3 = 0;
g4 = 0;
g5 =  0;
g6 = 0;
g7 = 0;
g8= 0;
g9 = 0;
g10 = 5.4;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);

set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);


% --- Executes on button press in Classical.
function Classical_Callback(hObject, eventdata, handles)
% hObject    handle to Classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 0;
g2 = 0;
g3 = 0;
g4 = 0;
g5 =  0;
g6 = 0;
g7 = -0.3;
g8= -5.7;
g9 = -6;
g10 = -8.1;
set(handles.slider3,'value',g1);
set(handles.slider4,'value',g2);
set(handles.slider5,'value',g3);
set(handles.slider7,'value',g4);
set(handles.slider8,'value',g5);
set(handles.slider9,'value',g6);
set(handles.slider10,'value',g7);
set(handles.slider11,'value',g8);
set(handles.slider6,'value',g9);
set(handles.slider12,'value',g10);

set(handles.text16, 'String',g1);
set(handles.text19, 'String',g2);
set(handles.text20, 'String',g3);
set(handles.text21, 'String',g4);
set(handles.text22, 'String',g5);
set(handles.text23, 'String',g6);
set(handles.text24, 'String',g7);
set(handles.text25, 'String',g8);
set(handles.text26, 'String',g9);
set(handles.text27, 'String',g10);

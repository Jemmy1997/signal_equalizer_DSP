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

% Last Modified by GUIDE v2.5 28-Feb-2019 11:56:01

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
set(handles.volume,'value',vol);
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


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile({'*.wav'},'File Selector');
handles.fullpathname = strcat(pathname, filename);

set(handles.text3, 'String',handles.fullpathname) %showing fullpathname
guidata(hObject,handles)

function play_equalizer(hObject, handles)
global player;
[handles.y,handles.Fs] = audioread(handles.fullpathname);
handles.Volume=get(handles.volume,'value');
%handles.y=handles.y(NewStart:end,:); 
handles.gain1=get(handles.slider_30,'value');
handles.gain2=get(handles.slider_60,'value');
handles.gain3=get(handles.slider_120,'value');
handles.gain4=get(handles.slider_240,'value');
handles.gain5=get(handles.slider_480,'value');
handles.gain6=get(handles.slider_960,'value');
handles.gain7=get(handles.slider_1900,'value');
handles.gain8=get(handles.slider_3800,'value');
handles.gain9=get(handles.slider_7700,'value');
handles.gain10=get(handles.slider_15000,'value');

set(handles.text16, 'String',handles.gain1);
set(handles.text19, 'String',handles.gain2);
set(handles.text20, 'String',handles.gain3);
set(handles.text21, 'String',handles.gain4);
set(handles.text22, 'String',handles.gain5);
set(handles.text23, 'String',handles.gain6);
set(handles.text24, 'String',handles.gain7);
set(handles.text25, 'String',handles.gain8);
set(handles.text26, 'String',handles.gain9);
set(handles.text27, 'String',handles.gain10);

handles.gain1=10^(handles.gain1/10);
handles.gain2=10^(handles.gain2/10);
handles.gain3=10^(handles.gain3/10);
handles.gain4=10^(handles.gain4/10);
handles.gain5=10^(handles.gain5/10);
handles.gain6=10^(handles.gain6/10);
handles.gain7=10^(handles.gain7/10);
handles.gain8=10^(handles.gain8/10);
handles.gain9=10^(handles.gain9/10);
handles.gain10=10^(handles.gain10/10);

cut_off=30; %cut off low pass dalama Hz
%orderr 16;
order=10;
a=fir1(order,cut_off/(handles.Fs/2),'low');
y1=handles.gain1*filter(a,1,handles.y);

% %bandpass1
f1=31;
f2=119;
b1=fir1(order,[f1/(handles.Fs/2) f2/(handles.Fs/2)],'bandpass');
y2=handles.gain2*filter(b1,1,handles.y);
% 
% %bandpass2
f3=61;
f4=239;
b2=fir1(order,[f3/(handles.Fs/2) f4/(handles.Fs/2)],'bandpass');
y3=handles.gain3*filter(b2,1,handles.y);
% 
% %bandpass3
f4=121;
f5=479;
b3=fir1(order,[f4/(handles.Fs/2) f5/(handles.Fs/2)],'bandpass');
y4=handles.gain4*filter(b3,1,handles.y);
% 
% %bandpass4
f5=241;
f6=959;
b4=fir1(order,[f5/(handles.Fs/2) f6/(handles.Fs/2)],'bandpass');
y5=handles.gain5*filter(b4,1,handles.y);
% 
% %bandpass5
f7=481;
f8=1899;
b5=fir1(order,[f7/(handles.Fs/2) f8/(handles.Fs/2)],'bandpass');
y6=handles.gain6*filter(b5,1,handles.y);
% 
% %bandpass6
f9=961;
f10=3799;
b6=fir1(order,[f9/(handles.Fs/2) f10/(handles.Fs/2)],'bandpass');
y7=handles.gain7*filter(b6,1,handles.y);
% 
% %bandpass7
f11=1901;
f12=7699;
b7=fir1(order,[f11/(handles.Fs/2) f12/(handles.Fs/2)],'bandpass');
y8=handles.gain8*filter(b7,1,handles.y);
% 
 % %bandpass8
f13=3801;
f14=15399;
b8=fir1(order,[f13/(handles.Fs/2) f14/(handles.Fs/2)],'bandpass');
y9=handles.gain9*filter(b8,1,handles.y);
% 
 %highpass
cut_off2=15400;
c=fir1(order,cut_off2/(handles.Fs/2),'high');
y10=handles.gain10*filter(c,1,handles.y);
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


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
global player;
% hObject    handle to play (see GCBO)
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
function slider_30_Callback(hObject, eventdata, handles)
% hObject    handle to slider_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_60_Callback(hObject, eventdata, handles)
% hObject    handle to slider_60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_60_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_120_Callback(hObject, eventdata, handles)
% hObject    handle to slider_120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_120_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_7700_Callback(hObject, eventdata, handles)
% hObject    handle to slider_7700 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_7700_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_7700 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_240_Callback(hObject, eventdata, handles)
% hObject    handle to slider_240 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_240_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_240 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_480_Callback(hObject, eventdata, handles)
% hObject    handle to slider_480 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_480_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_480 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_960_Callback(hObject, eventdata, handles)
% hObject    handle to slider_960 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_960_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_960 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_1900_Callback(hObject, eventdata, handles)
% hObject    handle to slider_1900 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_1900_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_1900 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_3800_Callback(hObject, eventdata, handles)
% hObject    handle to slider_3800 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_3800_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_3800 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
%play_equalizer(hObject, handles); 
pause(player);
guidata(hObject,handles)


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
play_equalizer(hObject, handles); 
stop(player);
guidata(hObject,handles)



% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
% play_equalizer(hObject, handles); 
resume(player);
guidata(hObject,handles)



% --- Executes on slider movement.
function slider_15000_Callback(hObject, eventdata, handles)
% hObject    handle to slider_15000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_15000_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_15000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
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
gain1 = -1.5;
gain2 = 3.9;
gain3 = 5.4;
gain4 = 4.5;
gain5 =  0.9;
gain6 = -1.5;
gain7 = -1.8;
gain8= -2.1;
gain9 = -2.1;
gain10 = -0.3;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);
set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);


% --- Executes on button press in Reggae.
function Reggae_Callback(hObject, eventdata, handles)
gain1 = 0;
gain2 = 0;
gain3 = -0.3;
gain4 = -2.7;
gain5 =  0;
gain6 = 2.1;
gain7 = 4.5;
gain8= 3;
gain9 = 0.6;
gain10 = 0;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);

set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);
% hObject    handle to Reggae (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Rock.
function Rock_Callback(hObject, eventdata, handles)
% hObject    handle to Rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gain1 = 4.5;
gain2 = -3.6;
gain3 = -6.6;
gain4 = -2.7;
gain5 =  2.1;
gain6 = 6;
gain7 = 7.5;
gain8= 7.8;
gain9 =7.8;
gain10 = 8.1;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);

set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);

% --- Executes on button press in Techno.
function Techno_Callback(hObject, eventdata, handles)
% hObject    handle to Techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gain1 = 4.8;
gain2 = 4.2;
gain3 = 1.5;
gain4 = -2.4;
gain5 =  -3.3;
gain6 = -1.5;
gain7 = 1.5;
gain8= 5.1;
gain9 = 5.7;
gain10 = 5.4;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);

set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);

% --- Executes on button press in Party.
function Party_Callback(hObject, eventdata, handles)
% hObject    handle to Party (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gain1 = 5.4;
gain2 = 0;
gain3 = 0;
gain4 = 0;
gain5 =  0;
gain6 = 0;
gain7 = 0;
gain8= 0;
gain9 = 0;
gain10 = 5.4;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);

set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);


% --- Executes on button press in Classical.
function Classical_Callback(hObject, eventdata, handles)
% hObject    handle to Classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gain1 = 0;
gain2 = 0;
gain3 = 0;
gain4 = 0;
gain5 =  0;
gain6 = 0;
gain7 = -0.3;
gain8= -5.7;
gain9 = -6;
gain10 = -8.1;
set(handles.slider_30,'value',gain1);
set(handles.slider_60,'value',gain2);
set(handles.slider_120,'value',gain3);
set(handles.slider_240,'value',gain4);
set(handles.slider_480,'value',gain5);
set(handles.slider_960,'value',gain6);
set(handles.slider_1900,'value',gain7);
set(handles.slider_3800,'value',gain8);
set(handles.slider_7700,'value',gain9);
set(handles.slider_15000,'value',gain10);

set(handles.text16, 'String',gain1);
set(handles.text19, 'String',gain2);
set(handles.text20, 'String',gain3);
set(handles.text21, 'String',gain4);
set(handles.text22, 'String',gain5);
set(handles.text23, 'String',gain6);
set(handles.text24, 'String',gain7);
set(handles.text25, 'String',gain8);
set(handles.text26, 'String',gain9);
set(handles.text27, 'String',gain10);

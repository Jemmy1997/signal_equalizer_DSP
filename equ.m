function varargout = equ(varargin)
% EQU MATLAB code for equ.fig
%      EQU, by itself, creates a new EQU or raises the existing
%      singleton*.
%
%      H = EQU returns the handle to a new EQU or the handle to
%      the existing singleton*.
%
%      EQU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQU.M with the given input arguments.
%
%      EQU('Property','Value',...) creates a new EQU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equ_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equ_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equ

% Last Modified by GUIDE v2.5 28-Feb-2019 11:19:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equ_OpeningFcn, ...
                   'gui_OutputFcn',  @equ_OutputFcn, ...
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


% --- Executes just before equ is made visible.
function equ_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equ (see VARARGIN)

% Choose default command line output for equ
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equ wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equ_OutputFcn(hObject, eventdata, handles) 
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
[fileName,pathName] = uigetfile({'*.wav; *.mp3'}, 'Open');
handles.fullPathName = strcat(pathName, fileName);
set(handles.address, 'String', handles.fullPathName);
guidata(hObject, handles);

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
[data, fs] = audioread(handles.fullPathName);
data_fft =  fft(data);
freq_step = (fs/2)/(length(data)/2);

freq = [32 64 125 250 500 1000 2000 4000 8000 16000];
g1 = 10^(get(handles.slider_32, 'Value')/10);
g2 = 10^(get(handles.slider_64, 'Value')/10);
g3 = 10^(get(handles.slider_125, 'Value')/10);
g4 = 10^(get(handles.slider_250, 'Value')/10);
g5 = 10^(get(handles.slider_500, 'Value')/10);
g6 = 10^(get(handles.slider_1k, 'Value')/10);
g7 = 10^(get(handles.slider_2k, 'Value')/10);
g8 = 10^(get(handles.slider_4k, 'Value')/10);
g9 = 10^(get(handles.slider_8k, 'Value')/10);
g10 = 10^(get(handles.slider_16k, 'Value')/10);
amp = [g1 g2 g3 g4 g5 g6 g7 g8 g9 g10];
amp = amp*get(handles.volume, 'Value');

indeces = [2 ceil(freq/freq_step) length(data)/2];
conj_indeces = [length(data)+2-indeces];
% frequencies = (0:freq_step:fs/2);

for i=2:length(indeces)-1
    data_fft(indeces(i-1):indeces(i),:) = data_fft(indeces(i-1):indeces(i),:)*amp(i-1);
    data_fft(conj_indeces(i):conj_indeces(i-1),:) = data_fft(conj_indeces(i):conj_indeces(i-1),:)*amp(i-1);
%     band1 = indeces(i)-indeces(i-1);
%     amplitudes1 = (1:(amp(i-1)-1)/band:amp(i-1));
%     disp(size(amplitudes1));
%     band2 = indeces(i+1)-indeces(i);
%     display(data);
%     disp(size(data_fft(indeces(i-1):indeces(i),:)))
%     amplitudes2 = (amp(i-1):(amp(i-1)-1)/band:1);
%     data_fft(indeces(i-1):indeces(i),:) = data_fft(indeces(i-1):indeces(i),:).*transpose(amplitudes1);
%     data_fft(indeces(i-1)+1:indeces(i),:) = data_fft(indeces(i-1)+1:indeces(i),:).*transpose(amplitudes2(2:end));
end

data_ifft = ifft(data_fft);
subplot(2,1,1);
plot(data);
subplot(2,1,2);
plot(data_ifft);

player = audioplayer(data_ifft, fs);
play(player);
guidata(hObject, handles);

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
pause(player);
guidata(hObject, handles);

% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
resume(player);
guidata(hObject, handles);

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
stop(player);
guidata(hObject, handles);

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


% --- Executes on button press in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reggae.
function reggae_Callback(hObject, eventdata, handles)
% hObject    handle to reggae (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in party.
function party_Callback(hObject, eventdata, handles)
% hObject    handle to party (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rock.
function rock_Callback(hObject, eventdata, handles)
% hObject    handle to rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in classical.
function classical_Callback(hObject, eventdata, handles)
% hObject    handle to classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in techno.
function techno_Callback(hObject, eventdata, handles)
% hObject    handle to techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_32_Callback(hObject, eventdata, handles)
% hObject    handle to slider_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_32, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_64_Callback(hObject, eventdata, handles)
% hObject    handle to slider_64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_64, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_64_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_125_Callback(hObject, eventdata, handles)
% hObject    handle to slider_125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_125, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_125_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_250_Callback(hObject, eventdata, handles)
% hObject    handle to slider_250 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_250, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_250_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_250 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_500_Callback(hObject, eventdata, handles)
% hObject    handle to slider_500 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_500, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_500_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_500 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_1k_Callback(hObject, eventdata, handles)
% hObject    handle to slider_1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_1k, 'String', get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function slider_1k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_2k_Callback(hObject, eventdata, handles)
% hObject    handle to slider_2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_2k, 'String', get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function slider_2k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_4k_Callback(hObject, eventdata, handles)
% hObject    handle to slider_4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_4k, 'String', get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function slider_4k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_8k_Callback(hObject, eventdata, handles)
% hObject    handle to slider_8k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_8k, 'String', get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function slider_8k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_8k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_16k_Callback(hObject, eventdata, handles)
% hObject    handle to slider_16k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.text_16k, 'String', get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function slider_16k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_16k (see GCBO)
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


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider_32, 'Value', 0);
set(handles.slider_64, 'Value', 0);
set(handles.slider_125, 'Value', 0);
set(handles.slider_250, 'Value', 0);
set(handles.slider_500, 'Value', 0);
set(handles.slider_1k, 'Value', 0);
set(handles.slider_2k, 'Value', 0);
set(handles.slider_4k, 'Value', 0);
set(handles.slider_8k, 'Value', 0);
set(handles.slider_16k, 'Value', 0);
set(handles.text_32, 'String', '0');
set(handles.text_64, 'String', '0');
set(handles.text_125, 'String', '0');
set(handles.text_250, 'String', '0');
set(handles.text_500, 'String', '0');
set(handles.text_1k, 'String', '0');
set(handles.text_2k, 'String', '0');
set(handles.text_4k, 'String', '0');
set(handles.text_8k, 'String', '0');
set(handles.text_16k, 'String', '0');

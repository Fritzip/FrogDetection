function varargout = launcher(varargin)
% LAUNCHER MATLAB code for launcher.fig
%      LAUNCHER, by itself, creates a new LAUNCHER or raises the existing
%      singleton*.
%
%      H = LAUNCHER returns the handle to a new LAUNCHER or the handle to
%      the existing singleton*.
%
%      LAUNCHER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCHER.M with the given input arguments.
%
%      LAUNCHER('Property','Value',...) creates a new LAUNCHER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launcher_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launcher_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launcher

% Last Modified by GUIDE v2.5 22-May-2014 11:41:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launcher_OpeningFcn, ...
                   'gui_OutputFcn',  @launcher_OutputFcn, ...
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


% --- Executes just before launcher is made visible.
function launcher_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to launcher (see VARARGIN)

% Declaration
handles.filepath = cell(1);
handles.launch = 0;

set(handles.popupmenu,'Value',3);
set(handles.gui,'Name','Choose your parameters')
% Choose default command line output for launcher
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launcher wait for user response (see UIRESUME)
uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = launcher_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
list = get(handles.popupmenu,'String');
val = get(handles.popupmenu,'Value');
varargout{1} = str2double(list{val});
varargout{2} = str2double(get(handles.val2,'String'));
varargout{3} = str2double(get(handles.val3,'String'));
varargout{4} = str2double(get(handles.val4,'String'));
varargout{5} = str2double(get(handles.val5,'String'));
varargout{6} = str2double(get(handles.val6,'String'));
varargout{7} = str2double(get(handles.val7,'String'));
varargout{8} = str2double(get(handles.val8,'String'));
varargout{9} = get(handles.radiobutton1,'Value');
varargout{10} = get(handles.radiobutton2,'Value');
varargout{11} = get(handles.radiobutton3,'Value');
varargout{12} = handles.filepath;
varargout{13} = handles.launch;

delete(handles.gui)


% --- Executes during object creation, after setting all properties.
function val6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function val5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in launch.
function launch_Callback(hObject, eventdata, handles)
% hObject    handle to launch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while 1
    filenames = get(handles.filenames,'String');
    pathname = get(handles.pathname,'String');
    splitfilenames = strsplit(filenames,';');
    handles.filepath = cell(length(splitfilenames)-1,1);
    if isempty(handles.filepath)
        randpath_Callback(hObject, eventdata, handles)
    else
        break
    end
end

VALIDPATH = 1;
for i = 1:length(splitfilenames)-1
    handles.filepath{i} = strcat(pathname,splitfilenames{i});
    if ~isequal(exist(handles.filepath{i},'file'),2)
        VALIDPATH = 0;
        break
    end
end

if VALIDPATH
    handles.launch = 1;
    guidata(hObject, handles);
    close(handles.gui)
else
    disp('Error, wrong file path')
end

% --- Executes during object creation, after setting all properties.
function filenames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in filebrowser.
function filebrowser_Callback(hObject, eventdata, handles)
% hObject    handle to filebrowser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
splitpath = strsplit(pwd,'\');
joinpath = strjoin(splitpath(1:end-1),'\');

[handles.FileName, handles.PathName] = uigetfile('*.wav','Select audio(s) file(s)','MultiSelect', 'on',joinpath);
if handles.PathName
    txtedit = '';
    sep = ';';
    if ~iscell(handles.FileName); handles.FileName = {handles.FileName}; end
    for i = 1:length(handles.FileName)
        txtedit = strcat(txtedit,handles.FileName{i},sep);
    end
    set(handles.filenames,'String',txtedit) 
    set(handles.pathname,'String',handles.PathName)
end

% --- Executes on button press in randpath.
function randpath_Callback(hObject, eventdata, handles)
% hObject    handle to randpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fold = 3;
    box = randi([1 4],1);
    [files, foldpath] = getallfiles(fold,box);
    files = files(randperm(length(files)));
    files = files(1);%(1:randi([1 4],1));
    txtedit = '';
    sep = ';';
    for file = files'
        txtedit = strcat(txtedit, file.name, sep);
    end
    set(handles.filenames,'String',txtedit) 
    set(handles.pathname,'String',foldpath)

% --- Executes when user attempts to close gui.
function gui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    uiresume(hObject);
else
    delete(hObject);
end


% --- Executes on key press with focus on gui and none of its controls.
function gui_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to gui (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if isequal(eventdata.Key,'return')
     launch_Callback(hObject, eventdata, handles)
end

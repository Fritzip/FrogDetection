function varargout = check_results(varargin)
% CHECK_RESULTS MATLAB code for check_results.fig
%      CHECK_RESULTS, by itself, creates a new CHECK_RESULTS or raises the existing
%      singleton*.
%
%      H = CHECK_RESULTS returns the handle to a new CHECK_RESULTS or the handle to
%      the existing singleton*.
%
%      CHECK_RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHECK_RESULTS.M with the given input arguments.
%
%      CHECK_RESULTS('Property','Value',...) creates a new CHECK_RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before check_results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to check_results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help check_results

% Last Modified by GUIDE v2.5 21-May-2014 14:08:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @check_results_OpeningFcn, ...
                   'gui_OutputFcn',  @check_results_OutputFcn, ...
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


% --- Executes just before check_results is made visible.
function check_results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to check_results (see VARARGIN)

handles.classif = varargin{1};
handles.scores = varargin{2};
handles.filename = varargin{3};
set(handles.figure1,'Name',handles.filename)
handles.compteur = 1;
readandplot(hObject, eventdata, handles);

% Choose default command line output for launcher
handles.output = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launcher wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = check_results_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);


% --- Executes on button press in signal.
function signal_Callback(hObject, eventdata, handles)
% hObject    handle to signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.compteur = handles.compteur + 1;
readandplot(hObject, eventdata, handles);
handles.output = [handles.output 1];
guidata(hObject, handles);

% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.compteur = handles.compteur + 1;
readandplot(hObject, eventdata, handles);
handles.output = [handles.output 0];
guidata(hObject, handles);

function readandplot(hObject, eventdata, handles)
if handles.compteur <= size(handles.classif,1)
    handles.F = handles.classif{handles.compteur,1};
    handles.T = handles.classif{handles.compteur,2};
    handles.P = handles.classif{handles.compteur,3};
    surf(handles.T, handles.F, 10*log10(handles.P), 'edgecolor', 'none'); axis tight; title(strcat(num2str(handles.compteur),'/',num2str(size(handles.classif,1))));
    view(0,90);
    if isequal(handles.classif{handles.compteur,4},1)
        set(handles.figure1,'Color',[198/255 227/255 163/255]);
    else
        set(handles.figure1,'Color',[227/255 163/255 163/255]);
    end
else
    close(handles.figure1)
end
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    uiresume(hObject);
else
    delete(hObject);
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.compteur = handles.compteur - 1;
readandplot(hObject, eventdata, handles);
handles.output = handles.output(1:end-1);
guidata(hObject, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if isequal(eventdata.Key,'numpad1')
     signal_Callback(hObject, eventdata, handles)
elseif isequal(eventdata.Key,'numpad2')
     noise_Callback(hObject, eventdata, handles)
elseif isequal(eventdata.Key,'backspace') || isequal(eventdata.Key,'numpad0')
     back_Callback(hObject, eventdata, handles)
end

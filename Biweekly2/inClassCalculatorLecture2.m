function varargout = inClassCalculatorLecture2(varargin)
% INCLASSCALCULATORLECTURE2 MATLAB code for inClassCalculatorLecture2.fig
%      INCLASSCALCULATORLECTURE2, by itself, creates a new INCLASSCALCULATORLECTURE2 or raises the existing
%      singleton*.
%
%      H = INCLASSCALCULATORLECTURE2 returns the handle to a new INCLASSCALCULATORLECTURE2 or the handle to
%      the existing singleton*.
%
%      INCLASSCALCULATORLECTURE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INCLASSCALCULATORLECTURE2.M with the given input arguments.
%
%      INCLASSCALCULATORLECTURE2('Property','Value',...) creates a new INCLASSCALCULATORLECTURE2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inClassCalculatorLecture2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inClassCalculatorLecture2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inClassCalculatorLecture2

% Last Modified by GUIDE v2.5 22-Jan-2013 14:28:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inClassCalculatorLecture2_OpeningFcn, ...
                   'gui_OutputFcn',  @inClassCalculatorLecture2_OutputFcn, ...
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


% --- Executes just before inClassCalculatorLecture2 is made visible.
function inClassCalculatorLecture2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inClassCalculatorLecture2 (see VARARGIN)

% Choose default command line output for inClassCalculatorLecture2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inClassCalculatorLecture2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = inClassCalculatorLecture2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input1TextBox_Callback(hObject, eventdata, handles)
% hObject    handle to input1TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input1TextBox as text
%        str2double(get(hObject,'String')) returns contents of input1TextBox as a double


% --- Executes during object creation, after setting all properties.
function input1TextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input1TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input2TextBox_Callback(hObject, eventdata, handles)
% hObject    handle to input2TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input2TextBox as text
%        str2double(get(hObject,'String')) returns contents of input2TextBox as a double


% --- Executes during object creation, after setting all properties.
function input2TextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input2TextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)
% hObject    handle to addButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%1. Get the inputs
inp1 = str2num(get(handles.input1TextBox,'String'));
inp2 = str2num(get(handles.input2TextBox,'String'));

%2. addInputs

addInputs = inp1 + inp2;

%3. Display the result
set(handles.operatorTextBox,'String','+');
set(handles.resultTextBox,'String',num2str(addInputs));

%4. Updates all objects in the GUI
guidata(hObject, handles);


% --- Executes on button press in subtractButton.
function subtractButton_Callback(hObject, eventdata, handles)
% hObject    handle to subtractButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%1. Get the inputs
inp1 = str2num(get(handles.input1TextBox,'String'));
inp2 = str2num(get(handles.input2TextBox,'String'));

%2. subInputs

subInputs = inp1 - inp2;

%3. Display the result
set(handles.operatorTextBox,'String','-');
set(handles.resultTextBox,'String',num2str(subInputs));

%4. Updates all objects in the GUI
guidata(hObject, handles);


% --- Executes on button press in multiplyButton.
function multiplyButton_Callback(hObject, eventdata, handles)
% hObject    handle to multiplyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%1. Get the inputs
inp1 = str2num(get(handles.input1TextBox,'String'));
inp2 = str2num(get(handles.input2TextBox,'String'));

%2. mulInputs

mulInputs = inp1 * inp2;

%3. Display the result
set(handles.operatorTextBox,'String','*');
set(handles.resultTextBox,'String',num2str(mulInputs));

%4. Updates all objects in the GUI
guidata(hObject, handles);


% --- Executes on button press in divideButton.
function divideButton_Callback(hObject, eventdata, handles)
% hObject    handle to divideButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%1. Get the inputs
inp1 = str2num(get(handles.input1TextBox,'String'));
inp2 = str2num(get(handles.input2TextBox,'String'));

%2. divInputs

if inp2 == 0
    set(handles.resultTextBox,'String','Invalid');
    msgbox('Invalid!!!!')
    
else
    
    divInputs = inp1 / inp2;
    set(handles.resultTextBox,'String',num2str(divInputs));
    
end
%3. Display the result
set(handles.operatorTextBox,'String','/');


%4. Updates all objects in the GUI
guidata(hObject, handles);

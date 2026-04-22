function varargout = SerialAssistant(varargin)
% SERIALASSISTANT MATLAB code for SerialAssistant.fig
%      SERIALASSISTANT, by itself, creates a new SERIALASSISTANT or raises the existing
%      singleton*.
%
%      H = SERIALASSISTANT returns the handle to a new SERIALASSISTANT or the handle to
%      the existing singleton*.
%
%      SERIALASSISTANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIALASSISTANT.M with the given input arguments.
%
%      SERIALASSISTANT('Property','Value',...) creates a new SERIALASSISTANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SerialAssistant_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SerialAssistant_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SerialAssistant

% Last Modified by GUIDE v2.5 13-Feb-2020 16:23:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SerialAssistant_OpeningFcn, ...
                   'gui_OutputFcn',  @SerialAssistant_OutputFcn, ...
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


% --- Executes just before SerialAssistant is made visible.
function SerialAssistant_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SerialAssistant (see VARARGIN)

% Choose default command line output for SerialAssistant
handles.output = hObject;

set(gcf,'numbertitle', 'off', 'name', '串口助手小工具'); % 设置当前窗口名字
movegui('center'); % 将窗口置于屏幕中间
% 设置当前窗口各个控件的参数
set(handles.popupmenu_baud_rate, 'string', {'4800', '9600', '14400', '19200', '38400',...
    '57600', '76800', '115200'}, 'value', 8); % 波特率
set(handles.popupmenu_data_bits, 'string', {'8', '9'}); % 数据位
set(handles.popupmenu_stop_bits, 'string', {'1', '1.5', '2'}); % 停止位
set(handles.popupmenu_parity, 'string', {'NONE', 'ODD', 'EVEN'}); % 校验位
global gUARTOpenFlag; % 串口开启标志，0-串口为关闭状态，1-串口为开启状态
gUARTOpenFlag = 0; % 串口默认为关闭状态
gotDataFlag = false; % 串口接收到数据标志，默认为未接收到数据
strRec = ''; % 已经接收到的字符串，默认为空
dispFlag = false; % 正在进行数据显示的标志 

setappdata(hObject, 'gotDataFlag', gotDataFlag); % 更新gotDataFlag
setappdata(hObject, 'strRec', strRec); % 更新strRec
setappdata(hObject, 'dispFlag', dispFlag); % 更新dispFlag
ScanUART(handles); % 扫描串口

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SerialAssistant wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SerialAssistant_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_rec_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rec as text
%        str2double(get(hObject,'String')) returns contents of edit_rec as a double


% --- Executes during object creation, after setting all properties.
function edit_rec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_port_num.
function popupmenu_port_num_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_port_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_port_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_port_num


% --- Executes during object creation, after setting all properties.
function popupmenu_port_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_port_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_baud_rate.
function popupmenu_baud_rate_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_baud_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_baud_rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_baud_rate


% --- Executes during object creation, after setting all properties.
function popupmenu_baud_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_baud_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_parity.
function popupmenu_parity_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_parity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_parity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_parity


% --- Executes during object creation, after setting all properties.
function popupmenu_parity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_parity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_data_bits.
function popupmenu_data_bits_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_data_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_data_bits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_data_bits


% --- Executes during object creation, after setting all properties.
function popupmenu_data_bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_data_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_stop_bits.
function popupmenu_stop_bits_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_stop_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_stop_bits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_stop_bits


% --- Executes during object creation, after setting all properties.
function popupmenu_stop_bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_stop_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_open.
function pushbutton_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gUARTOpenFlag; % 串口开启标志，0-串口为关闭状态，1-串口为开启状态
global gSerial; % 串口对象
delete(instrfindall); % 删除所有串口对象
num = get(handles.popupmenu_port_num, 'value'); % 获取所选项的序号 
cellArr = get(handles.popupmenu_port_num, 'string'); % 获取所有选项组成的元胞数组
cellArrPortNum = cellArr(num); % 根据所选项的序号，获取所选串口号的字符串元胞数组

num = get(handles.popupmenu_baud_rate, 'value'); % 获取所选项的序号
cellArr = get(handles.popupmenu_baud_rate, 'string'); % 获取所有选项组成的元胞数组
cellArrBaudRate = cellArr(num); % 根据所选项的序号，获取所选波特率的字符串元胞数组

num = get(handles.popupmenu_data_bits, 'value'); % 获取所选项的序号
cellArr = get(handles.popupmenu_data_bits, 'string'); % 获取所有选项组成的元胞数组
cellArrDataBits = cellArr(num); % 根据所选项的序号，获取所选数据位的字符串元胞数组

num = get(handles.popupmenu_stop_bits, 'value'); % 获取所选项的序号
cellArr = get(handles.popupmenu_stop_bits, 'string'); % 获取所有选项组成的元胞数组
cellArrStopBits = cellArr(num); % 根据所选项的序号，获取所选停止位字符串元胞数组

num = get(handles.popupmenu_parity, 'value'); % 获取所选项的序号
cellArr = get(handles.popupmenu_parity, 'string'); % 获取所有选项组成的元胞数组
cellArrParity = cellArr(num); % 根据所选项的序号，获取所选校验位的字符串元胞数组

strPortNum = cellArrPortNum{1}; % 获取所选串口号字符串      
dBaudRate = str2double(cellArrBaudRate); % 将字符串转换为双精度的波特率        
dDataBits = str2double(cellArrDataBits); % 将字符串转换为双精度的数据位
dStopBits = str2double(cellArrStopBits); % 将字符串转换为双精度的停止位
strParity = cellArrParity{1}; % 获取所选校验和字符串

% 创建一个串口对象
gSerial = serial(strPortNum, 'BaudRate', dBaudRate, 'DataBits', dDataBits, ... 
    'StopBits', dStopBits, 'Parity', strParity, 'BytesAvailableFcnCount', 10,...
    'BytesAvailableFcnMode', 'byte', 'BytesAvailableFcn', {@ProcRecData, handles},...
    'TimerPeriod', 0.05, 'timerfcn', {@DispData, handles});  

try
    fopen(gSerial); % 打开串口
    gUARTOpenFlag = 1; % 将串口打开标志置为已打开
catch
    gUARTOpenFlag = 0; % 将串口打开标志置为未打开
    msgbox('串口打开失败！');  
end

set(handles.checkbox_regular_send, 'Enable', 'on'); % 启用定时发送复选框
set(hObject, 'Enable', 'off'); % 禁用打开串口按钮
set(handles.pushbutton_close, 'Enable', 'on'); % 启用关闭串口按钮


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSerial; % 串口对象
global gUARTOpenFlag; % 串口开启标志，0-串口为关闭状态，1-串口为开启状态

if (gUARTOpenFlag == 1) % 如果串口开启标志为1
    gUARTOpenFlag = 0; % 将该标志置为0
    fclose(gSerial); % 关闭串口
end

t = timerfind; % 查找定时器
if (~isempty(t)) % 如果查找到定时器
    stop(t); % 关闭定时器
    delete(t); % 删除定时器
end
set(handles.checkbox_regular_send, 'value', 0); % 定时发送复选框设置为不选中
set(hObject,'Enable','off'); % 禁用关闭串口按钮
set(handles.pushbutton_open,'Enable','on'); % 启用打开串口按钮
set(handles.checkbox_regular_send, 'Enable', 'off'); % 禁用定时发送复选框


% --- Executes on button press in checkbox_regular_send.
function checkbox_regular_send_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_regular_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox_regular_send
if get(hObject, 'value') % 如果定时发送复选框
    t1 = 0.001 * str2double(get(handles.edit_send_period, 'string')); % 获取定时发送周期
    sendTimer = timer('ExecutionMode', 'fixedrate', 'Period', t1, 'TimerFcn',...
        {@pushbutton_send_Callback, handles}); % 创建定时器
    set(handles.edit_send_period, 'Enable', 'off'); % 定时发送周期文本框禁止编辑
    set(handles.edit_send, 'Enable', 'inactive'); % 数据发送文本框禁止编辑
    start(sendTimer); % 启动定时器
else
    set(handles.edit_send_period, 'Enable', 'on'); % 定时发送周期文本框允许编辑
    set(handles.edit_send, 'Enable', 'on'); % 数据发送文本框允许编辑
    sendTimer = timerfind; % 查找定时器
    stop(sendTimer); % 关闭定时器
    delete(sendTimer); % 删除定时器    
end

% --- Executes on button press in pushbutton_send.
function pushbutton_send_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSerial; % 串口对象
global gUARTOpenFlag; % 串口开启标志，0-串口为关闭状态，1-串口为开启状态

sendData = ConvertStr2Dec(handles); % 将串口发送编辑区的十六进制字符串转换为十进制数
if isequal(gUARTOpenFlag, 1) % 判断串口是否已经打开
    fwrite(gSerial, sendData, 'uint8', 'async'); % 通过串口发送数据
else
    warndlg("串口未打开"); % 弹出警告窗
end


function edit_send_period_Callback(hObject, eventdata, handles)
% hObject    handle to edit_send_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_send_period as text
%        str2double(get(hObject,'String')) returns contents of edit_send_period as a double


% --- Executes during object creation, after setting all properties.
function edit_send_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_send_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_send_Callback(hObject, eventdata, handles)
% hObject    handle to edit_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_send as text
%        str2double(get(hObject,'String')) returns contents of edit_send as a double


% --- Executes during object creation, after setting all properties.
function edit_send_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clr_send.
function pushbutton_clr_send_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clr_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_send,'String',[]); % 清空串口发送区

% --- Executes on button press in pushbutton_clr_rec.
function pushbutton_clr_rec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clr_rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.figure1, 'strRec', ''); % 清空要显示的字符串
set(handles.edit_rec,'String',[]); % 清空串口接收区

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gSerial; % 串口对象
global gUARTOpenFlag; % 串口开启标志，0-串口为关闭状态，1-串口为开启状态

if (gUARTOpenFlag == 1) % 如果串口开启标志为1
    gUARTOpenFlag = 0; % 将该标志置为0
    fclose(gSerial); % 关闭串口
end

t = timerfind; % 查找定时器
if (~isempty(t)) % 如果查找到定时器
    stop(t); % 关闭定时器
    delete(t); % 删除定时器
end

close all;

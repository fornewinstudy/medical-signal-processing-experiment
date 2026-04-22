function varargout = ProcData(varargin)
% PROCDATA MATLAB code for ProcData.fig
%      PROCDATA, by itself, creates a new PROCDATA or raises the existing
%      singleton*.
%
%      H = PROCDATA returns the handle to a new PROCDATA or the handle to
%      the existing singleton*.
%
%      PROCDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROCDATA.M with the given input arguments.
%
%      PROCDATA('Property','Value',...) creates a new PROCDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProcData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProcData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProcData

% Last Modified by GUIDE v2.5 26-Feb-2020 08:57:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProcData_OpeningFcn, ...
                   'gui_OutputFcn',  @ProcData_OutputFcn, ...
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


% --- Executes just before ProcData is made visible.
function ProcData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProcData (see VARARGIN)

% Choose default command line output for ProcData
handles.output = hObject;

set(gcf, 'numbertitle', 'off', 'name', '数据处理小工具'); % 设置当前窗口名字
movegui('center'); % 将窗口置于屏幕中间
global gDispFlag; % 动态静态显示标志，0-静态显示，1-动态显示
gDispFlag = 0; % 默认为静态显示
global gDispWave; % 动态显示的波形数组
global gDataCnt; % 计数变量
gDataCnt = 1; % 初始值设置为1
global gWaveGap; % 波形间隙
gWaveGap = 50; % 默认为50
global gLoadFlag; % 加载数据标志，0-未加载，1-已加载
gLoadFlag = 0; % 默认为未加载数据
global gPlayTimer; % 数据动态显示定时器对象
gPlayTimer = timer('TimerFcn', {@DemoData, handles}, 'Period', 0.001,... 
    'ExecutionMode', 'fixedDelay', 'StartDelay', 0.2); % 创建一个定时器对象
global MAX_AXES_LEN; % 横坐标长度
MAX_AXES_LEN = 2500; % 由于坐标轴只能显示2500个数，因此这里固定设置为2500
gDispWave = NaN(1, MAX_AXES_LEN); % 将动态显示的波形数组清空

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProcData wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = ProcData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MAX_AXES_LEN; % 横坐标长度
global gPlayTimer; % 数据动态显示定时器对象
global gDispWave; % 动态显示的波形数组

switch get(gPlayTimer, 'Running')
    case 'on'
        stop(gPlayTimer); % 如果定时器打开，则关闭定时器
end
delete(gPlayTimer); % 删除定时器
gDispWave = NaN(1, MAX_AXES_LEN); % 将动态显示的波形数组清空


function edit_data_Callback(hObject, eventdata, handles)
% hObject    handle to edit_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_data as text
%        str2double(get(hObject,'String')) returns contents of edit_data as a double


% --- Executes during object creation, after setting all properties.
function edit_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_data.
function pushbutton_save_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gLoadFlag; % 加载数据标志，0-未加载，1-已加载
[fileName, pathName] = uiputfile('*.csv'); % 获取文件名和文件路径
fileInfo = [pathName, fileName]; % 将文件路径和文件名拼接之后赋值给fileInfo
if (gLoadFlag == 1) % 如果数据已经加载
    saveData = handles.originalData; % 获取handles所包含的用户定义的数据变量
    try
        % "w+"表示打开可读写文件，若文件存在则清空该文件，若文件不存在则创建该文件
        fid = fopen(fileInfo, 'w+'); % 打开或创建文件，fid为文件句柄
        fprintf(fid, '%f\n', saveData); % 向文件写入数据（小数形式）
        fclose(fid); % 关闭文件
    catch
        s = lasterror;
        disp(s.message);
    end
end

% --- Executes on button press in pushbutton_load_data.
function pushbutton_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gDispFlag; % 动态静态显示标志，0-静态显示，1-动态显示
global gPlayTimer; % 数据动态显示定时器对象
global gLoadFlag; % 加载数据标志，0-未加载，1-已加载

[fileName, pathName] = uigetfile('*.csv'); % 获取文件名和文件路径
fileInfo = [pathName, fileName]; % 将文件路径和文件名拼接之后赋值给fileInfo

try
    readData = csvread(fileInfo); % 从csv文件读取数据，并赋值给readData
    set(handles.edit_data, 'String', num2str(readData')); % 列向量先转置为行向量，再转字符并显示
    handles.originalData = readData; % 将readData赋值给handles结构体的成员变量    
    guidata(hObject, handles); % 更新handles
    if (gDispFlag == 1) % 如果为动态显示
        switch get(gPlayTimer, 'Running')
            case 'off'
                start(gPlayTimer); % 如果定时器关闭，则打开定时器
        end
    else
        axes(handles.axes_wave); % 创建一个坐标轴对象
        [len, ~] = size(readData);
        n = 1 : len;
        plot(n, readData(n), 'b');        
    end
    set(handles.pushbutton_save_data, 'Enable', 'on'); % 读取数据操作成功后，启用存储数据按钮
    gLoadFlag = 1; % 将gLoadFlag设置为1，表示数据已经加载成功
catch
    s = lasterror;
    gLoadFlag = 0; % 将gLoadFlag设置为0，表示数据未加载成功
end

% --- Executes on button press in radiobutton_static_disp.
function radiobutton_static_disp_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_static_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_static_disp
global gDispFlag; % 动态静态显示标志，0-静态显示，1-动态显示
global gPlayTimer; % 数据动态显示定时器对象
global gLoadFlag; % 加载数据标志，0-未加载，1-已加载
gDispFlag = 0; % 静态显示
switch get(gPlayTimer, 'Running')
    case 'on'
        stop(gPlayTimer); % 如果定时器打开，则关闭定时器
end

if (gLoadFlag == 1) % 如果数据已经加载
    dispData = handles.originalData; % 通过handles获取用户定义的数据变量
    axes(handles.axes_wave); % 创建坐标轴对象
    [len, ~] = size(dispData); % 获取数据长度
    n = 1 : len; % 横坐标
    plot(n, dispData(n), 'b'); % 绘制波形
end


% --- Executes on button press in radiobutton_dynamic_disp.
function radiobutton_dynamic_disp_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_dynamic_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_dynamic_disp
global gDispFlag; % 动态静态显示标志，0-静态显示，1-动态显示
global gPlayTimer; % 数据动态显示定时器对象
global gDataCnt;  % 计数变量
global MAX_AXES_LEN; % 横坐标长度
global gDispWave; % 动态显示的波形数组
global gOriginalData; % 动态显示的数据

gDispWave = NaN(1, MAX_AXES_LEN); % 将动态显示的波形数组清空
gDataCnt = 1; % 初始值设置为1
gDispFlag = 1; % 动态显示 
gOriginalData = handles.originalData; % 获取handles所包含的用户定义的数据变量

switch get(gPlayTimer, 'Running')
    case 'off'
        start(gPlayTimer); % 如果定时器关闭，则打开定时器
end

function varargout = PackUnpack(varargin)
% PACKUNPACK MATLAB code for PackUnpack.fig
%      PACKUNPACK, by itself, creates a new PACKUNPACK or raises the existing
%      singleton*.
%
%      H = PACKUNPACK returns the handle to a new PACKUNPACK or the handle to
%      the existing singleton*.
%
%      PACKUNPACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PACKUNPACK.M with the given input arguments.
%
%      PACKUNPACK('Property','Value',...) creates a new PACKUNPACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PackUnpack_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PackUnpack_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PackUnpack

% Last Modified by GUIDE v2.5 10-Feb-2020 16:32:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State =  struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PackUnpack_OpeningFcn, ...
                   'gui_OutputFcn',  @PackUnpack_OutputFcn, ...
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


% --- Executes just before PackUnpack is made visible.
function PackUnpack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PackUnpack (see VARARGIN)

% Choose default command line output for PackUnpack
handles.output = hObject;

set(gcf, 'name', '打包解包小工具'); % 设置当前窗口名字
% movegui('center'); % 将窗口置于屏幕中间
movegui(gcf, [100 200]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PackUnpack wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = PackUnpack_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_mod_id_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mod_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mod_id as text
%        str2double(get(hObject,'String')) returns contents of edit_mod_id as a double


% --- Executes during object creation, after setting all properties.
function edit_mod_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mod_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sec_id_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sec_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sec_id as text
%        str2double(get(hObject,'String')) returns contents of edit_sec_id as a double


% --- Executes during object creation, after setting all properties.
function edit_sec_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sec_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_pack.
function pushbutton_pack_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

modIDString = get(handles.edit_mod_id, 'String'); % 通过控件获取模块ID
modIDNum = hex2dec(modIDString); % 将十六进制字符串转换为十进制数
secIDString = get(handles.edit_sec_id, 'String'); % 通过控件获取二级ID
secIDNum = hex2dec(secIDString); % 将十六进制字符串转换为十进制数
rawDat = get(handles.edit_pack_din, 'String'); % 通过控件获取原始数据，共计6个字节

data6 = zeros(1, 6); % 初始化数组，每个元素赋值为0
for m = 1 : 6   
   % 取出每个数据（共计6个字节），并转换为十进制数
   data6(m) = hex2dec(rawDat(3 * m - 2 : 3 * m - 1));
end

packRawDat = zeros(1, 10); % 初始化打包前数据包数组
packRawDat = [modIDNum, secIDNum, data6]; % 组合为打包前的数据包，共计8个字节
packRslt = Pack(packRawDat); % 进行打包操作
packRsltString = ''; % 创建一个空字符串用来存放打包结果

for k = 1 : 10
   packRsltString = [packRsltString, dec2hex(packRslt(k), 2), ' ']; % 转换为打包结果字符串
end

set(handles.edit_pack_dout, 'String', packRsltString); % 将打包结果显示到控件



% --- Executes on button press in pushbutton_unpack.
function pushbutton_unpack_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_unpack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rawDat = get(handles.edit_unpack_din, 'String'); % 通过控件获取原始数据，共计10个字节
unpackRawDat = zeros(1, 10); % 初始化解包前数据包数组
for k = 1 : 10
    % 取出每个数据（共计10个字节），并转换为十进制数 
    unpackRawDat(k) = hex2dec(rawDat(3 * k - 2 : 3 * k - 1)); 
end
 
% 进行解包操作，解包的结果为前8个字节（包括模块ID，二级ID，以及6个字节数据），后面2个字节忽略即可
unpackRslt = Unpack(unpackRawDat); 

unpackRsltString = ''; % 创建一个空字符串用来存放解包结果

if unpackRslt == 0 % 返回值为0表示解包错误
    set(handles.edit_unpack_dout, 'String', 'error!'); % 将error显示到控件
else    
    for k = 1 : 8
        unpackRsltString = [unpackRsltString, dec2hex(unpackRslt(k), 2), ' ']; % 转化为解包结果字符串
    end
    set(handles.edit_unpack_dout, 'String', unpackRsltString); % 将解包结果显示到控件   
end



function edit_unpack_dout_Callback(hObject, eventdata, handles)
% hObject    handle to edit_unpack_dout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_unpack_dout as text
%        str2double(get(hObject,'String')) returns contents of edit_unpack_dout as a double



% --- Executes during object creation, after setting all properties.
function edit_unpack_dout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_unpack_dout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_unpack_din_Callback(hObject, eventdata, handles)
% hObject    handle to edit_unpack_din (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_unpack_din as text
%        str2double(get(hObject,'String')) returns contents of edit_unpack_din as a double


% --- Executes during object creation, after setting all properties.
function edit_unpack_din_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_unpack_din (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pack_din_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pack_din (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pack_din as text
%        str2double(get(hObject,'String')) returns contents of edit_pack_din as a double


% --- Executes during object creation, after setting all properties.
function edit_pack_din_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pack_din (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pack_dout_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pack_dout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pack_dout as text
%        str2double(get(hObject,'String')) returns contents of edit_pack_dout as a double


% --- Executes during object creation, after setting all properties.
function edit_pack_dout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pack_dout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

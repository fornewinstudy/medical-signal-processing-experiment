function [ ] = ProcRecData(hObject, ~, handles)       
% 处理串口接收到的数据
%   输入参数hObject, handles
%   注意，既为串口可读取的字节数达到设定值后执行的回调函数，又被DispData所调用
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

strRec   = getappdata(handles.figure1, 'strRec'); % 获取串口要显示的数据
dispFlag = getappdata(handles.figure1, 'dispFlag'); % 是否正在执行显示数据操作
 
% 如果正在执行数据显示操作（调用DispData函数），则暂不接收串口数据
if (dispFlag == true)
    return;
end

% 获取串口可读取到的字节数
n = get(hObject, 'BytesAvailable');

% 如果串口可读取的字节数不为0
if (n > 0) 
    % 更新gotDataFlag，说明串口有数据需要显示
    setappdata(handles.figure1, 'gotDataFlag', true);
    % 读取串口数据，读取出来的数据为十进制的列向量
    readData = fread(hObject, n, 'uchar');
    % 将数据解析为要显示的字符串
    strHex1 = dec2hex(readData')'; 
    strHex2 = [strHex1; blanks(size(readData, 1))]; 
    strReadData = strHex2(:)';
    % 更新需要显示的字符串
    strRec = [strRec strReadData];
    setappdata(handles.figure1, 'strRec', strRec);
end
function DispData(hObject, eventdata, handles)
% 在串口接收区显示接收到的数据
%   输入参数hObject, eventdata, handles
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

gotDataFlag = getappdata(handles.figure1, 'gotDataFlag'); % 获取串口接收到数据标志
strRec = getappdata(handles.figure1, 'strRec'); % 获取已经接收到的数据

% 如果串口没有接收到数据，则尝试接收串口数据
if (gotDataFlag == false)
    ProcRecData(hObject, eventdata, handles);
end
% 如果串口有数据，则将这些数据显示到串口接收区
if (gotDataFlag == true)
    % 在执行显示数据函数时，不允许读取串口数据，即不执行串口的回调函数（ProcRecData）
    setappdata(handles.figure1, 'dispFlag', true);
    % 如果要显示的字符串长度超过10000，清空显示区
    if (length(strRec) > 10000)
        strRec = '';
        setappdata(handles.figure1, 'strRec', strRec);
    end
    % 在串口接收区显示接收到的数据
    set(handles.edit_rec, 'string', strRec);
    % 更新gotDataFlag，表示串口数据已经显示到串口接收区
    setappdata(handles.figure1, 'gotDataFlag', false);
    % 执行完显示数据函数后，允许读取串口数据
    setappdata(handles.figure1, 'dispFlag', false);
end
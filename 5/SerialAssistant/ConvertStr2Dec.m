function sendData = ConvertStr2Dec(handles)
% 将串口发送编辑区的十六进制字符串转换为十进制数
%   输入参数handles，GUI界面的句柄
%   输出参数sendData，待发送的十进制数据
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

str = get(handles.edit_send, 'string'); % 获取串口发送区的十六进制字符串
n = find(str == ' '); % 查找空格的索引
n =[0 n length(str) + 1]; % 在首尾增加索引
% 将两个相邻空格之间的十六进制字符串转换为十进制数，将其转化为数值
for k = 1 : length(n) - 1 
  hexData = str(n(k) + 1 : n(k + 1) - 1);  % 获取两个相邻空格之间的十六进制字符串
  if (length(hexData) == 2)
      strHex{k} = reshape(hexData, 2, [])'; % 将每个十六进制字符串转化为单元数组
  else
      strHex = []; % 清空
      warndlg("输入错误，正确格式：01 23 4A 5F"); % 弹出警告窗口      
      break; % 跳出循环
  end
end
sendData = hex2dec(strHex)'; % 将十六进制字符串转化为十进制数
% setappdata(handles.figure1, 'sendData', sendData); % 更新sendData
function packOut = Pack(packIn)
% 对数据进行打包
%   输入参数packIn，打包前的数据
%   输入参数packout，如果打包成功则为打包后的数据包，如果打包失败则为0
%   注意，数据头的BIT0为二级ID的BIT7，数据头的BIT1为数据1的BIT7，数据头的BIT2为数据2的BIT7，数据头
%     的BIT6为数据6的BIT7。
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

% 打包前的数据包长为8个字节，不为8个字节的包即为错误包，将返回值赋值为0，然后退出函数
if (length(packIn) ~= 8)
    packOut = 0;
    return;
end

checkSum = packIn(1); % 第一个字节为模块ID，取出模块ID，赋值给校验和变量
dataHead = 0; % 将数据头变量赋值为数0，即清除数据头的各比特位

for i = 9 : -1 : 3    
    % 数据头变量左移一位，赋值给新的数据头变量
    dataHead = bitshift(uint8(dataHead), 1, 'uint8');
    
    % 将最高位置1
    packIn(i) = bitor(packIn(i - 1), 128);
    
    % 数据与校验和变量相加，赋值给新的校验和变量
    checkSum = checkSum + packIn(i);
    
    % 取出原始数据的最高位，与数据头变量相或，赋值给新的数据头变量
    dataHead = bitor(uint8(dataHead), bitshift(bitand(packIn(i - 1), 128), -7, 'uint8'));    
end

% 数据头在数据包的第二个位置，仅次于模块ID，数据头的最高位也要置为1
packIn(2) = bitor(dataHead, 128);
% 将数据头变量与校验和变量相加，赋值给新的校验和变量
checkSum = checkSum + packIn(2);
% 将校验和变量的低7位取出，赋值给新的校验和变量
checkSum = bitand(checkSum, 127); 
% 校验和的最高位也要置为1
packIn(10) = bitor(checkSum, 128);

packOut = packIn; % 将packIn变量（保存着打包结果）赋值给输出参数
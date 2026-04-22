function DemoData(~, ~, handles)
% 在窗口对数据进行演示，即自动播放波形
%   handles，GUI界面的句柄
%   注意，由于坐标轴只能显示2500个数，因此，csv文件中的数据必须为2500个
%   COPYRIGHT 2018-2020 LEYUTEK. All rights reserved.

global gLoadFlag; % 加载数据标志，0-未加载，1-已加载
global gOriginalData; % 动态显示的数据
global gDispWave; % 动态显示的波形数组
global MAX_AXES_LEN; % 横坐标长度
global gDataCnt; % 计数器
global gWaveGap; % 波形间隙    

if (gLoadFlag == 1) % 如果数据已经加载
    if (gDataCnt > MAX_AXES_LEN) % 坐标轴固定显示2500个数
        gDataCnt = gDataCnt - MAX_AXES_LEN;
    end
    gDispWave(gDataCnt) = gOriginalData(gDataCnt); % gOriginalData来自于文件的数据
    % 每10个数据绘制一次波形
    if (mod(gDataCnt, 10) == 0)
        xLeft  = 1 : gDataCnt; % 左半部分波形的横坐标
        xRight = gDataCnt + gWaveGap : MAX_AXES_LEN; % 右半部的波形的横坐标，有10个数据的间距
        yLeft = gDispWave(xLeft); % 左半部分波形的纵坐标
        yRight = gDispWave(xRight); % 右半部分波形的纵坐标
        
        % 绘制波形
        plot(handles.axes_wave, xLeft, yLeft, 'b', xRight, yRight, 'r');
        % 设置横坐标
        set(handles.axes_wave, 'XLim', [1 MAX_AXES_LEN]);  
        drawnow; % 刷新屏幕
    end
    gDataCnt = gDataCnt + 1;
end
% 使用小波变换去除基线漂移
level = 4; % 小波变换的分解层数
wavelet_type = 'db4'; % 小波基类型

% 进行小波分解
[c, l] = wavedec(ecg_signal, level, wavelet_type);

% 将最后一层小波系数设为零，以去除低频分量
c(l(1)+1:end) = 0;

% 重构信号
baseline_removed_signal = waverec(c, l, wavelet_type);

y = filter(b, 1, x);

% 绘制滤波前后的时域波形
figure;
subplot(2,1,1);
plot(t, x);
title('滤波前的信号');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(2,1,2);
plot(t, y);
title('滤波后的信号');
xlabel('时间 (秒)');
ylabel('幅度');

% 计算并绘制滤波前后的幅度谱
X = fft(x);
Y = fft(y);
f = (0:length(X)-1)*fs/length(X)/1000; % 转换为kHz

figure;
subplot(2,1,1);
plot(f, 20*log10(abs(X)));
title('滤波前的信号频谱');
xlabel('频率 (kHz)');
ylabel('幅度 (dB)');

subplot(2,1,2);
plot(f, 20*log10(abs(Y)));
title('滤波后的信号频谱');
xlabel('频率 (kHz)');
ylabel('幅度 (dB)');
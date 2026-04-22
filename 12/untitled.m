% 生成输入信号 xn
n = 0:199;
xn = cos(0.1*pi*n) + 3*cos(0.4*pi*n);

% 调用滤波器设计函数 FIRfilter1
Hd = FIR1;

% 对信号进行滤波
yn = filter(Hd, xn);

% 绘制滤波前后信号的时域波形
figure;
subplot(2, 1, 1);
plot(n, xn);
title('滤波前信号时域波形');
xlabel('样本');
ylabel('幅度');
grid on;

subplot(2, 1, 2);
plot(n, yn);
title('滤波后信号时域波形');
xlabel('样本');
ylabel('幅度');
grid on;

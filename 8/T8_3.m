clc;
clear;

f1 = 2;%频率2 Hz
f2 = 2.02;%频率2.02 Hz
f3 = 2.07;%频率2.07 Hz
fs = 10;%采样频率
T = 1/fs;%采样间隔
N = 2048;%采样数据个数
n = 0:1:N-1;
x = sin(2*pi*f1*n*T)+sin(2*pi*f2*n*T)+sin(2*pi*f3*n*T);%采集到的数字信号

%256点DFT
N1 = 256; %计算DFT的数据长度
Xk1 = fft(x,N1);%求256点DFT
Mag_Xk1 = abs(Xk1);%求幅度谱
max1 = max(Mag_Xk1);%求幅度的最大值
freq1 = fs*(0:N1/2-1)/N1;%绘制频谱图时的横坐标
subplot(3,1,1);
plot(freq1,Mag_Xk1(1:N1/2)/max1,'LineWidth',1,'color','b');%绘制归一化幅度谱
axis([1.6 2.4 0 1]); % 只显示1.6-2.4Hz范围
xlabel('频率 f (Hz)','FontSize',14);
legend('N = 256');

%512点DFT
N2=512; %计算DFT的数据长度
Xk2 = fft(x,N2);%求DFT
Mag_Xk2 = abs(Xk2);%求幅度谱
max2 = max(Mag_Xk2);
freq2 = fs*(0:N2/2-1)/N2;%绘制频谱图时的横坐标
subplot(3,1,2);
plot(freq2,Mag_Xk2(1:N2/2)/max2,'LineWidth',1,'color','b');%绘制归一化幅度谱
axis([1.6 2.4 0 1]); % 只显示1.6-2.4Hz范围
xlabel('频率 f (Hz)','FontSize',14);
legend('N=512');
%1024点DFT
N3 = 1024; %计算DFT的数据长度
Xk3 = fft(x,N3);%求DFT
Mag_Xk3 = abs(Xk3);%求幅度谱
max3 = max(Mag_Xk3);
freq3 = fs*(0:N3/2-1)/N3;%绘制频谱图时的横坐标
subplot(3,1,3);
plot(freq3,Mag_Xk3(1:N3/2)/max3,'LineWidth',1,'color','b');%绘制归一化幅度谱
axis([1.6 2.4 0 1]); % 只显示1.6-2.4Hz范围
xlabel('频率 f (Hz)','FontSize',14);
legend('N=1024');
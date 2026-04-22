clc;
clear;

f0 = 50;
fs = 200;%采样频率
T = 1/fs;%采样间隔
SN = 500;%采样点数
n = 0:1:SN-1;
t = n*T;%采样时刻
x = sin(2*pi*f0*t);%采样
subplot(3,2,1);
N = 8;%采8个点
plot(t(1:N),x(1:N),'LineWidth',1.5,'color','b');%绘制样本
set(gcf, 'name', '信号的时域波形及幅度谱'); % 设置窗口的标题名
ylabel('x(t)','FontSize',14);
xlabel('时间 (s)','FontSize',14);
Xk = fft(x,N);%求N点DFT
Mag_Xk = abs(Xk);%求幅度谱
f = (0:N/2-1)*fs/N;%绘制频谱图时的横坐标
subplot(3,2,2);
stem(f,Mag_Xk(1:N/2),'Filled','MarkerSize',2,'LineWidth',1.5,'color','b');%绘制频谱图
axis([0,200,0,50]);
ylabel('|X(k)|','FontSize',14);
xlabel('频率 f (Hz)','FontSize',14);

N = 10;%采10个点
subplot(3,2,3);
plot(t(1:N),x(1:N),'LineWidth',1.5,'color','b');%绘制样本
set(gcf, 'name', '信号的时域波形及幅度谱'); % 设置窗口的标题名
ylabel('x(t)','FontSize',14);
xlabel('时间 (s)','FontSize',14);
Xk = fft(x,N);%求N点DFT
Mag_Xk = abs(Xk);%求幅度谱
f = (0:N/2-1)*fs/N;%绘制频谱图时的横坐标
subplot(3,2,4);
stem(f,Mag_Xk(1:N/2),'Filled','MarkerSize',2,'LineWidth',1.5,'color','b');%绘制频谱图
axis([0,200,0,50]);
ylabel('|X(k)|','FontSize',14);
xlabel('频率 f (Hz)','FontSize',14);

N = 80;%采80个点
subplot(3,2,5);
plot(t(1:N),x(1:N),'LineWidth',1.5,'color','b');%绘制样本
set(gcf, 'name', '信号的时域波形及幅度谱'); % 设置窗口的标题名
ylabel('x(t)','FontSize',14);
xlabel('时间 (s)','FontSize',14);
Xk = fft(x,N);%求N点DFT
Mag_Xk = abs(Xk);%求幅度谱
f = (0:N/2-1)*fs/N;%绘制频谱图时的横坐标
subplot(3,2,6);
stem(f,Mag_Xk(1:N/2),'Filled','MarkerSize',2,'LineWidth',1.5,'color','b');%绘制频谱图
axis([0,200,0,50]);
ylabel('|X(k)|','FontSize',14);
xlabel('频率 f (Hz)','FontSize',14);



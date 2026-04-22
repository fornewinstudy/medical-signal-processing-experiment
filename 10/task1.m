clc
clear
M = 101; % 窗函数的长度,可调整（如M = 101）

% 海宁窗
n = 0:M-1;
hanning_win = 0.5 * (1 - cos(2 * pi * n / (M - 1)));

% 哈明窗
hamming_win = 0.54 - 0.46 * cos(2 * pi * n / (M - 1));

% 布莱克曼窗
blackman_win = 0.42 - 0.5 * cos(2 * pi * n / (M - 1)) + 0.08 * cos(4 * pi * n / (M - 1));

% 绘制时域波形
figure;
subplot(3, 1, 1);
stem(n, hanning_win);
title('Hanning Window');
xlabel('n');
ylabel('Amplitude');
subplot(3, 1, 2);
stem(n, hamming_win);
title('Hamming Window');
xlabel('n');
ylabel('Amplitude');
subplot(3, 1, 3);
stem(n, blackman_win);
title('Blackman Window');
xlabel('n');
ylabel('Amplitude');

% 计算DTFT的样本并绘制幅度谱
N = 1000; % DTFT样本的个数

% 窗函数的DTFT
[XK_hanning, w_hanning] = dtft(hanning_win, n, N);
[XK_hamming, w_hamming] = dtft(hamming_win, n, N);
[XK_blackman, w_blackman] = dtft(blackman_win, n, N);

% 窗函数的幅度谱
figure;
subplot(3, 1, 1);
stem(w_hanning/pi, abs(XK_hanning));
title('Magnitude Spectrum - Hanning Window');
xlabel('w(pi)');
ylabel('|X(e^{jw})|');
subplot(3, 1, 2);
stem(w_hamming/pi, abs(XK_hamming));
title('Magnitude Spectrum - Hamming Window');
xlabel('w(pi)');
ylabel('|X(e^{jw})|');
subplot(3, 1, 3);
stem(w_blackman/pi, abs(XK_blackman));
title('Magnitude Spectrum - Blackman Window');
xlabel('w(pi0');
ylabel('|X(e^{jw})|');
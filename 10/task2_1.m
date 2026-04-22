clc
clear
%(1)
n = 0:99; % 序列的范围

% 定义序列x(n)
xn = zeros(size(n));
xn(1:50) = n(1:50) + 1;
xn(51:100) = 100 - n(51:100);

figure;
stem(n, xn);
title('xn(n)');

% 计算X(e^(jw))的样本
N = 10; % 采样点数
% DTFT
[XK, w] = dtft(xn, n, N);

figure;
stem(w/pi, abs(XK));
title('Magnitude Spectrum');
xlabel('w(pi)');
ylabel('|X(e^{jw})|');

% 计算yn = ifft(XK)
yn = ifft(XK);

figure;
subplot(2,1,1);
stem(0:9, abs(yn));
title('yn');

% 计算y2(n) 
y2n = zeros(1,length(yn));
temp2 = zeros(1,length(yn));
y2n = xn(1:10);
for r = 1:9
    temp2 = xn(r*10+1:(r+1)*10);
    y2n = y2n+temp2;
end
fprintf('yn与y2n的差异:%f\n', max(abs(yn-y2n)))

subplot(2,1,2);
stem(0:9, abs(y2n));
title('y2n');

% 比较yn和y2(n)是否相等
isequal(yn, y2n)

%(2)
% 计算X(e^(jw))的样本
N = 100; % 采样点数
% DTFT
[XK2, w2] = dtft(xn, n, N);

% 计算yn = ifft(XK)
yn2 = ifft(XK2);

figure;
subplot(2,1,1);
stem(n, abs(xn));
title('xn');
subplot(2,1,2);
stem(n, abs(yn2));
title('yn');

fprintf('xn与yn的差异:%f\n', max(abs(xn-yn2)))

% 比较yn和y2(n)是否相等
isequal(xn, yn2)
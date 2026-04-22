function [XK, w] = dtft1(xn, n, N)
    % xn: 信号强度
    % n: 横坐标
    % N: 计算的X(e^(jw))的样本个数
    
    L = length(xn); % 有限长序列的长度
    w = linspace(0, 2*pi, N); % 等间隔离散频率点
    XK = zeros(1, N); % 存储计算得到的样本
    
    for k = 1:N
        % 计算DTFT的样本值
        Xk = 0;
        for i = 1:L
            Xk = Xk + xn(i) * exp(-1i * w(k) * n(i));
        end
        XK(k) = Xk;
    end
end
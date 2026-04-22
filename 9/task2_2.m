% 已知序列
x1 = [2, 1, 1, 2];
x2 = [1, -1, -1, 1];

% 计算线性卷积
result_conv = conv(x1, x2);

% 逐步增加N的值，计算N点循环卷积，并比较与线性卷积的结果
N = 1;
while true
    % 使用 cconv 函数计算循环卷积
    result_cconv = cconv(x1, x2, N);
    
    % 如果N点循环卷积等于线性卷积，则输出结果并终止循环
    if isequal(result_cconv, result_conv)
        disp(['最小N值为: ' num2str(N)]);
        disp('循环卷积结果:');
        disp(result_cconv);
        break;
    end
    
    % 如果N超过序列长度的两倍，则终止循环，因为不可能再有更小的N
    if N > 2 * max(length(x1), length(x2))
        disp('无法找到N使得循环卷积等于线性卷积');
        break;
    end
    
    % 增加N的值
    N = N + 1;
end

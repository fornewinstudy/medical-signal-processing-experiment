% 已知序列
x1 = [2, 1, 1, 2];
x2 = [1, -1, -1, 1];

% 1) 计算两个序列的N点循环卷积，其中N = 4，7，8
N_values = [4, 7, 8];

for N = N_values
    % 使用 cconv 函数计算循环卷积
    result_cconv = cconv(x1, x2, N);

    % 显示结果
    disp(['N = ' num2str(N)]);
    disp('循环卷积结果:');
    disp(result_cconv);
    disp(' ');
end

% 2) 计算两个序列的线性卷积
result_conv = conv(x1, x2);

% 显示线性卷积结果
disp('线性卷积结果:');
disp(result_conv);

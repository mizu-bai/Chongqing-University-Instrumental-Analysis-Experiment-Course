% 实验12 阳极溶出差分脉冲伏安法测定自来水中的微量锌

% 初始化

clear; clc;

% 原始数据录入

origin = table; % 创建原始数据表格
origin.c = (0.2: 0.2: 0.8)' * 4.0E-2 / 50; % 标准液浓度
origin.ip = [1.307, 4.842, 6.686, 8.791]' * 1E-5; % 对应电流峰高度（记得此处换成自己的数据哦）

% 标准曲线绘制

% 线性拟合

k = polyfit(origin.c, origin.ip, 1);

% 标准曲线

standard = table; % 创建标准曲线表格
standard.c = (0: 0.2: 1)' * 4.0E-2 / 50; % 标准曲线浓度范围
standard.ip = polyval(k, standard.c); % 对应电流峰高度

% 待测样锌离子浓度求解

ipx = 5.115E-5; % 未知样电流峰高度（记得此处换成自己的数据哦）
cx = (ipx - k(2)) / k(1); % 利用标准曲线反推出对应浓度

% 绘图

plot(origin.c, origin.ip, 'ro', standard.c, standard.ip, 'b-', cx, ipx, 'g*');
xlabel('$$ c/({mol} \cdot {L} ^ {-1}) $$', 'Interpreter','latex');
ylabel('$$ {I}_{p} / A $$', 'Interpreter','latex');
title('锌溶出标准曲线');

% 待测样锌离子浓度求解输出

fprintf('待测样中锌离子浓度为%.2f*10^(-4)mol/L\n', cx * 1E4);

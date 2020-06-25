% 实验6 原子吸收光谱法测定自来水中钙含量

% 初始化

clear; clc;

% 原始数据录入

origin = table; % 创建原始数据表格
origin.c = (0: 2: 10)'; % 标准液浓度
origin.A = [0, 0.006, 0.012, 0.018, 0.024, 0.030]'; % 对应吸光度（记得此处换成自己的数据哦）

% 标准曲线绘制

% 线性拟合

k = polyfit(origin.c, origin.A, 1);

% 标准曲线

standard = table; % 创建标准曲线表格
standard.c = (0: 2: 10)'; % 标准曲线浓度范围
standard.A = polyval(k, standard.c); % 对应吸光度

% 待测样钙离子浓度求解

Ax = 0.011; % 未知样吸光度（记得此处换成自己的数据哦）
cx = (Ax - k(2)) / k(1); % 利用标准曲线反推出对应浓度

% 绘图

plot(origin.c, origin.A, 'ro', standard.c, standard.A, 'b-', cx, Ax, 'g*');
xlabel('$$ c({Ca} ^ {2+}) / ({\mu g} \cdot {L} ^ {-1}) $$', 'Interpreter', 'latex');
ylabel('$$ A $$', 'Interpreter', 'latex');
title('钙吸光标准曲线');

% 待测样氯离子浓度求解输出

fprintf('待测样中钙离子浓度为%.2fμg/L\n', cx);

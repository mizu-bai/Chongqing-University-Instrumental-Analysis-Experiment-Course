% 实验4 离子色谱法测定水中阴离子含量

% 初始化

clear; clc;

% 原始数据录入

origin = table; % 创建原始数据表格
origin.c = [10, 20, 50, 100, 200]'; % 标准液浓度
origin.a = [185.698, 583.354, 1416.234, 3148.396, 5220.963]'; % 对应峰面积（记得此处换成自己的数据哦）

% 标准曲线绘制

% 线性拟合

k = polyfit(origin.c, origin.a, 1);

% 标准曲线

standard = table; % 创建标准曲线表格
standard.c = (0: 10: 200)'; % 标准曲线浓度范围
standard.a = polyval(k, standard.c); % 对应峰面积

% 待测样氯离子浓度求解

ax = 818.283; % 未知样峰面积（记得此处换成自己的数据哦）
cx = (ax - k(2)) / k(1); % 利用标准曲线反推出对应浓度

% 绘图

plot(origin.c, origin.a, 'ro', standard.c, standard.a, 'b-', cx, ax, 'g*');
xlabel('$$ c({Cl} ^ {-}) / ({mg} \cdot {L} ^ {-1}) $$', 'Interpreter', 'latex');
ylabel('$$ A({Cl} ^ {-}) / ({uS} \cdot {sec}) $$', 'Interpreter', 'latex');
title('氯离子标准曲线');

% 待测样氯离子浓度求解输出

fprintf('待测样中氯离子浓度为%.2fmg/L\n', cx);

% 实验1 气相色谱法定量分析低碳混合醇

% 这个实验的数据处理不一定要用MATLAB，用Excel也可以做得挺好的

% 初始化

clear; clc;

% 标准液各组分相对含量，依次为甲醇，乙醇，正丙醇，正丁醇和正戊醇

m = [1, 1, 1, 1, 0.2];

% 定性分析

table1 = table; % 创建定性分析表
table1.Name = ["甲醇", "乙醇", "正丙醇", "正丁醇", "正戊醇"]'; % 组分名称
table1.tR1 = [2.069, 2.155, 2.418, 2.930, 3.657]'; % 保留时间 第1次（记得此处换成自己的数据哦）
table1.tR2 = [2.050, 2.136, 2.397, 2.912, 3.644]'; % 保留时间 第2次（记得此处换成自己的数据哦）
table1.tR3 = [2.042, 2.127, 2.386, 2.895, 3.625]'; % 保留时间 第3次（记得此处换成自己的数据哦）
table1.tRAVG = zeros(5, 1); % 平均保留时间

% 计算平均保留时间

for index = 1: 5
    
    table1.tRAVG(index) = mean([table1.tR1(index), table1.tR2(index), table1.tR3(index)]);
    
end


% 定性鉴定

table2 = table; % 创建定性鉴别表
table2.Name = ["峰1", "峰2", "峰3", "峰4", "峰5"]'; % 组分位置
table2.tR1 = [2.094, 2.181, 2.446, 2.972, 3.669]'; % 保留时间 第1次（记得此处换成自己的数据哦）
table2.tR2 = [2.073, 2.160, 2.426, 2.942, 3.651]'; % 保留时间 第2次（记得此处换成自己的数据哦）
table2.tR3 = [2.077, 2.163, 2.430, 2.954, 3.665]'; % 保留时间 第3次（记得此处换成自己的数据哦）
table2.tRAVG = zeros(5, 1); % 平均保留时间

% 计算平均保留时间

for index = 1: 5
    
    table2.tRAVG(index) = mean([table2.tR1(index), table2.tR2(index), table2.tR3(index)]);
    
end

% 确定峰归属

table2.Ascription = ["甲醇", "乙醇", "正丙醇", "正丁醇", "正戊醇"]'; % 根据计算所得各峰的平均保留时间，参照定性分析表，判断各峰归属（记得此处换成自己判断哦）


% 归一化法定量分析

% 创建归一化法定量分析表

table3 = table;

% 此表中含有两类数据，分别为混合醇标准样品的有关数据（1: 5）和待测混合醇样品（6: 10）的有关数据

table3.type = ["混合醇标准样品", "", "", "", "", "待测混合醇样品", "", "", "", ""]';
table3.Name = ["甲醇", "乙醇", "正丙醇", "正丁醇", "正戊醇", "甲醇", "乙醇", "正丙醇", "正丁醇", "正戊醇"]';
table3.A1 = [14.5126, 21.9684, 27.5530, 29.6395, 6.2388, 18.9203, 14.9855, 26.6520, 35.5936, 2.7539]'; % 峰面积 第1次（记得此处换成自己的数据哦）
table3.A2 = [13.0594, 22.6392, 27.5355, 30.3184, 6.3652, 19.8833, 13.4573, 27.9533, 34.8027, 3.7980]'; % 峰面积 第2次（记得此处换成自己的数据哦）
table3.A3 = [13.3340, 23.1757, 27.3817, 29.6388, 6.1910, 18.2422, 14.3022, 26.9276, 36.3006, 4.1126]'; % 峰面积 第3次（记得此处换成自己的数据哦）
table3.AAVG = zeros(10, 1); % 平均峰面积

% 计算平均峰面积

for index = 1: 10
    
    table3.AAVG(index) = mean([table3.A1(index), table3.A2(index), table3.A3(index)]);
    
end

% 计算质量校正因子

table3.fir = zeros(10, 1);
table3.fir(1) = 1; % 以甲醇为基准

for index = 2: 5
    
    table3.fir(index) = (m(index) * table3.AAVG(1)) / (m(1) * table3.AAVG(index));
    
end


% 归一化法计算待测混合醇样品中各组分含量

table3.Assay = zeros(10, 1);

% 求分母

sum = 0;

for index = 6: 10
    
    sum = sum + table3.AAVG(index) * table3.fir(index - 5);
    
end

% 含量计算

for index = 6: 10
    
    table3.Assay(index) = (table3.AAVG(index) * table3.fir(index - 5)) / sum;
    
end

% 保存为Excel格式

writetable(table1, 'expriment01.xlsx', 'Sheet', 1);
writetable(table2, 'expriment01.xlsx', 'Sheet', 2);
writetable(table3, 'expriment01.xlsx', 'Sheet', 3);
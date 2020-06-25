% 实验8 紫外可见荧光光谱法测定阿司匹林中水杨酸含量

%{
    请先导入自己的实验数据再运行此代码！！！

    需要导入的数据如下：

        Emission: Emission.WaveLength, Emission.Intensity
        Excitation: Excitation.WaveLength, Excitation.Intensity
        Standard: Standard.Conc, Standard.Int
        k: [k1, k2]
        Sample: Sample.Conc, Standard.Int

    样例在'expriment8_data'目录中
%}

% 发射光谱图

figure(1);

plot(Emission.Wavelength, Emission.Intensity);
title('发射光谱图（Ex=312.0nm）');
xlabel('发射波长（nm）');
ylabel('荧光强度');

% 激发光谱图

figure(2);

plot(Excitation.Wavelength, Excitation.Intensity);
title('激发光谱图（Em=445.0nm）');
xlabel('激发波长（nm）');
ylabel('荧光强度');

% 标准曲线绘制及待测样求解

figure(3);

% 标准曲线

Standard = table; % 创建标准曲线表格
Standard.Concs = 0: 0.1: 1.6; % 标准曲线浓度范围
Standard.Ints = polyval(k, Standard.Concs); % 对应荧光强度

% 绘图

plot(Origin.Conc, Origin.Int, 'ro', Standard.Concs, Standard.Ints, 'b-', Sample.Conc, Sample.Int, '*');
xlabel('$$ c / (\mu g \cdot {mL} ^ {-1})$$', 'Interpreter', 'latex');
ylabel('Intensity');
title('标准曲线');

% 待测样水杨酸浓度输出

fprintf('待测样中水杨酸的浓度为%.2fμg/mL\n', Sample.Conc);

% Format Transformer
% ESRI ASCII Grid to XYZ format
% 设置文件名
inputFile = 'C:\Users\yangln\Desktop\Postdoc\CNR_Italy\Maps\tirreno_all_geo_100.asc';
outputFile = 'C:\Users\yangln\Desktop\Postdoc\CNR_Italy\Maps\tirreno_all_geo_100.xyz';

% 1. 读取表头 (前6行)
fid = fopen(inputFile, 'r');
header = textscan(fid, '%s %f', 6);
fclose(fid);

ncols = header{2}(1);
nrows = header{2}(2);
xll = header{2}(3);
yll = header{2}(4);
cellsize = header{2}(5);
nodata = header{2}(6);

% 2. 读取数据矩阵 (跳过表头)
data = readmatrix(inputFile, 'FileType', 'text', 'NumHeaderLines', 6);

% 3. 生成坐标网格 (注意：ASC格式通常从左上角开始排列数据)
x = xll : cellsize : xll + (ncols-1)*cellsize;
y = yll + (nrows-1)*cellsize : -cellsize : yll; % Y是从上往下减
[X, Y] = meshgrid(x, y);

% 4. 过滤无效值并重组为 XYZ
mask = (data ~= nodata);
xyz = [X(mask), Y(mask), data(mask)];

% 5. 保存为 XYZ 格式 (为了减小体积，可以只保存一部分，比如每隔2个点取一个)
% xyz_sub = xyz(1:2:end, :); 
writematrix(xyz, outputFile, 'Delimiter', 'space', 'FileType', 'text');

disp('Transformation Completed!');

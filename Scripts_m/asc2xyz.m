% Format Transformer
% ESRI ASCII Grid to XYZ format
% Set the file name
inputFile = '*.asc';
outputFile = '*.xyz';

% 1. Read header
fid = fopen(inputFile, 'r');
header = textscan(fid, '%s %f', 6);
fclose(fid);

ncols = header{2}(1);
nrows = header{2}(2);
xll = header{2}(3);
yll = header{2}(4);
cellsize = header{2}(5);
nodata = header{2}(6);

% 2. Read data matrix (skip header)
data = readmatrix(inputFile, 'FileType', 'text', 'NumHeaderLines', 6);

% 3. generate meshgrid (Note: ASC Format starts from the left top corner)
x = xll : cellsize : xll + (ncols-1)*cellsize;
y = yll + (nrows-1)*cellsize : -cellsize : yll; % Y Descreases from top to bottom[X, Y] = meshgrid(x, y);

% 4. Filter NO_DATA  in XYZ
mask = (data ~= nodata);
xyz = [X(mask), Y(mask), data(mask)];

% 5. save as .xyz (To reduce the volum, partly data saved, take one point every two points. )

% xyz_sub = xyz(1:2:end, :); 
writematrix(xyz, outputFile, 'Delimiter', 'space', 'FileType', 'text');

disp('Transformation Completed!');

%% Convert [Lon Lat Ele] into UTM33N

% Read Data
data = load('../Map.xyz');  % Nx3: Lon Lat Elev
lon = data(:,1);
lat = data(:,2);
elev = data(:,3);

% Define UTM33N Projection
utm33n = projcrs(32633);  % EPSG:32633

% Lon,Lat to UTM
[x, y] = projfwd(utm33n, lat, lon);  % Note projfwd(lat, lon)

% Keep Elevation
z = elev;

% Save Data
utm_data = [x y z];
save('utm33n_m.xyz', 'utm_data', '-ascii');
disp('Converted file as: utm33n_m.xyz');

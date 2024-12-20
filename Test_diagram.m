figure('units','normalized','position',[.3 .1 .5 .5]);
% Create some data
x = 0:0.1:10;
y = sin(x);

% Plot the data
plot(x, y);
hold on;

% Add a marker at a specific data point (e.g., x = 5, y = sin(5))
plot(5, sin(5), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

% Add a fixed marker using the 'text' function with normalized units
annotation('textarrow', [0.5, 0.5], [0.5, 0.5], 'String', 'Fixed Marker');

% Set the position of the fixed marker using normalized units
annotation('textarrow', [0.5 0.5], [0.5 0.5], 'String', 'Fixed Marker');

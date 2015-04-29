function handle = visualiseConnection(vals, connect)

% STICKVISUALISE For drawing a stick representation of 3-D data.

% MOCAP

vals = reshape(vals, size(vals, 2)/3, 3);

indices = find(connect);
[I, J] = ind2sub(size(connect), indices);
handle(1) = plot3(vals(:, 1), vals(:, 2), vals(:, 3), '.');
set(handle(1), 'markersize', 20);
%set(handle(1), 'visible', 'off')
hold on
grid on
for i = 1:length(indices)
  handle(i+1) = line([vals(I(i), 1) vals(J(i), 1)], ...
              [vals(I(i), 2) vals(J(i), 2)], ...
              [vals(I(i), 3) vals(J(i), 3)]);
  set(handle(i+1), 'linewidth', 2);
end
axis equal
% DEMGRIDEMBED1 Demonstrate the result from embedding from a grid of connections.

% OXFORD

xPoints = 16;
yPoints = 2;
connectionMatrix = fourNeighbourConnection(xPoints, yPoints);
invCov = sparseDiag(sum(connectionMatrix)');
invCov = invCov - connectionMatrix;

covMat = pdinv(invCov);
covMat = centeringMatrix(xPoints*yPoints)*covMat*centeringMatrix(xPoints*yPoints);
covMat = 0.5*(covMat + covMat');

[U, v] = eig(covMat);

v = diag(v);
[v, ind] = sort(v, 1, 'descend');
U = U(:, ind);


vals = gsamp(zeros(1, xPoints*yPoints), covMat+eye(xPoints*yPoints)*1e-6, 3)';

indices = find(connectionMatrix);
[I, J] = ind2sub(size(connectionMatrix), indices);
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
%set(gca, 'zlim', [-2 2])
%set(gca, 'ylim', [-2 2])
%set(gca, 'xlim', [-2 2])
%set(gca, 'cameraposition', [15.3758 -29.5366 9.54836])
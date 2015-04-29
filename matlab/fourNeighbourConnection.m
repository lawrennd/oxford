function connectionMatrix = fourNeighbourConnection(numXpoints, numYpoints);
  
% FOURNEIGHBOURCONNECTION returns a connection matrix for a grid of points.
% FORMAT
% DESC returns a matrix which gives the connections between a grid of
% points for the neighbours to the north, south, east and west.
% ARG numXpoints : number of points in the x-axis direction.
% ARG numYpoints : number of points in the y-axis direction.
% RETURN connectionMatrix : boolean matrix with a true wherever there is
% a connection.
% 
% COPYRIGHT : Neil D. Lawrence, 2008
%
% SEEALSO : demGridEmbed

% OXFORD
  
numData= numXpoints*numYpoints;
x = 1:numXpoints;
y = 1:numYpoints;

interPointSpace = abs(x(2) - x(1));
neighbourDistance = interPointSpace*1.1;

[xMat, yMat] = meshgrid(x, y);

Y = [xMat(:) yMat(:)];
distMat = sqrt(dist2(Y, Y));


connectionMatrix = zeros(numData);

for i=1:numData
  neighbours = find(distMat(i, :)<=neighbourDistance);
  connectionMatrix(i, neighbours) = true;
end 
connectionMatrix(1:numData+1:end) = false;

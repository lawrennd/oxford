function cont = gaussContourPlot(m, C, num)

% GAUSSCONTOURPLOT Plot contours of a Gaussian.
% FORMAT
% DESC creates a plot of Gaussian contours.
% ARG m : mean of the Gaussian distribution.
% ARG C : covariance of the Gaussian distribution.
% ARG sds : number of contours.
% RETURN cont : the handle of the contour lines.
%
% COPYRIGHT : Neil D. Lawrence, 2008
%
% SEEALSO : demGaussianDistribution

  
if nargin < 3
  num = 1;
end
[U, V] = eig(K);
r = sqrt(diag(V));
theta = linspace(0, 2*pi, 200)';
cont = [];
scale = exp(linspace(,  
for i=1:num
  xy = scale*[r(1)*sin(theta) r(2)*cos(theta)]*U;
  cont = [cont line(xy(:, 1), xy(:, 2))];
end


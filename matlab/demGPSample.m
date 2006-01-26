% DEMGPSAMPLE Simple demonstration of sampling from a covariance function.

% OXFORD

randn('seed', 1e5)
rand('seed', 1e5)

x = linspace(-1, 1, 25)';
kern = kernCreate(x, 'rbf');
kern.inverseWidth = 10;
K = kernCompute(kern, x);
imagesc(K);
colormap gray
colorbar
t = [];
t = [t xlabel('n')];
t = [t ylabel('m')];
set(gca, 'fontname', 'times')
set(gca, 'fontsize', 18)
% need to take the real part of the sample as the kernel is numerically less than full rank 
f = real(gsamp(zeros(1, size(x, 1)), K, 1))';

figure, 
a = plot(f, 'rx');
t = [t xlabel('n')];
t = [t ylabel('f_n')];
set(t, 'fontname', 'times')
set(t, 'fontsize', 24)
set(t, 'fontangle', 'italic')
set(gca, 'fontname', 'times')
set(gca, 'fontsize', 18)
set(a,'markersize', 10)
set(a, 'linewidth', 2)

save demGPSample K x f
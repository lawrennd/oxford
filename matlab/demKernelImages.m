% DEMKERNELIMAGES Create plots of some covariance functions
% FORMAT
% DESC creates some gray scale plots of some different kernel matrices.

% COPYRIGHT : Neil D. Lawrence, 2006

% OXFORD

randn('seed', 1e5)
rand('seed', 1e5)

x = linspace(-1, 1, 25)';

clear K
kern = kernCreate(x, 'rbf');
kern.inverseWidth = 10;
K{1} = kernCompute(kern, x);
kern = kernCreate(x, 'mlp');
kern.weightVariance = 1;
kern.biasVariance = 1;
K{2} = kernCompute(kern, x);
kern = kernCreate(x, 'lin');
K{3} = kernCompute(kern, x); 
kern = kernCreate(x, 'white');
kern.variance = 1;
K{4} = kernCompute(kern, x); 


for figNo = 1:length(K)
  imagesc(K{figNo}, [-1.1 1.1]);
  %colormap gray
  colorbar
  t = [];
  t = [t xlabel('n')];
  t = [t ylabel('m')];
  set(gca, 'fontname', 'times')
  set(gca, 'fontsize', 18)
  print('-depsc', ['../tex/diagrams/demKernelImages' num2str(figNo) ...
                   '.eps'])
end

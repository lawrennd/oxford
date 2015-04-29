% DEMOPTIMISEKERN Shows that there is an optimum for the kernel length scale.
% DESC shows that by varying the length scale an artificial data
% set has different likelihoods, yet there is an optimum for which
% the likelihood is maximised.

% COPYRIGHT : Neil D. Lawrence, 2006

% OXFORD

randn('seed', 1e5);
rand('seed', 1e5);

markerSize = 10;
markerWidth = 6;
markerType = 'rx';
lineWidth = 4;


x = linspace(-1, 1, 6)';
trueKern = kernCreate(x, {'rbf', 'white'});
kern.comp{2}.variance = 0.001;
K = kernCompute(trueKern, x);
y = gsamp(zeros(1, 6), K, 1)';

xtest = linspace(-1.5, 1.5, 200)';
kern = trueKern;

lengthScale = [0.05 0.1 0.25 0.5 1 2 4 8 16];
counter = 0;

figure(1)
p = plot(x, y, markerType);
set(p, 'markersize', markerSize, 'lineWidth', markerWidth);
set(gca, 'fontname', 'times')
set(gca, 'fontsize', 18)
set(gca, 'ylim', [-2 1])
set(gca, 'xlim', [-1.5 1.5])

zeroAxes(gca);
print('-depsc', ['../tex/diagrams/demOptimiseKern' num2str(counter) ...
                 '.eps'])
clf

void = semilogx(NaN, NaN, 'bo-');
set(gca, 'fontname', 'times')
set(gca, 'fontsize', 18)
set(gca, 'ylim', [-12 -4])
set(gca, 'xlim', [0.025 32]) 
grid on
ylabel('log-likelihood')
xlabel('length scale')
print('-depsc', ['../tex/diagrams/demOptimiseKern' num2str(counter) ...
                   '0.eps'])

clf

for i = 1:length(lengthScale)
  kern.comp{1}.inverseWidth = 1/(lengthScale(i)*lengthScale(i));
  K = kernCompute(kern, x);
  [invK, U] = pdinv(K);
  logDetK = logdet(K, U);
  ll(i) = -0.5*(logDetK + y'*invK*y + size(y, 1)*log(2*pi));
  
  Kx = kernCompute(kern, x, xtest);
  ypredMean = Kx'*invK*y;
  ypredVar = kernDiagCompute(kern, xtest) - sum((Kx'*invK).*Kx', 2);

  counter = counter + 1;
  figure(counter)
  t = plot(xtest, ypredMean, 'b-');
  hold on 
  t = [t; plot(xtest, ypredMean + sqrt(ypredVar), 'b--')];
  t = [t; plot(xtest, ypredMean - sqrt(ypredVar), 'b--')];
  
  p = plot(x, y, markerType);
  set(p, 'markersize', markerSize, 'lineWidth', markerWidth);
  set(t, 'linewidth', lineWidth);
  set(gca, 'fontname', 'times')
  set(gca, 'fontsize', 18)
  set(gca, 'ylim', [-2 1])
  
  zeroAxes(gca);
  print('-depsc', ['../tex/diagrams/demOptimiseKern' num2str(counter) ...
                   '.eps'])

  counter = counter + 1;
  figure(counter)
  t = semilogx(lengthScale(1:i), ll(1:i), 'bo-');
  set(t, 'markersize', markerSize, 'lineWidth', markerWidth);
  set(gca, 'fontname', 'times')
  set(gca, 'fontsize', 18)
  set(gca, 'ylim', [-12 -4])
  set(gca, 'xlim', [0.025 32]) 
  grid on
  ylabel('log-likelihood')
  xlabel('length scale')
  print('-depsc', ['../tex/diagrams/demOptimiseKern' num2str(counter) ...
                   '.eps'])
end
  



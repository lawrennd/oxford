% DEMREGRESSION Demonstrate Gaussian processes for regression.
% FORMAT
% DESC runs a simple one-D Gaussian process displaying errorbars.
%
% SEEALSO : gpCreate, demInterpolation
% 
% COPYRIGHT : Neil D. Lawrence, 2006

% OXFORD

randn('seed', 1e7)
rand('seed', 1e7)

noiseLevel = 0.2;
noiseVar = noiseLevel*noiseLevel;
% Create data set
x = linspace(-1, 1, 9)';
trueKern = kernCreate(x, 'rbf');
K = kernCompute(trueKern, x) + eye(size(x, 1))*noiseVar;
% Sample some true function values.
yTrue = gsamp(zeros(size(x))', K, 1)';

markerSize = 10;
markerWidth = 6;
markerType = 'rx';
lineWidth = 4;
% Create a test set
indTrain{1} = [1 9]';
indTrain{2} = [1 5 9]';
indTrain{3} = [1 3 5 7 9]';
indTrain{4} = [1 2 3 4 5 6 7 8 9]';
figNo = 1;
for i = 0:length(indTrain)
  if i > 0
    yTrain = yTrue(indTrain{i});
    xTrain = x(indTrain{i});
    kern = kernCreate(x, 'rbf');
    % Change inverse variance (1/(lengthScale^2)))
    kern.inverseWidth = 5;
    
    xTest = linspace(-2, 2, 200)';
    
    Kx = kernCompute(kern, xTest, xTrain);
    Ktrain = kernCompute(kern, xTrain, xTrain);
    
    yPred = Kx*pdinv(Ktrain + eye(size(Ktrain))*noiseVar)*yTrain;
    yVar = kernDiagCompute(kern, xTest) - sum(Kx*pdinv(Ktrain+ eye(size(Ktrain))*noiseVar).*Kx, 2);
    ySd = sqrt(yVar);
    figure(figNo)
    clf
    h = plot(xTest, yPred, 'b-');
    hold on;
    h = [h plot(xTest, yPred + 2*ySd, 'b--')];
    h = [h plot(xTest, yPred - 2*ySd, 'b--')];
    set(h, 'linewidth', lineWidth)
    p = plot(xTrain, yTrain, markerType);
    set(p, 'markersize', markerSize, 'lineWidth', markerWidth);
    set(gca, 'xtick', [-2 -1 0 1 2]);
    set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
    set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-2 2], 'ylim', [-3 3])
    zeroAxes(gca);
    print('-depsc', ['../tex/diagrams/demRegression' num2str(figNo) ...
                     '.eps'])
    figNo = figNo + 1;
  else
    p = [];
  end
  if i < length(indTrain)
    figure(figNo)
    if i>0
      h = plot(xTest, yPred, 'b-');
      hold on
      h = [h plot(xTest, yPred + 2*ySd, 'b--')];
      h = [h plot(xTest, yPred - 2*ySd, 'b--')];
      set(h, 'linewidth', lineWidth)
    end
    p = [p plot(x(indTrain{i+1}), yTrue(indTrain{i+1}), markerType)];
    set(p, 'markersize', markerSize, 'linewidth', markerWidth);
    set(gca, 'xtick', [-2 -1 0 1 2]);
    set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
    set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-2 2], 'ylim', [-3 3])
    zeroAxes(gca);
    print('-depsc', ['../tex/diagrams/demRegression' num2str(figNo) ...
                     '.eps'])
    figNo = figNo + 1;
  end
end
function demLeastSquaresRegress(xlim)
  
% DEMLEASTSQUARESREGRESS Demonstrate Least Squares Regression with RBF Bases.
% FORMAT
% DESC runs a simple one-D Least Squares Regression.
% ARG xlim : the x limit of the axes.
%
% SEEALSO : gpCreate, demInterpolation
%
% COPYRIGHT : Neil D. Lawrence, 2008

% OXFORD

randn('seed', 1e6)
rand('seed', 1e6)

colordef white

% Create data set
x = linspace(-1, 1, 9)';
trueKern = kernCreate(x, 'rbf');
K = kernCompute(trueKern, x);
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

xTest = linspace(-xlim, xlim, 200)';
numBases = 9;
basesCentres = linspace(-1.5, 1.5, numBases);
priorCov = 4*eye(length(basesCentres));
priorNoise = 0.001;
basesWidth = 0.3;
phiTest = bayesComputeBases(xTest, basesCentres, basesWidth);

for i = 0:length(indTrain)
   if i > 0
     yTrain = yTrue(indTrain{i});
     xTrain = x(indTrain{i});

     phiTrain = bayesComputeBases(xTrain, basesCentres, basesWidth);
     What = pdinv(phiTrain'*phiTrain)*phiTrain'*yTrain;

     yPred = phiTest*What;
     figure(figNo)
     clf
     h = plot(xTest, yPred, 'b-');
     hold on;
     set(h, 'linewidth', lineWidth)
     p = plot(xTrain, yTrain, markerType);
     set(p, 'markersize', markerSize, 'lineWidth', markerWidth);
     set(gca, 'xtick', [-2 -1 0 1 2]);
     set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
     set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
     zeroAxes(gca);
     print('-depsc', ['../tex/diagrams/demLeastSquaresRegress' num2str(figNo) ...
                      '.eps'])
     figNo = figNo + 1;
   else
     p = [];
   end
   if i < length(indTrain)
     figure(figNo)
     if i>0
       h = plot(xTest, yPred, 'b-');
       set(h, 'linewidth', lineWidth)
     end
     p = [p plot(x(indTrain{i+1}), yTrue(indTrain{i+1}), markerType)];
     set(p, 'markersize', markerSize, 'linewidth', markerWidth);
     set(gca, 'xtick', [-2 -1 0 1 2]);
     set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
     set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
     zeroAxes(gca);
     print('-depsc', ['../tex/diagrams/demLeastSquaresRegress' num2str(figNo) ...
                      '.eps'])
     figNo = figNo + 1;
   end
 end


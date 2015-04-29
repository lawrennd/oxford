function demBayesRegress(xlim)
  
% DEMBAYESREGRESS Demonstrate Bayesian Regression with RBF Bases.
% FORMAT
% DESC runs a simple one-D Bayesian Regression.
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

% Plot bases functions
figure(figNo)
clf
h = [];
h = [h plot(xTest, phiTest, '-')]
set(h, 'linewidth', lineWidth)
set(gca, 'xtick', [-2 -1 0 1 2]);
set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
zeroAxes(gca);
print('-depsc', ['../tex/diagrams/demBayesRegressXlim' num2str(xlim) 'Bases.eps'])
figNo = figNo + 1;
     
numSamps = 10
W = randn(numSamps, length(basesCentres));

% Plot random samples 
h=[];
figure(figNo)
clf
hold on
for i = 1:size(W, 1)
  h = [h plot(xTest, phiTest*W(i, :)', '-')];
end
set(h, 'linewidth', lineWidth)
set(gca, 'xtick', [-2 -1 0 1 2]);
set(gca, 'ytick', [-3 -2 -1 0 1 2 3]);
set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
zeroAxes(gca);
print('-depsc', ['../tex/diagrams/demBayesRegressXlim' num2str(xlim) 'Prior.eps'])
figNo = figNo + 1;

for i = 0:length(indTrain)
   if i > 0
     yTrain = yTrue(indTrain{i});
     xTrain = x(indTrain{i});

     phiTrain = bayesComputeBases(xTrain, basesCentres, basesWidth);
     Wcov = pdinv(1/priorNoise*phiTrain'*phiTrain+pdinv(priorCov));
     What = Wcov*phiTrain'*yTrain*1/priorNoise;

     yPred = phiTest*What;
     yVar = sum((phiTest*Wcov).*phiTest, 2);
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
     set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
     zeroAxes(gca);
     print('-depsc', ['../tex/diagrams/demBayesRegressXlim' num2str(xlim) '_' num2str(figNo) ...
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
     set(gca, 'fontname', 'times', 'fontsize', 18, 'xlim', [-xlim xlim], 'ylim', [-3 3])
     zeroAxes(gca);
     print('-depsc', ['../tex/diagrams/demBayesRegressXlim' num2str(xlim) '_' num2str(figNo) ...
                      '.eps'])
     figNo = figNo + 1;
   end
 end


function noise = epPointUpdate(noiseModel, y, priorMean, priorVar, noiseBias, noiseVar, printIt, ...
                       numPoints, xMin, xMax);

% EPPOINTUPDATE Demonstrate in one-D an EP point inclusion.
% FORMAT
% DESC demonstrates one-D point inclusion for expectation
% propagation.
% ARG noiseModel : the type of noise model (e.g. 'probit', 'ncnm',
% 'ordered')
% ARG y : the target y value for the noise model.
% ARG priorMean : the mean of the prior Gaussian.
% ARG priorVar : the variance of the prior Gaussian.
% ARG noiseBias : the bias of the noise distribution.
% ARG noiseVar : the variance of the noise distribution (typically
% dictactes slope of the probit).
% ARG numPoints : number of points to use in the plots.
% ARG xMin : x starting point for the plot.
% ARG xMax : x finishing point for the plot.
% RETURN noise : the noise model used.
%
% COPYRIGHT : Neil D. Lawrence, 2007
%
% SEEALSO : noiseCreate

% OXFORD


if nargin < 10
  xMax = 3;
  if nargin < 9
    xMin = -3;
    if nargin < 8
      numPoints = 1000;
      if nargin < 7
        printIt = false;
        if nargin < 6
          noiseVar = 1e-2;
          if nargin < 5
            noiseBias = -.4;
            if nargin < 4
              priorVar = .1;
              if nargin < 3;
                priorMean = 0;
                if nargin < 2
                  y = 1;
                  if nargin < 1
                    noiseModel = 'probit';
                  end
                end
              end            
            end    
          end
        end
      end
    end
  end
end

if strcmp(noiseModel, 'ordered')
  noise = noiseCreate(noiseModel, 3);
else
  noise = noiseCreate(noiseModel, y);
end
noise.bias = noiseBias;
noise.sigma2 = noiseVar;
noise.variance = noiseVar;
noise.gamman = 0.5;
noise.gammap = 0.5;

f = linspace(xMin, xMax, numPoints)';
lnpriorCurve = -0.5*log(2*pi*priorVar) - 0.5*(f-priorMean).*(f-priorMean)/priorVar;
lnlikelihoodCurve = zeros(size(lnpriorCurve));
for i = 1:numPoints
  lnlikelihoodCurve(i) = noiseLogLikelihood(noise, f(i), eps, y);
end
lnMarginalLikelihood = noiseLogLikelihood(noise, priorMean, priorVar, y);

priorCurve = exp(lnpriorCurve);
likelihoodCurve = exp(lnlikelihoodCurve);
marginalCurve = exp(lnMarginalLikelihood);

lnposteriorCurve =  lnlikelihoodCurve + lnpriorCurve ...
    - lnMarginalLikelihood;
posteriorCurve = exp(lnposteriorCurve);

[g, dlnZ_dvs] = feval([noise.type 'NoiseGradVals'], ...
		      noise, ...
		      priorMean, priorVar, ...
		      y);

nu = g.*g - 2*dlnZ_dvs;


approxVar = priorVar - priorVar*priorVar*nu;
approxMean = priorMean + priorVar*g;

lnapproxCurve =  -0.5*log(2*pi*approxVar) - 0.5*(f-approxMean).*(f- ...
                                                  approxMean)/approxVar;

lineWidth = 3;
approxCurve = exp(lnapproxCurve);
noiseDisplay(noise);
xLim = [xMin xMax];
yLim = [0 max([approxCurve; likelihoodCurve; posteriorCurve; priorCurve])*1.1];

figure
clf
% Create the plot for the data
ax = axes('position', [0.05 0.05 0.9 0.9]);
set(ax, 'xLim', xLim);
set(ax, 'yLim', yLim);
set(ax, 'fontname', 'arial');
set(ax, 'fontsize', 20);
line(f, priorCurve, 'color', [0 0 1], 'linewidth', lineWidth);
drawnow
printPlot(1);

hold on
line(f, likelihoodCurve, 'color', [1 0 0], 'linewidth', lineWidth);
drawnow
printPlot(2);
line(f, posteriorCurve, 'color', [1 0 1], 'linewidth', lineWidth);
drawnow
printPlot(3);
plot(f, approxCurve, 'color', [0 1 0], 'linewidth', lineWidth);
drawnow 
printPlot(4)


  function printPlot(num)
    if printIt == true
      capName = noiseModel;
      capName(1) = upper(capName(1));
      fileName = ['dem' capName num2str(priorMean) '_' num2str(priorVar) '_' ...
                  num2str(noiseBias) '_' num2str(noiseVar) '_' num2str(num)];
      fileName(find(fileName==46)) = 112;
      %disp(fileName)
      print('-depsc', ['../tex/diagrams/' fileName])
      print('-deps', ['../tex/diagrams/' fileName 'NoColour'])
      
%       % make smaller for PNG plot.
%       pos = get(gcf, 'paperposition')
%       origpos = pos;
%       pos(3) = pos(3)/2;
%       pos(4) = pos(4)/2;
%       set(gcf, 'paperposition', pos);
%       fontsize = get(gca, 'fontsize');
%       set(gca, 'fontsize', fontsize/2);
%       lineWidth = get(gca, 'lineWidth');
%       set(gca, 'lineWidth', lineWidth*2);
%       print('-dpng', ['../html/' fileName])
%       set(gcf, 'paperposition', origpos);
    end
  end
end
function y = bayesComputeBases(x, centres, width)

% BAYESCOMPUTEBASES Computes the bases functions for the simple Bayesian regression.
% FORMAT
% DESC computes the bases functions (RBF) for a simple Bayesian
% regression.
% ARG x : input data.
% ARG centres : centres of the bases functions.
% ARG widths : widths of the bases funcitons.
% RETURN : values of the bases functions for the given input data.
%
% COPYIGHT : Neil D. Lawrence, 2008
%
% SEEALSO : demBayesRegress

% OXFORD 
  
y = exp(-dist2(x, centres')/(2*width*width));
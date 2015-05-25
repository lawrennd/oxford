% DEMGPLVMTALK Show demos for GP-LVM talk in order.

% OXFORD

colordef white

disp('Ready ... stickman results.')
disp('demStickResults')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demStickResults
 otherwise
end
disp('load demWalkRun1.mat')
disp(['hgplvmHierarchicalVisualise(model, visualiseNodes, depVisData'])
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
 case {'r', 'R'}
  close all
  clear all
  % Load model
  load demWalkRun1
  % Display results
  hgplvmHierarchicalVisualise(model, visualiseNodes, depVisData);

 otherwise
end
disp('press any key to tidy up.')
pause
clear all
close all

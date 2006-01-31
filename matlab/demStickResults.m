% DEMSTICKRESULTS1 Show the results of stick man optimisations interactively.

% OXFORD

colordef white
disp('Ready ... pure GP-LVM on stick man.')
% load connectivity matrix
disp('[void, connect] = mocapLoadTextData(''run1'');')
disp('fgplvmResultsDynamic(''stick'', 1, ''stick'', connect)')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   % load connectivity matrix
   [void, connect] = mocapLoadTextData('run1');
   % Load the results and display dynamically.
   fgplvmResultsDynamic('stick', 1, 'stick', connect)
 otherwise
end
disp('Ready ... back constrained GP-LVM on stick man.')
% load connectivity matrix
disp('[void, connect] = mocapLoadTextData(''run1'');')
disp('fgplvmResultsDynamic(''stick'', 3, ''stick'', connect)')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   % load connectivity matrix
   [void, connect] = mocapLoadTextData('run1');
   % Load the results and display dynamically.
   fgplvmResultsDynamic('stick', 3, 'stick', connect)
 otherwise
end
disp('Ready ... dynamics GP-LVM on stick man.')
% load connectivity matrix
disp('[void, connect] = mocapLoadTextData(''run1'');')
disp('fgplvmResultsDynamic(''stick'', 2, ''stick'', connect)')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   % load connectivity matrix
   [void, connect] = mocapLoadTextData('run1');
   % Load the results and display dynamically.
   fgplvmResultsDynamic('stick', 2, 'stick', connect)
 otherwise
end
disp('press any key to tidy up.')
pause

clear all
close all
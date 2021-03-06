% DEMICML07 Show results for HGPLVM ICML talk.

% OXFORD

colordef white
disp('Ready ... play stick man data.')
disp('[Y, connect] = mocapLoadTextData(''run1'');')
disp('handle = stickVisualise(Y(1, :), connect);')
disp('for j = 1:3')
disp('  for i = 2:size(Y, 1)')
disp('    stickModify(handle, Y(i, :), connect);')
disp('    drawnow')
disp('  end')
disp('end')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   rep = 1;
   [Y, connect] = mocapLoadTextData('run1');
%   Y = Y(1:4:end, :);
   handle = stickVisualise(Y(1, :), connect);
   while(rep)
     for j = 1:3
       for i = 2:size(Y, 1)
         stickModify(handle, Y(i, :), connect);
         pause(0.01)
       end
     end
     r2 = input('Type ''R'' to repeat or ''C'' to continue: ', 's');
     switch r2
      case {'r', 'R'}
       rep = 1;
      otherwise
       rep = 0;
     end
   end
 otherwise
end
disp('Ready ... pure GP-LVM on stick man.')
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
disp('Ready ... regressive dynamics GP-LVM on stick man.')
% load connectivity matrix
disp('[void, connect] = mocapLoadTextData(''run1'');')
disp('fgplvmResultsDynamic(''stick'', 5, ''stick'', connect)')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   % load connectivity matrix
   [void, connect] = mocapLoadTextData('run1');
   % Load the results and display dynamically.
   fgplvmResultsDynamic('stick', 5, 'stick', connect)
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

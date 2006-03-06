% DEMGPLVMTALK Show demos for GP-LVM talk in order.

colordef white

disp('Ready ... rotation of digit.')
disp('demManifold')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demManifold
 otherwise
end
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

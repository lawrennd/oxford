% DEMMANIFOLD Show rotation of the digit 6/9.

% OXFORD

colordef white
disp('Ready ... rotation of digit 6.')
disp('demDigitsManifold([2 3], ''all'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demDigitsManifold([2 3], 'all')
 otherwise
end
disp('Ready ... rotation of digit 6/9.')
disp('demDigitsManifold([2 3], ''sixnine'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demDigitsManifold([2 3], 'sixnine')
 otherwise
end

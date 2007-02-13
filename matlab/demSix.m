function demSix

% DEMSIX Produce figures of the handwritten six and rotated versions.
% FORMAT 
% DESC prints the six, a random sample from the same space and two
% rotated versions of the six.
% 
% COPYRIGHT : Neil D. Lawrence, 2006

% OXFORD


sixImage = double(imread('br1561_6.3.pgm'));
rows = size(sixImage, 1);
col = size(sixImage, 2);
%sixImage = uint8(255-sixImage);

colordef white

figure(1)
imagesc(sixImage);
prepPlot(gca);
print('-depsc', '../tex/diagrams/demSix0');
for i = 1:3
  randImage = rand(rows, col)>length(find(sixImage))/(rows*col);
  clf
  imagesc(-randImage);
  prepPlot(gca);
  print('-depsc', ['../tex/diagrams/demSixSpace' num2str(i)]);
end


load demManifold
ind = [31 11 350 330 310 290];
for i = 1:length(ind)
  clf
  imagesc(-reshape(Y(ind(i), :), 64, 64))
  prepPlot(gca);
  print('-depsc', ['../tex/diagrams/demSix' num2str(i)]);
end

function prepPlot(handle)

% PREPPLOT Prepare the plot for printing.

axis image
xlim = get(handle, 'xlim');
ylim = get(handle, 'ylim');

set(handle, 'xtick', xlim(1):2:xlim(2))
set(handle, 'ytick', ylim(1):2:ylim(2))
set(handle, 'xticklabel', [])
set(handle, 'yticklabel', [])
grid on
colormap gray
%set(handle, 'fontname', 'helvetica')
%set(handle, 'fontsize', 20);
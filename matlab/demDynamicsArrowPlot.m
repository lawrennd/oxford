% DEMDYNAMICSARROWPLOT Prepare an plot for arrow between two latent space plots.

% OXFORD

load demStick3

paperPos = get(gcf, 'paperposition');
paperPos(4) = paperPos(4)/2;
set(gcf, 'paperPosition', paperPos);
%paperPos = get(gcf, 'position');
%paperPos(4) = paperPos(4)/2;
%set(gcf, 'position', paperPos);

ax1 = axes('position', [0.05 0.15 0.425 0.85])
lvmScatterPlot(model, [], ax1);
hold on
hand = [plot(model.X(:, 1), model.X(:, 2), 'rx-')];
line(model.X(20, 1), model.X(20, 2), 'markersize', 14, 'linewidth', 4, 'color', [0 0 1], 'marker', 'o')
h = [xlabel('$t$')];
set(h, 'Interpreter', 'latex')
set(hand, 'linewidth', 2)
set(hand, 'markersize', 10)
set(ax1, 'xticklabel', [])
set(ax1, 'yticklabel', [])

print -depsc ../tex/diagrams/demDynamicsArrowPlot1.eps

ax2 = axes('position', [0.525 0.15 0.425 0.85])
lvmScatterPlot(model, [], ax2);
hold on
hand = plot(model.X(:, 1), model.X(:, 2), 'rx-');
line(model.X(21, 1), model.X(21, 2), 'markersize', 14, 'linewidth', 4, 'color', [0 0 1], 'marker', 'o')
h = xlabel('$t+1$')
set(h, 'Interpreter', 'latex')
set(hand, 'linewidth', 2)
set(hand, 'markersize', 10)
set(ax2, 'xticklabel', [])
set(ax2, 'yticklabel', [])

print -depsc ../tex/diagrams/demDynamicsArrowPlot2.eps

annotation1 = annotation(...
  gcf,'arrow',...
  [0.4536 0.9071],[0.6291 0.5507],...
  'LineWidth',4,...
  'Color',[0 0 1],...
  'HeadWidth',20,...
  'HeadLength',20);
print -depsc ../tex/diagrams/demDynamicsArrowPlot3.eps

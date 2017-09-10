x=[5	8	10	15	20];
y1 = [56.9	56.65	56.7351	56.40075	54.48175];
y2 = [56.92143	57.06182	57.02143	56.93684	54.34651];
y3 = [54.67719	54.67674	54.5	54.11	53.60917];
y4 = [54.63402	54.55391	54.64495	54.58704	52.05031];
y5 = [54.65372	54.58689	53.96667	53.89084	51.89573];

plot(x, y1, 'r-', x, y2, 'g-', x, y3, 'b-', x, y4, 'c-', x, y5, 'm-');
xlabel('Component quantity');
ylabel('FPS');
grid on;
l = legend('Experiment No.1', 'Experiment No.2', 'Experiment No.3', 'Experiment No.4', 'Experiment No.5', 'Location', 'southwest');
axis([5, 20, 0, 60]);
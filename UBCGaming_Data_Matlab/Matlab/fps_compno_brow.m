x=[5	8	10	15	20];
y1 = [58.26916	55.92037	53.46581	45.69346	31.04679];
y2 = [59.30612	58.9224	57.36839	52.84806	42.58163];


plot(x, y1, 'r^-', x, y2, 'bS-');
xlabel('Component quantity');
ylabel('FPS');
grid on;
l = legend('Firefox', 'Chrome', 'Location', 'southwest');
axis([5, 20, 0, 60]);
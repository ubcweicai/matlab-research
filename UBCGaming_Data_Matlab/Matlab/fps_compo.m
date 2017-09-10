x=[5	8	10	15	20	25	30];
y1=[54.67719298	54.67674419	54.5	54.11	53.60916667	48.12713178	45.63150685];
y2=[58.26915888	55.92037037	53.46581197	45.69345794	31.04678899	13.37096774	4.766972477];

plot(x, y1, 'b^-', x, y2, 'ro-');
xlabel('Component numbers');
ylabel('fps');
grid on;
l = legend('Components run on server', 'Components run on client', 'Location', 'southwest');


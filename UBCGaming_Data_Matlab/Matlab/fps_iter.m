x=[1000, 2000, 4000, 6000, 8000, 10000];
y1=[56.53370787	56.63876404	49.97191011	47.36949153	44.4283237	40.14193548];
y2=[53.35260116	53.38430233	53.4875817	53.26640625	53.08375	52.71592357
];

plot(x, y1, 'b^-', x, y2, 'ro-');
xlabel('Total iterations');
ylabel('FPS');
grid on;
l = legend('All cloud solution', 'All terminal solution', 'Location', 'southwest');
set(l,'FontSize',18);
set(gca,'FontSize',16);
axis([1000, 10000, 0, 60]);

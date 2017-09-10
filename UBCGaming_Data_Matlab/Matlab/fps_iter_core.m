x = [1 2 3 4 5 6 7 8];
y = [22.03 34.18 45.40 50.39 53.98 55.11 55.30 55.28];

plot(x, y, 'b^-');
xlabel('CPU (Cores)');
ylabel('FPS');
axis([1, 8, 0, 60]);
set(gca,'XTick',x);
grid on;
legend('FPS of the application', 'Location', 'best');

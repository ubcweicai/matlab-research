x = linspace(-5,5); % define x
y1 = sin(x); % define y1
y2 = sin(2*x); % define y2
y3 = sin(4*x); % define y3
y4 = sin(6*x); % define y4

figure % create new figure

subplot(3,1,1) % first subplot
plot(x,y1)

subplot(3,1,2) % second subplot
plot(x,y2)

subplot(3,1,3) % third subplot
plot(x,y3)


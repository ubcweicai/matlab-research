
t = 0:0.1:10;
x = sin(t);
y = 0.8*sin(t);
fill([t fliplr(t)],[x fliplr(y)],'b');
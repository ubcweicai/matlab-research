clc;
clear;

dropbox='../../../';

framesize=csvread([dropbox,'/Experiment/Intra/correlation_new.csv']);
t1=framesize(2:1:9430,2);
t2=framesize(2:1:9430,3);
t3=framesize(2:1:9430,4);

t1=t1./1024;
t2=t2./1024;
t3=t3./1024;

tt1 = cumsum(t1)';
tt2 = cumsum(t2)';
tt3 = cumsum(t3)';
tt4 = zeros(1,9429);

i=2:1:9430;


hold on;
grid on;

% plot(i,t1,'b');
% plot(i,t2,'r');
% plot(i,t3,'g');

% plot(i,tt1,'b');
% plot(i,tt2,'r');
% plot(i,tt3,'g');

% plot(i,tt1,'b', i, tt2, 'r', i, tt3, 'g');
fill([i fliplr(i)],[tt1 fliplr(tt3)],'b');
fill([i fliplr(i)],[tt2 fliplr(tt1)],'r');
fill([i fliplr(i)],[tt3 fliplr(tt4)],'g');

legend('Player 1','Player 2','Optimized Player 2');
% xlabel('Time Elapsed (second)'),ylabel('Frame Size (kilobyte)');
xlabel('Frame Number'),ylabel('Accumulated Frame Size (kilobyte)');

set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
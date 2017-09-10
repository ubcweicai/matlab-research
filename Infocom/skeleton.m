clc;
clear;

dropbox='../../../';

filename=['data.csv'];
result=csvread(filename);

cognitive1=result(1:76,2);
schemes1=result(1:76,3);
cognitive2=result(97:172,2);
schemes2=result(97:172,3);
cognitive3=result(190:265,2);
schemes3=result(190:265,3);

i=1:1:76;

hold on;
grid on;


plot(i,cognitive1,'k^-');
plot(i,schemes1,'kv-');
plot(i,cognitive2,'ko-');
plot(i,schemes2,'k+-');
plot(i,cognitive3,'kx-');
plot(i,schemes3,'k*-');

legend('Auto 1','Iteration 1','Auto 2','Iteration 2','Auto 3','Iteration 3');
xlabel('Time Slots (5 seconds per slot)'),ylabel('Average Frames Per Seccond (FPS)');


set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])

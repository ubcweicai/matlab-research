clc;
clear;

dropbox='../../../';

t1=csvread([dropbox,'/testbed/tank_mobile/7.log']);
t2=csvread([dropbox,'/testbed/tank_mobile/8.log']);
t3=csvread([dropbox,'/testbed/tank_mobile/9.log'])

i=1:1:194;

figure;
subplot(3,1,1) % first subplot
plot(i(1:53),t1(1:53),'k^-');
xlabel('Time Elapsed (second) : Player 1'),ylabel('FPS');

subplot(3,1,2) % first subplot
plot(i(1:53),t2(1:53),'ko-');
xlabel('Time Elapsed (second) : Player 2'),ylabel('FPS');

subplot(3,1,3) % first subplot
plot(i(1:53),t3(1:53),'ko-');
xlabel('Time Elapsed (second) : Player 3'),ylabel('FPS');

set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])

clc;
clear;

dropbox='../../../';

t1=csvread([dropbox,'/testbed/tank_pc/1.log']);
t2=csvread([dropbox,'/testbed/tank_pc/2.log']);
t3=csvread([dropbox,'/testbed/tank_pc/3.log']);
t4=csvread([dropbox,'/testbed/tank_pc/4.log']);
t5=csvread([dropbox,'/testbed/tank_pc/5.log']);


i=1:1:87;
% 
% hold on;
% grid on;

figure;
subplot(3,1,1) % first subplot
plot(i(1:61),t1(1:61),'k^-');
xlabel('Time Elapsed (second) : Player 1'),ylabel('FPS');

% plot(i(1:59),t2(1:59),'kv-');
subplot(3,1,2) % first subplot
plot(i(1:86),t3(1:86),'ko-');
xlabel('Time Elapsed (second) : Player 2'),ylabel('FPS');

% plot(i(1:79),t4(1:79),'k+-');
subplot(3,1,3) % first subplot
plot(i(1:47),t5(1:47),'kx-');

xlabel('Time Elapsed (second) : Player 3'),ylabel('FPS');


set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])

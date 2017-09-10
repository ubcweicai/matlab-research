clc;
clear;

dropbox='../../../';
filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\delay_result.csv'];
result=csvread(filename);
result_backup=result;

idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

variance = [];
terminal = [];
network = [];
cloud = [];
delay = [];

for i=0:2:10
    idy=find(result(:,6)>i); 
    idx=find(result(idy,6)<(i+2));
    variance=[variance;i];
    terminal=[terminal;mean(result(idx,1))];
    network=[network;mean(result(idx,2))];
    cloud=[cloud;mean(result(idx,3))];
    delay=[delay;mean(result(idx,4))];
end

display(variance);
display(terminal);
display(network);
display(cloud);
display(delay);

% comparison = [terminal cloud network delay];
% b=bar(comparison);
% set(b(1),'FaceColor','y');
% set(b(2),'FaceColor','g');
% set(b(3),'FaceColor','b');
% set(b(4),'FaceColor','r');
b=bar(terminal,'y');
hold on;
b=bar(cloud,'g');
b=bar(network,'b');
b=bar(delay,'r');

legend('Pure-Cloud','Cloud Minimization','Network Minimization','Delay Minimization');
xlabel('Component Degree Variance'),ylabel('Response Delay');
xtick={'[0,2)','[2,4)','[4,6)','[6,8)','[8,10)','[10,12]','[6,7)','[7,8)','[8,9)','[9,10)','[10,11]'};
set(gca,'xticklabel',xtick);


% plot(variance,terminal,'ks-');
% plot(variance,network,'k+-');
% plot(variance,cloud,'ko-');
% plot(variance,delay,'kv-');
% 
% legend('Pure-Cloud','Network Minimization','Cloud  Minimization','Delay Minimization');
% xlabel('Component Degree Variance'),ylabel('Response Delay');
% set(gca,'XTickLabel',variance)




set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
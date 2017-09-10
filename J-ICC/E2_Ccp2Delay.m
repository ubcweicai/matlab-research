clc;
clear;

dropbox='../../../';
filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\delay_result.csv'];
result=csvread(filename);
result_backup=result;

idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

cc_p = [];
terminal = [];
network = [];
cloud = [];
delay = [];
for i=1:1:8
    i=i/10;
    idx=find(result(:,5)==i); 
    cc_p_length=length(idx);
    display(cc_p_length);
    cc_p=[cc_p;i];
    terminal=[terminal;mean(result(idx,1))];
    network=[network;mean(result(idx,2))];
    cloud=[cloud;mean(result(idx,3))];
    delay=[delay;mean(result(idx,4))];
end

display(cc_p);
display(terminal);
display(network);
display(cloud);
display(delay);
hold on;
plot(cc_p,terminal,'k^-');
plot(cc_p,network,'ks-');
plot(cc_p,cloud,'ko-');
plot(cc_p,delay,'kv-');

legend('Pure-Cloud','Network Minimization','Cloud  Minimization','Delay Minimization');
xlabel('Component Communication Probability'),ylabel('Response Delay');
set(gca,'XTickLabel',cc_p)




set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
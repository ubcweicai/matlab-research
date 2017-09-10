clc;
clear;

dropbox='../../../';
filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/0709/maxmin_result_ccp_all.csv'];
result=csvread(filename);
backup_result=result;
idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

ccp = [];
min = [];
min_std=[];
min_unlimited = [];
min_unlimited_std=[];
max = [];
max_std = [];
max_unlimited = [];
max_unlimited_std = [];

for i=1:1:10
    i=i/10;
    idx=find(result(:,6)==i); 
    device_length=length(idx);
    display(device_length);
    ccp =[ccp;i];
    min=[min;mean(result(idx,1))];
    min_std = [min_std;std(result(idx,1))];
    min_unlimited=[min_unlimited;mean(result(idx,2))];
    min_unlimited_std=[min_unlimited_std;std(result(idx,2))];
    max=[max;mean(result(idx,3))];
    max_std=[max_std;std(result(idx,3))];
    max_unlimited=[max_unlimited;mean(result(idx,4))];
    max_unlimited_std=[max_unlimited_std;std(result(idx,4))];
end

display(ccp);
display(min);
display(min_unlimited);
display(max);
display(max_unlimited);
hold on;


% plot(ccp,min,'ko-');
% plot(ccp,min_unlimited,'kx--');
% plot(ccp,max,'k^-');
% plot(ccp,max_unlimited,'k+--');
errorbar(ccp,min,min_std,'ko-');
errorbar(ccp,min_unlimited,min_unlimited_std,'kx--');
errorbar(ccp,max,max_std,'k^-');
errorbar(ccp,max_unlimited,max_unlimited_std,'k+--');

legend('minimum valid','minimum','maximum valid','maximum');xlabel('Component Communication Probability'),ylabel('Overall Cost');
%set(gca,'XTickLabel',deviceQuantity)


set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
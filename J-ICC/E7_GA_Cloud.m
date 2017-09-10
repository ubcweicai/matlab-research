clc;
clear;

dropbox='../../../';
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result_50-100.csv'];
% result1=csvread(filename);
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result_30-100.csv'];
% result2=csvread(filename);
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result_20-100.csv'];
% result3=csvread(filename);
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result_10-90.csv'];
% result4=csvread(filename);
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result_10-30.csv'];
% result5=csvread(filename);
% filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_delay_result.csv'];
% result6=csvread(filename);
% result=[result1; result2 ; result3; result4; result5; result6];

filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_result_cloud.csv'];
result=csvread(filename);

backup_result=result;
idx_noise = find(result(:,5)==999999999);
result(idx_noise,:)=[];
idx_noise = find(result(:,6)==999999999);
result(idx_noise,:)=[];
idx_noise = find(result(:,7)==999999999);
result(idx_noise,:)=[];


deviceQuantity=[];
nums=[];
terminal=[];
boundary=[];
greedy=[];
ga2=[];
ga3=[];
ga4=[];
terminal_std=[];
boundary_std=[];
greedy_std=[];
ga2_std=[];
ga3_std=[];
ga4_std=[];
gree=[];
for i=10:10:100
    deviceQuantity=[deviceQuantity; i];
    idx_dq = find(result(:,1)==i);
    nums=[nums; size(result(idx_dq,:),1)];
    terminal=[terminal; mean(result(idx_dq,5))];
    boundary=[boundary; mean(result(idx_dq,6))];
    gree=[gree; (result(idx_dq,7))'];
    greedy=[greedy; mean(result(idx_dq,7))];
    ga2=[ga2; mean(result(idx_dq,8))];
    ga3=[ga3; mean(result(idx_dq,9))];
    ga4=[ga4; mean(result(idx_dq,10))];
    terminal_std=[terminal_std; std(result(idx_dq,5))];
    boundary_std=[boundary_std; std(result(idx_dq,6))];
    greedy_std=[greedy_std; std(result(idx_dq,7))];
    ga2_std=[ga2_std; std(result(idx_dq,8))];
    ga3_std=[ga3_std; std(result(idx_dq,9))];
    ga4_std=[ga4_std; std(result(idx_dq,10))];
end

gree=gree';

display(deviceQuantity);
display(terminal);
display(boundary);
display(greedy);
display(ga2);
display(ga3);
display(ga4);
display(nums);
hold on;

% x=1:1:7;
% y=1:1:7;
% plot(x,y);
% plot(deviceQuantity,terminal,'k^-');
% plot(deviceQuantity,boundary,'kv-');
% plot(deviceQuantity,greedy,'ko-');
% plot(deviceQuantity,ga2,'k+-');
% plot(deviceQuantity,ga3,'kx-');
% plot(deviceQuantity,ga4,'k*-');
errorbar(deviceQuantity,terminal,terminal_std,'k^-');
errorbar(deviceQuantity,boundary,boundary_std,'kv-');
errorbar(deviceQuantity,greedy,greedy_std,'ko-');
errorbar(deviceQuantity,ga2,ga2_std,'k+-');
errorbar(deviceQuantity,ga3,ga3_std,'kx-');
errorbar(deviceQuantity,ga4,ga4_std,'k*-');

legend('Pure-Cloud','Optimal','Local Greedy','GA-I-100','GA-I-200','GA-I-300');
xlabel('Device Quantity'),ylabel('Cloud Cost');

set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
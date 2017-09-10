clc;
clear;

dropbox='../../../';
filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\delay_result.csv'];
result=csvread(filename);
result_backup=result;
col_num=size(result,1);

cc_p=[];
total=[];
terminal_error_rate=[];
network_error_rate=[];
cloud_error_rate=[];
delay_error_rate=[];

for i=1:1:10
    i=i/10;
    idx_cc_p=find(result(:,5)==i); 
    cc_p=[cc_p; i];
    total=[total; length(idx_cc_p)];
    terminal_error_rate=[terminal_error_rate; length(find(result(idx_cc_p,1)==999999999))/length(idx_cc_p)];
    network_error_rate=[network_error_rate; length(find(result(idx_cc_p,2)==999999999))/length(idx_cc_p)];
    cloud_error_rate=[cloud_error_rate; length(find(result(idx_cc_p,3)==999999999))/length(idx_cc_p)];
    delay_error_rate=[delay_error_rate; length(find(result(idx_cc_p,4)==999999999))/length(idx_cc_p)];
    
end

display(cc_p);
display(total);
display(terminal_error_rate);
display(network_error_rate);
display(cloud_error_rate);
display(delay_error_rate);

comparison = [terminal_error_rate delay_error_rate];
b=bar(comparison, 1);
set(b(1),'FaceColor','r');
set(b(2),'FaceColor','g');
% bar(terminal_error_rate,'r');
% hold on;
% bar(delay_error_rate,'g');

legend('Pure-Cloud','Cognitive Solution');
xlabel('Component Communication Probability'),ylabel('Terminal Incapable Rate');
set(gca,'XTickLabel',cc_p)





set(findall(gcf,'type','text'),'FontSize',14);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',1);
hFig = figure(1);
set(hFig, 'Position', [300 300 800 600])
  
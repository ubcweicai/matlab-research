clc;
clear;

dropbox='../../../';
filename=[dropbox,'\Code\Matlab\TCC\datat.csv'];
result=csvread(filename);

x = 1:1:12;
y = 1:1:14;
z = 1:1:20;

display(x);
display(result);


hold on;
plot(x,result(1,1:12),'kx--');
plot(y,result(2,1:14),'ks-');
plot(z,result(3,:),'ko:');
plot(x,result(4,1:12),'kv-.');

legend('Experinemt No. 1','Experinemt No. 2','Experinemt No. 3','Experinemt No. 4');
xlabel('Component No.'),ylabel('Iterations');
set(gca,'XTickLabel',z)




% set(findall(gcf,'type','text'),'FontSize',14);
% hline = findobj(gcf, 'type', 'line');
% set(hline,'LineWidth',1);
% hFig = figure(1);
% set(hFig, 'Position', [300 300 800 600])
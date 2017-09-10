clear all;
clc;
format long g

result_resource=[
160.00	38.00	21.00	86.60	38.00	74.17	20.01	106.83	56.43	20.01	
320.00	76.00	21.00	86.30	38.00	149.63	39.22	106.19	55.76	19.61	
480.00	114.00	21.00	87.67	38.00	226.95	59.94	105.35	57.30	19.98	
640.00	152.00	21.00	86.98	38.00	297.77	78.42	106.56	55.80	19.60	
800.00	190.00	21.00	87.89	38.00	378.12	98.13	105.38	56.59	19.63		
    ];
disp(result_resource);



result_throughput=[
160.00	38.00	21.00	87.83	38.00	77.42	16.19	103.58	48.27	16.19	
320.00	76.00	21.00	87.92	38.00	153.67	32.25	104.16	48.19	16.12	
480.00	114.00	21.00	86.47	38.00	232.34	48.58	103.55	47.53	16.19	
640.00	152.00	21.00	87.51	38.00	309.47	64.71	103.63	48.00	16.18	
800.00	190.00	21.00	86.67	38.00	385.71	80.77	103.86	47.56	16.15	
    ];
disp(result_throughput);



X=1:1:5;
 
% %%%%%%%%%%%%%%cloud resource optimization
% 
% %%cloud consumption
% plot(X,result_resource(:,1),'k+-');
% hold all
% plot(X,result_resource(:,6),'ko-');
% hold all
% 
% titlename=sprintf('Resource Consumption in Cloud Server');
% title(titlename, 'FontSize', 15);
% ylabel('Resource Consumption (MB)', 'FontSize', 13);
% xlabel('Number of Terminal Devices', 'FontSize', 13);
% legend('Pure-Cloud','Cognitive');
% set(gca,'xtick',0:1:5)
% 
% %%cloud consumption
% plot(X,result_resource(:,4),'k+-');
% hold all
% plot(X,result_resource(:,9),'ko-');
% hold all
% 
% titlename=sprintf('Average Interaction Latency for Terminals');
% title(titlename, 'FontSize', 15);
% ylabel('Interaction Latency (ms)', 'FontSize', 13);
% xlabel('Number of Terminal Devices', 'FontSize', 13);
% legend('Pure-Cloud','Cognitive');
% set(gca, 'ylim', [0, 150]);
% set(gca,'xtick',0:1:5)
% 
% %%%%%%%%%%%%%%%%throughput optimization
%throughput
plot(X,result_throughput(:,5),'k+-');
hold all
plot(X,result_throughput(:,10),'ko-');
hold all

titlename=sprintf('Average Throughput for Terminals');
title(titlename, 'FontSize', 15);
ylabel('Throughput (kbps)', 'FontSize', 13);
xlabel('Number of Terminal Devices', 'FontSize', 13);
legend('Pure-Cloud','Cognitive');
set(gca, 'ylim', [0, 60]);
set(gca,'xtick',0:1:5)


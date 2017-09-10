clc;
clear;

dropbox='../../../';
filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_result.csv'];
result=csvread(filename);
backup_result=result;
idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

deviceQuantity = [];
terminal = [];
delay = [];
ga1 = [];
ga2 = [];
ga3 = [];

for i=1:1:5
    idx=find(result(:,6)==i); 
    device_length=length(idx);
    display(device_length);
    deviceQuantity =[deviceQuantity;i];
    terminal=[terminal;mean(result(idx,1))];
    delay=[delay;mean(result(idx,2))];
    ga1=[ga1;mean(result(idx,3))];
    ga2=[ga2;mean(result(idx,4))];
    ga3=[ga3;mean(result(idx,5))];
end

display(deviceQuantity);
display(terminal);
display(delay);
display(ga1);
display(ga2);
display(ga3);
hold on;
grid on;
% x=1:1:7;
% y=1:1:7;
% plot(x,y);

plot(deviceQuantity,terminal,'ks-');
plot(deviceQuantity,delay,'k+-');
plot(deviceQuantity,ga1,'ko-');
plot(deviceQuantity,ga2,'kv-');
plot(deviceQuantity,ga3,'kx-');

legend('Pure-Cloud','Delay Minimization','GA1','GA2','GA3');
xlabel('Device Quantity'),ylabel('Response Delay');
%set(gca,'XTickLabel',deviceQuantity)
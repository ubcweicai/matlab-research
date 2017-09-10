clc;
clear;

dropbox='D:\Dropbox';
filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\delay_result.csv'];
result=csvread(filename);
result_backup=result;

idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

x=result(:,5);
y=result(:,6);
z=result(:,4);

plot(x,z,'.');
title('Relationship of Response Delay to Communication Probability Mean');
xlabel('Communication Probability Mean');ylabel('Response Delay');
  
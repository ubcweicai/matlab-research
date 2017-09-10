clc;
clear;

dropbox='../../../';
filename=[dropbox,'/Code/Java/GeneticResourceSimulation/newresults/genetic_convergence_result.csv'];
result=csvread(filename);
backup_result=result;
idx_noise = find(result(:,5)==999999999);
result(idx_noise,:)=[];

ga_start=result(1,1);
ga_step=result(1,2);
ga_end=result(1,3);

ga_iteration=[];
for i=ga_start:ga_step:ga_end
    ga_iteration=[ga_iteration;i];
end

boundary=[];
ga=[];

ga_file_length=(ga_end-ga_start)/ga_step;
ga_file_start=5;
ga_file_end=5+ga_file_length;

for k=ga_file_start:1:ga_file_end
    boundary=[boundary; mean(result(:,ga_file_end))];
    ga=[ga; mean(result(:,k))];
end

display(ga_iteration);
display(boundary);
display(ga);
hold on;

% x=1:1:7;
% y=1:1:7;
% plot(x,y);

plot(ga_iteration,boundary,'ks-');
plot(ga_iteration,ga,'k+-');


legend('Theoretical Boundary','GA Minimization');
xlabel('GA Evolutionary Generations'),ylabel('Response Delay');
%set(gca,'XTickLabel',deviceQuantity)
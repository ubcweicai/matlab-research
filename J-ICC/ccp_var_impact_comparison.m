clc;
clear;

dropbox='D:\Dropbox';
filename=[dropbox,'\Code\Java\GeneticResourceSimulation\newresults\delay_result.csv'];
result=csvread(filename);
result_backup=result;
idx_noise = find(result(:,1)==999999999);
result(idx_noise,:)=[];

showdata=[];
for i=0.5:0.5:7
    idy=find(result(:,6)>i); 
    idz=find(result(idy,6)<(i+0.5));
    for j=1:1:9
        j=j/10;
        idx=find(result(idz,5)==j);
        showdata=[showdata; i j mean(result(idx,1)) mean(result(idx,2)) mean(result(idx,3)) mean(result(idx,4))];
    end
end

display(showdata);
%showdata_noise = find(isnan(showdata()));
%showdata(isnan(showdata()))=0;
%display(showdata);

x=showdata(:,1);
y=showdata(:,2);
z=showdata(:,6);

plot3(x,y,z,'.');
title('Relationship of Response Delay to CC_P and Degree Variance');
xlabel('Degree Variance');ylabel('Communication Probability Mean');zlabel('Response Delay');
  
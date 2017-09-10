clc;
clear;

dropbox='../../../';

filename1=[dropbox,'/Code/Matlab/Air/scores1.csv'];
scores1=csvread(filename1);
filename2=[dropbox,'/Code/Matlab/Air/scores2.csv'];
scores2=csvread(filename2);
filename3=[dropbox,'/Code/Matlab/Air/scores3.csv'];
scores3=csvread(filename3);

judgefilename=[dropbox,'/Code/Matlab/Air/judge_matrix.csv'];
judge=csvread(judgefilename);

%a=[10 10 20 5 5 10 10 20 10];
% 
% for i=1:1:9
%     for j=1:1:9
%         A(i,j)=a(i)/a(j);
%     end
% end

A=judge';

disp(A);

WA=evaluate(A);

for i=1:1:9
    for j=1:1:10
        ave_score(i,j)=(scores1(i,j)+scores2(i,j)+scores3(i,j))/3;
    end
end

B=cell(1,9);
for k=1:1:9
    for i=1:1:10
        for j=1:1:10
            B{k}(i,j)=ave_score(k,i)/ave_score(k,j);
        end
    end
end

for k=1:1:9
    %disp(B{k});
    WB_T{k}=evaluate(B{k});
end

for j=1:1:10
    for k=1:1:9
        WB{j}(k)=WB_T{k}(j);
    end
end
% 
%WA
%WB{9}

for k=1:1:10
    R(k)=WB{k}*WA;
end
R

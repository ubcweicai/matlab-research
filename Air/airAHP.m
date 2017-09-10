clc;
clear;

dropbox='../../../';

filename1=[dropbox,'/Code/Matlab/Air/scores1.csv'];
scores1=csvread(filename1);
filename2=[dropbox,'/Code/Matlab/Air/scores2.csv'];
scores2=csvread(filename2);
filename3=[dropbox,'/Code/Matlab/Air/scores3.csv'];
scores3=csvread(filename3);

b=[10 10 20 5 5 10 10 20 10];

for i=1:1:9
    for j=1:1:9
        a(i,j)=b(i)/b(j);
    end
end

[x,y]=eig(a);
%�������ֵ����������   
Jmax=max(max(y))
%����������ֵ 

[N,M]=size(a); 
%���������ĳ���   
RI=[0  0   0.58  0.90  1.12  1.24  1.32  1.41  1.45   1.49  1.51];  
%���һ����ָ��RI  
CI=(Jmax-N)/(N-1)                           
%���һ����ָ��
CR=CI/RI(1,N)                                  
%����һ���� 
if  CR<0.1      
    disp('ͨ��һ���Լ���')                  
    %��ͨ��һ���Լ��飬�����Ȩ��
    B=zeros(N,M);                             
    %����һ��ͬ������������ 
    for  i=1:M                                         
        %ѭ����ÿһ�ж���ͬ����  
        b(:,i)=a(:,i)/sum(a(:,i));                    
        %ÿ�ж���������ÿ��ĺͣ�����ֵ��b���Ӧ��  
    end
    %ѭ������ 
    b;                 
    %���b 
    for i=1:N      
        W(1,i)=sum(b(i,:));                     
        %���й�һ���ľ����ٰ������ 
    end
    W;                                 
    s=sum(W);                                    
    %��W��һ��  
    c=W./s                                          
    %c��Ϊ��������������Ȩ��    
else
    disp('δͨ��һ���Լ���')          
    %δͨ�����������   
end



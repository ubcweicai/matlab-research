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
%求出特征值和特征向量   
Jmax=max(max(y))
%求出最大特征值 

[N,M]=size(a); 
%看这个矩阵的长宽   
RI=[0  0   0.58  0.90  1.12  1.24  1.32  1.41  1.45   1.49  1.51];  
%随机一致性指标RI  
CI=(Jmax-N)/(N-1)                           
%求出一致性指标
CR=CI/RI(1,N)                                  
%检验一致性 
if  CR<0.1      
    disp('通过一致性检验')                  
    %若通过一致性检验，则求出权重
    B=zeros(N,M);                             
    %设置一个同样长宽的零矩阵 
    for  i=1:M                                         
        %循环，每一列都相同操作  
        b(:,i)=a(:,i)/sum(a(:,i));                    
        %每列都除以这列每项的和，并赋值给b相对应列  
    end
    %循环结束 
    b;                 
    %输出b 
    for i=1:N      
        W(1,i)=sum(b(i,:));                     
        %把列归一化的矩阵再按行求和 
    end
    W;                                 
    s=sum(W);                                    
    %将W归一化  
    c=W./s                                          
    %c即为所求特征向量即权重    
else
    disp('未通过一致性检验')          
    %未通过则结束操作   
end



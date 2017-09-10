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
        A(i,j)=b(i)/b(j);
    end
end

[n,n]=size(A);
x=ones(n,100);
y=ones(n,100);
m=zeros(1,100);
m(1)=max(x(:,1));
y(:,1)=x(:,1);
x(:,2)=A*y(:,1);
m(2)=max(x(:,2));
y(:,2)=x(:,2)/m(2);
p=0.0001;i=2;k=abs(m(2)-m(1));
while  k>p  
    i=i+1;  
    x(:,i)=A*y(:,i-1); 
    m(i)=max(x(:,i)); 
    y(:,i)=x(:,i)/m(i);
    k=abs(m(i)-m(i-1));
end
a=sum(y(:,i));
w=y(:,i)/a;
t=m(i);
disp('权向量');
disp(w);
disp('最大特征值');
disp(t); %以下是一致性检验CI=(t-n)/(n-1);
            
disp('t=');
disp(t);    

CI=(t-n)/(n-1);
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
CR=CI/RI(n);
    
if CR<0.10    
    disp('此矩阵的一致性可以接受!');  
    disp('CI=');
    disp(CI);    
    disp('CR=');
    disp(CR);
else
    disp('此矩阵的一致性不可以接受!');
end
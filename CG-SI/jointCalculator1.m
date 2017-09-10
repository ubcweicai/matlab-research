clc;
clear;


% result=csvread('C:\Users\Yuanchi\workspace\PricingModel\jointCalculatorWithUserTaskNumber1.csv');
result=csvread('data\simulationResultSample.csv');
[row,col]=size(result);
largetsum=result(row,1);

old_price=[];
new_price=[];

for i=4:1:largetsum
%     idy=find(result(:,1)>i); 
%     idz=find(result(idy,2)<(i+1));
    idz=find(result(:,1)==i); 
    
    old_price=[old_price; i mean(result(idz,2))];
    new_price=[new_price; i mean(result(idz,3))];
    
end

display(old_price);
display(new_price);

x=old_price(:,1);
y=old_price(:,2);
z=new_price(:,2);

% plot3(x,y,z,'.');
plot(x,y,'b',x,z,'r')
legend('Old Revenue', 'New Revenue');

title('Comparison between existing and proposed pricing model');
xlabel(' Variance');ylabel('Revenue ($/hour)');
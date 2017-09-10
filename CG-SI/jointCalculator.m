clc;
clear;


% result=csvread('C:\Users\Yuanchi\workspace\PricingModel\jointCalculatorWithUserTaskNumber1.csv');
result=csvread('data\simulationResultSample.csv');

[row,col]=size(result);

x=1:1:5;
y=result(1:5,2);
z=result(1:5,3);

display(x);
display(y);
display(z);

% plot3(x,y,z,'.');
plot(x,y,'b',x,z,'r')
legend('Old Revenue', 'New Revenue');

title('Comparison between existing and proposed pricing model');
xlabel('Cases');ylabel('Revenue ($/hour)');
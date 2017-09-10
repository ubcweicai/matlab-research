clc;
clear;

filename='data\PFrame_size.csv';
result=csvread(filename);


x=[];
y=[]; 
z=[];

player=41;

for i=1:1:9
    for j=1:1:9
        x=[x i];
        y=[y j];
        z=[z result(player,(i-1)*9+j)];
    end
end

% z=[-0.59 -0.58 0.53 1.25 1.26 -0.2 -0.18 -0.14 0.64 -0. 1.06 0.73 -0.15 0.15 -0.1 0.08 0.17 0.8];
[X,Y]=meshgrid(1:1:9,1:1:9);
Z=griddata(x,y,z,X,Y);
mesh(X,Y,Z)
% hold on
% plot3(x,y,z,'*')
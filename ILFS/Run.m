clear all;
clc;

% Calucation Parameters
LIGHTFIELDSCALE=4;
lambda=0.02;
P_Walk=0.65;
LIFETIME=8;
L_min=1;
L_max=5;
USER=2;

% Clean the previous results
Path='FigureData\Intermediate\';

if (exist('FigureData','dir'))    
    cmd = sprintf('rmdir /Q /S  %s', 'FigureData');
    [status,result] = system(cmd);        
end  

cmd = sprintf('mkdir %s', 'FigureData');
[status,result] = system(cmd);  

cmd = sprintf('mkdir %s', 'FigureData\\Intermediate');
[status,result] = system(cmd);  

%*******************************************************************************************
% Experiments for various P_Walk value                                                     *
%*******************************************************************************************
% Range of Parameters
P_Walk_start=0;
P_Walk_step=0.05;
P_Walk_end=0.5;

SimResultP_Walk=[];
for P_Walk_p=P_Walk_start:P_Walk_step:P_Walk_end
    
    filename=sprintf('%sResultP_Walk_%f.txt',Path,P_Walk_p);
    Result_temp=calculation(LIGHTFIELDSCALE, lambda, P_Walk_p, LIFETIME, USER, L_min, L_max);
    dlmwrite(filename,Result_temp,'precision', 8);
    SimResultP_Walk=[SimResultP_Walk; Result_temp];
    
end

filename=sprintf('FigureData\\CalculationResultP_Walk.txt');
csvwrite(filename,SimResultP_Walk);

% To plot the figure
% plotfigure('P_Walk',P_Walk_start,P_Walk_step,P_Walk_end);

%*******************************************************************************************
% Experiments for various User value                                                       *
%*******************************************************************************************
% Range of Parameters
User_start=1;
User_step=1;
User_end=5;

SimResultUser=[];
for User_p=User_start:User_step:User_end
    
    filename=sprintf('%sResultUser_%f.txt',Path,User_p);
    Result_temp=calculation(LIGHTFIELDSCALE, lambda, P_Walk, LIFETIME, User_p, L_min, L_max);
    dlmwrite(filename,Result_temp,'precision', 8);
    SimResultUser=[SimResultUser; Result_temp];
    
end

filename=sprintf('FigureData\\CalculationResultUser.txt');
csvwrite(filename,SimResultUser);

% To plot the figure
% plotfigure('User',User_start,User_step,User_end);

%*******************************************************************************************
% Experiments for various Lambda value                                                     *                                                      
%*******************************************************************************************
% Range of Parameters
lambda_start=0;
lambda_step=0.05;
lambda_end=0.5;

SimResultLambda=[];
for lambda_p=lambda_start:lambda_step:lambda_end
    
    filename=sprintf('%sResultLambda_%f.txt',Path,lambda_p);
    Result_temp=calculation(LIGHTFIELDSCALE, lambda_p, P_Walk, LIFETIME, USER, L_min, L_max);
    dlmwrite(filename,Result_temp,'precision', 8);
    SimResultLambda=[SimResultLambda; Result_temp];
    
end

filename=sprintf('FigureData\\CalculationResultLambda.txt');
csvwrite(filename,SimResultLambda);

% To plot the figure
% plotfigure('Lambda',lambda_start,lambda_step,lambda_end);
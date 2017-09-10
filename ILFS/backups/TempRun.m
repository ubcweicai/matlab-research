clear all;
clc;


SimResult=[];

LIGHTFIELDSCALE=4;
lambda=0,08;
P_Walk=0.65;
LIFETIME=7;
L_min=1;
L_max=5;
USER=2;

Path='FigureData\';

if (exist('FigureData','dir'))    
    cmd = sprintf('rmdir /Q /S  %s', 'FigureData');
    [status,result] = system(cmd);        
end  

cmd = sprintf('mkdir %s', 'FigureData');
[status,result] = system(cmd);  
    
    filename=sprintf('%sResultUSER_%f.txt',Path,USER);
    Result_temp=calculation(LIGHTFIELDSCALE, lambda, P_Walk, LIFETIME, USER, L_min, L_max);
    dlmwrite(filename,Result_temp,'precision', 8);
    SimResult=[SimResult; Result_temp];

disp(SimResult);
clear all;
clc;
format long g

REPEAT=100;

%%%%%%%%%%%%%%%% Simulation Parameters %%%%%%%%%%%%%%%%%
%Number of Players N
N = 4;
%Map Size : M x M screen
M = 8;
%Random Start or Center Start
RandomStart=1;
%Possibilty of Random Walk
P_walk = 0.7;
%Chase Time
T_chase = 5;
%Game Simulation Time T
T = 1000;
%Frame Per Second
FPS=24;

%%%%%%%%%%%%%%%% Simulation Parameters End%%%%%%%%%%%%%%%%%

result=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Time Various = Random vs Centre                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%% Random Start
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=1;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for T = 100:100:1500
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=100:100:1500;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');
% 
% titlename=sprintf('Players Start The Game in Random Position ');
% title(titlename);
% xlabel('Game Time');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_Time_RandomStart.txt');
% csvwrite(filename,result);

% %%%%%%%%%% Center Start
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=0;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for T = 100:100:1500
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=100:100:1500;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');

% 
% titlename=sprintf('Players Start The Game in a Same Screen');
% title(titlename);
% xlabel('Game Time');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_Time_CenterStart.txt');
% csvwrite(filename,result);




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                  Players Various                        %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=1;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for N = 2:2:10
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=2:2:10;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');

% 
% titlename=sprintf('Tradeoff with Number of Players');
% title(titlename);
% xlabel('Number of Players');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_Player.txt.txt');
% csvwrite(filename,result);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                   P_walk Various                        %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=1;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for P_walk = 0.5:0.1:1
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=0.5:0.1:1;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');
% 
% 
% titlename=sprintf('Tradeoff with Probability of Random Walk');
% title(titlename);
% xlabel('Probability of Random Walk');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_RandomWalk.txt');
% csvwrite(filename,result);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                 Chase Time Various                      %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=1;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for T_chase = 2:4:50
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=2:4:50;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');
% 
% titlename=sprintf('Tradeoff with Chase Time');
% title(titlename);
% xlabel('Chase Time');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_ChaseTime.txt');
% csvwrite(filename,result);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                      Game Map Size                      %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% self parameter
% %Map Size : M x M screen
% M = 8;
% %Random Start or Center Start
% RandomStart=1;
% %Possibilty of Random Walk
% P_walk = 0.7;
% %Chase Time
% T_chase = 5;
% 
% %%%% various parameter
% 
% for M = 2:2:20
% 
%     r=0;
%     for repeat=1:REPEAT
%         r=r+cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS);
%     end
%     r=r/REPEAT;
%     
%     result=[result; r];
%     
% end
% 
% disp(result);
% 
% 
% X=2:2:20;
% 
% plot(X,result(:,1),'+-');
% hold all
% plot(X,result(:,2),'o-');
% hold all
% plot(X,result(:,3),'x-');
% 
% titlename=sprintf('Tradeoff with Game Map Size');
% title(titlename);
% xlabel('Map Size');
% ylabel('Transmission Rate');
% legend('Original Intra-Video Encoding','Optimal Inter-Video Encoding','One-Hop Inter-Video Encoding');
% 
% fprintf('Original Transmission Rate: %.2f\n',result(1));
% fprintf('Optimal Transmission Rate: %.2f\n',result(2));
% fprintf('OneHop Transmission Rate: %.2f\n',result(3));
% 
% filename=sprintf('Data_MapSize.txt');
% csvwrite(filename,result);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Diablo Case Study                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% self parameter
%Number of players
N = 3;
%Map Size : M x M screen
M = 40;
%Random Start or Center Start
RandomStart=0;
%Possibilty of Random Walk
P_walk = 0.6;
%Chase Time
T_chase = 10;
%Game Time
T=60*60;

r=0;
result=[];
for repeat=1:REPEAT
  r=r+cloudgame(N, M, P_walk, T_chase, T*FPS, RandomStart, FPS);
end
r=r/REPEAT;
    
result=[result; r];
    

disp(result);


filename=sprintf('Data_Diablo.txt');
csvwrite(filename,result);

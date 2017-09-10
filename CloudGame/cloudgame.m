function y = cloudgame(N, M, P_walk, T_chase, T, RandomStart, FPS)

INVALID = 999999999;

%%%%%%%%%%%%%%%% Simulation Parameters %%%%%%%%%%%%%%%%%
%Number of Players N
%N = 8;
%Screen Width and Height
W = 1024;
H = 1024;
%Map Size : M x M screen
%M = 2;
%Pixels for each step
K = 32;
%Range for X axis move
X_range=W*(M-1)/K;
%Range for Y axis move
Y_range=H*(M-1)/K;
%Possibilty of Random Walk
%P_walk = 0.8;
%Possibilty of chase
P_chase = 1-P_walk;
%Chase Time
%T_chase = 4;
%Game Simulation Time T
%T = 100;

%Standard I frame size
I = 245296;
%compress ratio for P-inter
rho = 0.7;
%Everage P frame size
%minimum=14107, maximum=53054
P_e = 28749;
%%%%%%%%%%%%%%%% Simulation Parameters end%%%%%%%%%%%%%%%%%


%Throughput of Server Transmission for original intra-P frame
Thr_original = 0;
%Throughput of Server Transmission for optimal encoding
Thr_optimal = 0;
%Throughput of Server Transmission for one-hop encoding
Thr_onehop = 0;



%initiate the starting position of N players
for c = 1 : N

    if(RandomStart==1)
    
    %random start
        X_rnd=randperm(X_range);
        Y_rnd=randperm(Y_range);
        X(c)=X_rnd(1);
        Y(c)=Y_rnd(1);
    else
    %center start
        X(c)=X_range/2+c;
        Y(c)=Y_range/2+c;
    end
    
    %to store the target of chasing
    Chase_Target(c)=0;
    %to store the remaining time of chasing
    Chase_Time(c)=0;
end

%test data
% X(1)=0;
% Y(1)=0;
% X(2)=1;
% Y(2)=2;
% X(7)=0;
% Y(7)=X_range;

for t = 1 : T
    
    %%%disp('Original Encoding...');
    %To get the frame size of P-frames
    for c = 1 : N
        
        
        %Frame size for intra-video P-frame Size
        P_intra(c)=poissrnd(28749);
        
        Thr_original=Thr_original+P_intra(c);
        %%%fprintf('Origial: %d is encoded as intra P <%.2f>\n', c, P_intra(c));
        
        %setup the coordinator of each players
        %first check if the player is in chase mode
        if(Chase_Target(c)~=0)
            %perform chase mode
            X_diff = X(Chase_Target(c))-X(c);
            Y_diff = Y(Chase_Target(c))-Y(c); 
            if((X_diff>0)&&(X(c)<X_range))
                X(c)=X(c)+1;
            end
            if((X_diff<0)&&(X(c)>0))
                X(c)=X(c)-1;
            end            
            if((Y_diff>0)&&(Y(c)<Y_range))
                Y(c)=Y(c)+1;
            end
            if((Y_diff<0)&&(Y(c)>0))
                Y(c)=Y(c)-1;
            end 
            
            %decrease the chase Time count
            Chase_Time(c)=Chase_Time(c)-1;
            
            %check if exit the chase mode
            if(Chase_Time(c)==0)
                Chase_Target(c)=0;
            end
            
        else
            %if the player is not in chase mode
            temp_rnd=rand;
            if(temp_rnd<P_walk)
                %walk mode
                X_move_template=randperm(3)-2;
                Y_move_template=randperm(3)-2;
                X(c)=X(c)+X_move_template(1);
                Y(c)=Y(c)+Y_move_template(1);
                
                %boundary check
                if(X(c)<0)
                    X(c)=0;
                end 
                if(Y(c)<0)
                    Y(c)=0;
                end 
                if(X(c)>X_range)
                    X(c)=X_range;
                end 
                if(Y(c)>Y_range)
                    Y(c)=Y_range;
                end                 
                
            else
                %chase mode
                Chase_ID_Pick=randperm(N);
                %to store the target of chasing
                Chase_Target(c)=Chase_ID_Pick(1);
                %to store the remaining time of chasing
                Chase_Time(c)=T_chase;
            
            end
        end
        
    end
    
    %Frame size for inter-video P-frame Size
    for j = 1 : N    
        for k = 1 : N
            %calculate the overlap ratio
            X_diff=abs(X(j)-X(k));
            Y_diff=abs(Y(j)-Y(k));
            
            if((X_diff<(W/K))&&(Y_diff<(H/K)))
                R_overlap = ((W-(K*abs(X(j)-X(k))))*(H-(K*abs(Y(j)-Y(k)))))/(W*H);
                %disp(R_overlap);
            else
                R_overlap = 0;
            end
                
            P_inter(j,k)=(1-R_overlap)*I*rho;
            
            if((P_inter(j,k)>=P_intra(j))||(j==k))
                P_inter(j,k)=INVALID;
            end
            
            %disp(P_inter(j,k));
            
        end
    end
    
    %get groups in G
    G=grouping(P_inter,N,INVALID);
    
    %calculate frame size for optimal encoding
    optimal_frame_size=optimal(G,P_intra,P_inter,N,INVALID);
    Thr_optimal=Thr_optimal+optimal_frame_size;
    
    %calculate frame size for one-hop encoding
    onehop_frame_size=onehop(G,P_intra,P_inter,N,INVALID);
    Thr_onehop=Thr_onehop+onehop_frame_size;

end

%calculate server transmission rate for original intra-P frame
TranRate_original = Thr_original * FPS / T / N;

%calculate server transmission rate for optimal encoding
TranRate_optimal = Thr_optimal * FPS / T / N;

%calculate server transmission rate for one-hop encoding
TranRate_onehop = Thr_onehop * FPS / T / N;

y=[TranRate_original, TranRate_optimal, TranRate_onehop];

end
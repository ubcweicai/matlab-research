function y = calculation(LIGHT_FIELD_SCALE_v, lambda_v, P_WALK_v, LIFETIME_MEAN_v, NUMBER_OF_USERS_v,L_min_v,L_max_v) 

% clear all;
% clc;
%===============================================
% Constants
%===============================================
LIGHT_FIELD_SCALE=LIGHT_FIELD_SCALE_v;
TOTAL_NUM=LIGHT_FIELD_SCALE*LIGHT_FIELD_SCALE;

lambda=lambda_v;
P_WALK=P_WALK_v;
P_JUMP=1-P_WALK;
LIFETIME_MEAN=LIFETIME_MEAN_v;
NUMBER_OF_USERS=NUMBER_OF_USERS_v;
L_min=L_min_v;
L_max=L_max_v;

Results=[];
Results_lambda=[];
Results_WALK=[];
Results_LIFETIME=[];
Results_USERS=[];

%===============================================
% Basic Redundant Structure
%===============================================
% fprintf('=====I frame Structure\n');
%Structure of I-frame
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        S_I(j,i)=1;
    end
end
% disp(S_I);

%====================================================
% Case 1: All I frames, no caching cooperative
%====================================================

lag_cost=F_ILFS_All_I(S_I,LIGHT_FIELD_SCALE, lambda, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
fprintf('###########################################################\n');
fprintf('Case 1: All I frames, no caching cooperative\n');
fprintf('Lagrangian Cost: %f\n',lag_cost(1,3));
fprintf('###########################################################\n\n');
Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];

%====================================================
% Case 2: Adjacent P-frames, no caching cooperative
%====================================================

%Structure of W0-frame
% fprintf('=====W0 frame Structure\n');
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        S_W0(j,i)=1;
    end
end
% disp(S_W0);

%Structure of P-frame
% fprintf('=====P frame Structure\n');
for j=1:TOTAL_NUM
    for i=1:TOTAL_NUM
        S_P(j,i)=0;
    end
end

for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        Number=(j-1)*LIGHT_FIELD_SCALE+i;
        %To assign probabilities for neighbors
        %Not in left board
        if mod(Number,LIGHT_FIELD_SCALE)~=1
            S_P(Number,Number-1)=1;
        end
        %Not in right board
        if mod(Number,LIGHT_FIELD_SCALE)~=0
            S_P(Number,Number+1)=1;
        end
        %Not in Upper Board
        if Number>(LIGHT_FIELD_SCALE)
            S_P(Number,Number-LIGHT_FIELD_SCALE)=1;
        end
        %Not in Down Board
        if Number<=(TOTAL_NUM-LIGHT_FIELD_SCALE)
            S_P(Number,Number+LIGHT_FIELD_SCALE)=1;
        end
    end
end
% disp(S_P);

%Structure of W1-frame
% fprintf('=====W1 frame Structure\n');
for j=1:TOTAL_NUM
    for i=1:TOTAL_NUM
        S_W1(j,i)=0;
    end
end
% disp(S_W1);

lag_cost=F_ILFS_All_P(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
fprintf('###########################################################\n');
fprintf('Case 2: Adjacent P-frames, no caching cooperative\n');
fprintf('Lagrangian Cost: %f\n',lag_cost(1,3));
fprintf('###########################################################\n\n');
Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];

%====================================================
% Case 3: Adjacent P-frames, with caching cooperative
%====================================================
lag_cost=F_ILFS(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
fprintf('###########################################################\n');
fprintf('Case 3: Adjacent P-frames, with caching cooperative\n');
fprintf('Lagrangian Cost: %f\n',lag_cost(1,3));
fprintf('###########################################################\n\n');
Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];

% % % %====================================================
% % % % Case test: Full P-frames, with caching cooperative
% % % %====================================================
% % % for j=1:TOTAL_NUM
% % %     for i=1:TOTAL_NUM
% % %         if i~=j
% % %             S_P_full(j,i)=1;
% % %         else
% % %             S_P_full(j,i)=0;
% % %         end
% % %     end
% % % end
% % % 
% % % lag_cost=F_ILFS(S_I,S_W0,S_P_full,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
% % % fprintf('###########################################################\n');
% % % fprintf('Case test: Full P-frames, with caching cooperative\n');
% % % fprintf('Strorage: %f, Transmission Cost: %f, Lagrangian Cost: %f\n',lag_cost(1,1),lag_cost(1,2),lag_cost(1,3));
% % % fprintf('###########################################################\n\n');
% % % Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];
% % % disp(S_P_full);
% % % 
% % % 
% % % %====================================================
% % % % Case test2: Full P-frames with one blank, with caching cooperative
% % % %====================================================
% % % S_P_full(1,6)=0;
% % % S_P_full(1,7)=0;
% % % S_P_full(1,8)=0;
% % % S_P_full(3,4)=0;
% % % S_P_full(3,7)=0;
% % % S_P_full(3,8)=0;
% % % S_P_full(3,9)=0;
% % % S_P_full(4,3)=0;
% % % S_P_full(5,1)=0;
% % % S_P_full(5,3)=0;
% % % S_P_full(5,7)=0;
% % % S_P_full(5,9)=0;
% % % S_P_full(6,7)=0;
% % % S_P_full(7,1)=0;
% % % S_P_full(7,2)=0;
% % % S_P_full(7,3)=0;
% % % S_P_full(7,6)=0;
% % % S_P_full(9,1)=0;
% % % S_P_full(9,2)=0;
% % % S_P_full(9,3)=0;
% % % S_P_full(9,4)=0;
% % % S_P_full(9,7)=0;
% % % 
% % % lag_cost=F_ILFS(S_I,S_W0,S_P_full,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
% % % fprintf('###########################################################\n');
% % % fprintf('Case test: Full P-frames with one blank, with caching cooperative\n');
% % % fprintf('Strorage: %f, Transmission Cost: %f, Lagrangian Cost: %f\n',lag_cost(1,1),lag_cost(1,2),lag_cost(1,3));
% % % fprintf('###########################################################\n\n');
% % % Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];
% % % disp(S_P_full);

% ===============================================
% Case 4: Find sub-optimal solution
% ===============================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%===============================================
% To initiate the initial state matrix
%===============================================
g=[];
for i=1:TOTAL_NUM
   g=[g 0];
end
g(1, ceil(TOTAL_NUM/2))=1;
% % % fprintf('=====initial state g\n');
% % % disp(g);

%===============================================
% To initiate the transition matrix
%===============================================
for j=1:TOTAL_NUM
    for i=1:TOTAL_NUM
        Transition_Matrix(j,i)=0;
    end
end

for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        
        Number=(j-1)*LIGHT_FIELD_SCALE+i;
        
        %====================================
        %To calculate the number of neighbors
        NumberOfNeighbors=0;
        %Not in left board
        if mod(Number,LIGHT_FIELD_SCALE)~=1
            NumberOfNeighbors=NumberOfNeighbors+1;
        end
        %Not in right board
        if mod(Number,LIGHT_FIELD_SCALE)~=0
            NumberOfNeighbors=NumberOfNeighbors+1;
        end
        %Not in Upper Board
        if Number>(LIGHT_FIELD_SCALE)
            NumberOfNeighbors=NumberOfNeighbors+1;
        end
        %Not in Down Board
        if Number<=(TOTAL_NUM-LIGHT_FIELD_SCALE)
            NumberOfNeighbors=NumberOfNeighbors+1;
        end
        
        %Probability to neighbors
        P_TO_Neighbor=P_WALK/NumberOfNeighbors;
        
        %Probability to stay
        Transition_Matrix(Number,Number)=0;
        
        %=====================================
        %To assign probabilities for neighbors
        %Not in left board
        if mod(Number,LIGHT_FIELD_SCALE)~=1
            Transition_Matrix(Number,Number-1)=P_TO_Neighbor;
        end
        %Not in right board
        if mod(Number,LIGHT_FIELD_SCALE)~=0
            Transition_Matrix(Number,Number+1)=P_TO_Neighbor;
        end
        %Not in Upper Board
        if Number>(LIGHT_FIELD_SCALE)
            Transition_Matrix(Number,Number-LIGHT_FIELD_SCALE)=P_TO_Neighbor;
        end
        %Not in Down Board
        if Number<=(TOTAL_NUM-LIGHT_FIELD_SCALE)
            Transition_Matrix(Number,Number+LIGHT_FIELD_SCALE)=P_TO_Neighbor;
        end
        
        %Probability to Jump to each blank 
        P_TO_Random=P_JUMP/(TOTAL_NUM-NumberOfNeighbors-1);
        
        %=======================================
        %to assign probabilities for random jump
        for count=1:TOTAL_NUM
            if (count~=Number)&(Number~=count+1)&(Number~=count-1)&(Number~=count-LIGHT_FIELD_SCALE)&(Number~=count+LIGHT_FIELD_SCALE)
                if Transition_Matrix(Number,count)==0
                    Transition_Matrix(Number,count)=P_TO_Random;
                end
            end
        end
        
    end
end

format rat;

%Transistion Matrix A
A=[];
for j=1:TOTAL_NUM
    B=[];
    for i=1:TOTAL_NUM
        B=[B Transition_Matrix(j,i)];
    end
    A=[A;B];
end

%=========================================================================
% Image Caching Probabilites q_{i,j}=1-(1-\sum_{l=0}^{\mu/2}p_{i,j}(l))^U
%=========================================================================
q=[];
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        p_ij_mul=1;
        for L_mu=0:(LIFETIME_MEAN/2)
            q_temp=g*(A^L_mu);
            p_ij_mul=p_ij_mul*(1-q_temp(1,(j-1)*LIGHT_FIELD_SCALE+i));
        end
%         disp(p_ij_mul);
        q(j,i)=1-p_ij_mul^NUMBER_OF_USERS;
%         q(j,i)=1-(1-p(j,i))^NUMBER_OF_USERS;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FRAME_SIZE_PATH='Results\';
P_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'PFrame_size.txt');
W1_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'W1Frame_size.txt');
Size_P=[];
Size_P=dlmread(P_Size_File);
Size_W1=[];
Size_W1=dlmread(W1_Size_File);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MinimumLag=lag_cost;
MinimumP=[];
MinimumP_Found=1;

%%%%P-Frame Optimization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get all P-frame candidates
P_sets=[];
for j=1:TOTAL_NUM
    for i=1:TOTAL_NUM
        if (S_P(j,i)==0) & (i~=j)
            temp_P=[j i q(ceil(i/LIGHT_FIELD_SCALE),i-(ceil(i/LIGHT_FIELD_SCALE)-1)*LIGHT_FIELD_SCALE) Size_P(j,i)];
            P_sets=[P_sets; temp_P];
        end
    end
end

% P_sets=sortrows(P_sets,[-3 4]);
% fprintf('###########################################################\n');
% disp(P_sets);
% fprintf('Original P frames\n');
% disp(S_P);

Size_P_sets=size(P_sets);

format long g;

current_lag_cost=F_ILFS(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
fprintf('***********Start first round calculation***********\n');
for I_candidate=1:TOTAL_NUM
    min_lag_cost(I_candidate)=current_lag_cost(1,3);
    for P_candidate=1:Size_P_sets
        if P_sets(P_candidate,1)==I_candidate
            S_P_opt=S_P;
            S_P_opt(P_sets(P_candidate,1),P_sets(P_candidate,2))=1;
            lag_cost_temp=F_ILFS(S_I,S_W0,S_P_opt,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
%             fprintf('Lagrangian cost for P[%d]->[%d] is ',P_sets(P_candidate,1),P_sets(P_candidate,2));
%             fprintf('%f, to be compared with %f\n',lag_cost_temp(1,3),min_lag_cost(I_candidate));
            if lag_cost_temp(1,3) < min_lag_cost(I_candidate)
%                 fprintf('****** Better P[%d]->[%d] frame found! %f < %f ******\n',P_sets(P_candidate,1),P_sets(P_candidate,2) ,lag_cost_temp(1,3),min_lag_cost(I_candidate));
                min_lag_cost(I_candidate)=lag_cost_temp(1,3);
                min_candidate(I_candidate)=P_sets(P_candidate,2);
            end            
        end        
    end
    
    if min_lag_cost(I_candidate) == current_lag_cost(1,3)
        min_lag_cost(I_candidate)=999999999;
        min_candidate(I_candidate)=0;
    end
end

fprintf('***********First round***********\n');
% disp(min_lag_cost);
% disp(min_candidate);

best_cost=min_lag_cost(1);
best_candidate=[1 min_candidate(1)];

for I_candidate=2:TOTAL_NUM
    if best_cost > min_lag_cost(I_candidate)
        best_cost=min_lag_cost(I_candidate);
        best_candidate=[I_candidate min_candidate(I_candidate)];
    end
end

% fprintf('***********First round best candidate***********\n');
% disp(best_cost);
% disp(best_candidate);

if best_candidate(1,2)~=0
    S_P(best_candidate(1,1),best_candidate(1,2))=1;
end

k=2;

while ~isempty(best_candidate)
    P_sets=[];
    for j=1:TOTAL_NUM
        for i=1:TOTAL_NUM
            if ((S_P(j,i)==0) & (i~=j) & S_W1(j,i)==0)
                temp_P=[j i q(ceil(i/LIGHT_FIELD_SCALE),i-(ceil(i/LIGHT_FIELD_SCALE)-1)*LIGHT_FIELD_SCALE) Size_P(j,i)];
                P_sets=[P_sets; temp_P];
            end
        end
    end
    
    Size_P_sets=size(P_sets);
    
    current_lag_cost=F_ILFS(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
    min_lag_cost(best_candidate(1,1))=current_lag_cost(1,3);
%     fprintf('****** Before loop, current lag cost is %f ******\n',current_lag_cost(1,3));
%     fprintf('***********they are the same [%f]->[%f]\n',best_cost,ka(1,3));
    for P_candidate=1:Size_P_sets    
        if P_sets(P_candidate,1)==best_candidate(1,1)
            S_P_opt=S_P;
            S_P_opt(P_sets(P_candidate,1),P_sets(P_candidate,2))=1;
            lag_cost_temp=F_ILFS(S_I,S_W0,S_P_opt,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
%             fprintf('Lagrangian cost for P[%d]->[%d] is',P_sets(P_candidate,1),P_sets(P_candidate,2));
%             fprintf('%f\n',lag_cost_temp(1,3));
            if lag_cost_temp(1,3) < min_lag_cost(best_candidate(1,1))
%                 fprintf('****** Better P[%d]->[%d] frame found! %f < %f ******\n',P_sets(P_candidate,1),P_sets(P_candidate,2) ,lag_cost_temp(1,3),min_lag_cost(best_candidate(1,1)));
                min_lag_cost(best_candidate(1,1))=lag_cost_temp(1,3);
                min_candidate(best_candidate(1,1))=P_sets(P_candidate,2);
            end  
        end
    end
    
    if min_lag_cost(best_candidate(1,1))==current_lag_cost(1,3)
%         fprintf('****** No better P:  %f == %f ******\n',min_lag_cost(best_candidate(1,1)),current_lag_cost(1,3));
        min_lag_cost(best_candidate(1,1))=999999999;
        min_candidate(best_candidate(1,1))=0;
    end
    
    
    best_cost=min_lag_cost(1);
    best_candidate=[1 min_candidate(1)];

    for I_candidate=2:TOTAL_NUM
%         fprintf('comparing if %f > %f\n',best_cost,min_lag_cost(I_candidate));
        if best_cost > min_lag_cost(I_candidate)
            best_cost=min_lag_cost(I_candidate);
            best_candidate=[I_candidate min_candidate(I_candidate)];
        end
    end

    fprintf('***********%d round best candidate***********\n',k);
%     disp(min_lag_cost);
%     disp(min_candidate);
%     
%     disp(best_cost);
%     disp(best_candidate);
    
    if best_candidate(1,2)~=0
        S_P(best_candidate(1,1),best_candidate(1,2))=1;
        Add_P_cost=F_ILFS(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
        
%         fprintf('@@@@@ [%d,%d]\n ',best_candidate(1,1),best_candidate(1,2));
        
        S_P_opt=S_P;
        S_W1_opt=S_W1;
        S_W1_opt(best_candidate(1,1),best_candidate(1,2))=1;
        S_P_opt(best_candidate(1,1),best_candidate(1,2))=0;
        for W1_less=1:TOTAL_NUM
            if (Size_W1(best_candidate(1,1),best_candidate(1,2))>Size_W1(best_candidate(1,1),W1_less))&(best_candidate(1,1)~=W1_less)
%                 fprintf('W1 within [%d,%d]%f, [%d,%d]%f\n ',best_candidate(1,1),best_candidate(1,2),Size_W1(best_candidate(1,1),best_candidate(1,2)),best_candidate(1,1),W1_less,Size_W1(best_candidate(1,1),W1_less));
                S_W1_opt(best_candidate(1,1),W1_less)=1;
                S_P_opt(best_candidate(1,1),W1_less)=0;
            end
        end
        
%         disp(S_W1_opt);
        
        Add_W1_cost=F_ILFS(S_I,S_W0,S_P_opt,S_W1_opt,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
        
        if Add_P_cost(1,3)<Add_W1_cost(1,3)
            S_P(best_candidate(1,1),best_candidate(1,2))=1;
        else
            S_P=S_P_opt;
            S_W1=S_W1_opt;
        end
        
    else
        if best_cost~=999999999
            fprintf('**************!!!!!!!!!!!ERROR!!!!!!!!!**************\n');
        end
        best_candidate=[];
    end
    k=k+1;
    
end

lag_cost=F_ILFS(S_I,S_W0,S_P,S_W1,LIGHT_FIELD_SCALE, lambda, P_WALK, LIFETIME_MEAN, NUMBER_OF_USERS, L_min, L_max);
fprintf('###########################################################\n');
fprintf('Case 4: Found sub-optimal solution P W1\n');
fprintf('Strorage: %f, Transmission Cost: %f, Lagrangian Cost: %f\n',lag_cost(1,1),lag_cost(1,2),lag_cost(1,3));
fprintf('###########################################################\n\n');

% fprintf('Optimal P frames\n');
% disp(S_P);
% fprintf('Optimal W1 frames\n');
% disp(S_W1);

Results=[Results; lambda P_WALK LIFETIME_MEAN NUMBER_OF_USERS lag_cost(1,1) lag_cost(1,2) lag_cost(1,3)];

y=Results;

end
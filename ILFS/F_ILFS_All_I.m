function y = F_ILFS( S_I_v, Scale, lambda_v, LIFETIME_MEAN_v, NUMBER_OF_USERS_v, L_min_v, L_max_v) 

% clear all;
% clc;
%===============================================
% Constants
%===============================================
LIGHT_FIELD_SCALE=Scale;
TOTAL_NUM=LIGHT_FIELD_SCALE*LIGHT_FIELD_SCALE;
lambda=lambda_v;

%No walk mode
P_WALK=0;
P_JUMP=1;

LIFETIME_MEAN=LIFETIME_MEAN_v;
NUMBER_OF_USERS=NUMBER_OF_USERS_v;

L_min=L_min_v;
L_max=L_max_v;


FRAME_SIZE_PATH='Results\';
I_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'IFrame_size.txt');

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

% disp(Transition_Matrix);
% % % fprintf('=====Transition Matrix\n');
% % % disp(A);

%test of the convergency
% S=A^250;
% disp(S);
% S=A^260;
% disp(S);

%========================================================
% To initiate the lifetime f(L)=\frac{\mu^L e^{-\mu}}{L!}
%========================================================
% lifetime=poissrnd(LIFETIME_MEAN, 1, NUMBER_OF_USERS);
% lifetime=[];
% for l_count=1:NUMBER_OF_USERS
%     lifetime=[lifetime LIFETIME_MEAN];
% end
% disp(l);


%========================================================
% Frame Size TEST DATA
%========================================================
Size_I=[];
Size_I=dlmread(I_Size_File);
% % % fprintf('=====I frame Size\n');
% % % disp(Size_I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%========================================================
% Redundant Frame Structure S
%========================================================
S_I=S_I_v;

%========================================================
% Storage Cost
%========================================================
% Stoarge cost of I-frame
B_S_I=0;
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        B_S_I=B_S_I+S_I(j,i)*Size_I(j,i);
    end
end

format long g;
B_S=B_S_I;

% % % % fprintf('=====Storage Cost\n');
% % % % disp(B_S);
% % % fprintf('I: %f W0: %f P: %f W1 %f\n',B_S_I,B_S_W0,B_S_P,B_S_W1);

%========================================================
% Server Transmission Cost
%========================================================
% Transmission cost
C_S=0;

for L=L_min:L_max   
    % Transmission of Walk Mode
    walk_mode=0;
    % Transmission of Jump Mode
    jump_mode=0;
%     disp(lifetime(1,count));


    for l=1:L
        for j=1:LIGHT_FIELD_SCALE
            for i=1:LIGHT_FIELD_SCALE

                Number=(j-1)*LIGHT_FIELD_SCALE+i;

                y=p_display(g,A,l,LIGHT_FIELD_SCALE);

                no_one_hop_probability=1;
                pr=0;
                % no predictor found
                np=no_one_hop_probability*Size_I(j,i);
                jump_mode=jump_mode+P_JUMP*y(j,i)*(pr+np);
                
                
            end
        end
    end
% % %     fprintf('=====Walk Cost\n');
% % %     disp(walk_mode);
% % %     fprintf('=====Jump Cost\n');
% % %     disp(jump_mode);
%     C_S=C_S+LIFETIME_MEAN^L*exp(-LIFETIME_MEAN)/factorial(L)*(walk_mode+jump_mode);
    C_S=C_S+(walk_mode+jump_mode)/L_max;
    
end

% fprintf('=====Transmission Cost Rate\n');
% disp(C_S);

LagrangianCost=C_S+lambda*B_S;
%test
% % % fprintf('=====Lagrangian Cost\n');
% % % disp(LagrangianCost);

y=[B_S C_S LagrangianCost];

end
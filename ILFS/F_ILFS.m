function y = F_ILFS( S_I_v, S_W0_v, S_P_v, S_W1_v, Scale, lambda_v, P_WALK_v, LIFETIME_MEAN_v, NUMBER_OF_USERS_v, L_min_v, L_max_v) 

% clear all;
% clc;
%===============================================
% Constants
%===============================================
LIGHT_FIELD_SCALE=Scale;
TOTAL_NUM=LIGHT_FIELD_SCALE*LIGHT_FIELD_SCALE;
lambda=lambda_v;

P_WALK=P_WALK_v;
P_JUMP=1-P_WALK;

LIFETIME_MEAN=LIFETIME_MEAN_v;
NUMBER_OF_USERS=NUMBER_OF_USERS_v;
L_min=L_min_v;
L_max=L_max_v;


FRAME_SIZE_PATH='Results\';
I_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'IFrame_size.txt');
W0_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'W0Frame_size.txt');
P_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'PFrame_size.txt');
W1_Size_File=sprintf('%s%s',FRAME_SIZE_PATH,'W1Frame_size.txt');


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
% Image Display Probabilites
%========================================================
p=[];
for j=1:LIGHT_FIELD_SCALE
    for j=1:LIGHT_FIELD_SCALE
        p(j,i)=0;
    end
end

% p=p_display(g,A,lifetime(count),LIGHT_FIELD_SCALE);

% fprintf('=====Image Display Probability\n');
% disp(p);


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
% % % fprintf('=====Image Caching Probability\n');
% % % disp(q);

%========================================================
% Frame Size TEST DATA
%========================================================
Size_I=[];
Size_I=dlmread(I_Size_File);
% % % fprintf('=====I frame Size\n');
% % % disp(Size_I);

Size_W0=[];
Size_W0=dlmread(W0_Size_File);
% % % fprintf('=====W0 frame Size\n');
% % % disp(Size_W0);

Size_P=[];
Size_P=dlmread(P_Size_File);
% % % fprintf('=====P frame Size\n');
% % % disp(Size_P);

Size_W1=[];
Size_W1=dlmread(W1_Size_File);
% % % fprintf('=====W1 frame Size\n');
% % % disp(Size_W1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%========================================================
% Redundant Frame Structure S
%========================================================
S_I=S_I_v;
S_W0=S_W0_v;
S_P=S_P_v;
S_W1=S_W1_v;

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

% Stoarge cost of W0-frame
B_S_W0=0;
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        B_S_W0=B_S_W0+S_W0(j,i)*Size_W0(j,i);
    end
end

% Stoarge cost of P-frame
B_S_P=0;
for j=1:TOTAL_NUM
    for i=1:TOTAL_NUM
        B_S_P=B_S_P+S_P(j,i)*Size_P(j,i);
    end
end

% Stoarge cost of W1-frame
Size_W1_compact=[];
for j=1:TOTAL_NUM
    W1_MAX=0;
    for i=1:TOTAL_NUM
        if (W1_MAX<Size_W1(j,i))&(S_W1(j,i)==1)
            W1_MAX=Size_W1(j,i);
        end
    end
    Size_W1_Compact(ceil(j/LIGHT_FIELD_SCALE),j-(ceil(j/LIGHT_FIELD_SCALE)-1)*LIGHT_FIELD_SCALE)=W1_MAX;
end

% % % fprintf('=====W1 frame Size Compact\n');
% % % disp(Size_W1_Compact);

B_S_W1=0;
for j=1:LIGHT_FIELD_SCALE
    for i=1:LIGHT_FIELD_SCALE
        B_S_W1=B_S_W1+Size_W1_Compact(j,i);
    end
end


format long g;
B_S=B_S_I+B_S_W0+B_S_P+B_S_W1;

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

                %To calculate the number of neighbors
                NumberOfNeighbors=0;
                TotalPSizeOfNeighbors=0;
                %Not in left board
                if mod(Number,LIGHT_FIELD_SCALE)~=1
                    NumberOfNeighbors=NumberOfNeighbors+1;
                    TotalPSizeOfNeighbors=TotalPSizeOfNeighbors+Size_P(j,i-1);
                end
                %Not in right board
                if mod(Number,LIGHT_FIELD_SCALE)~=0
                    NumberOfNeighbors=NumberOfNeighbors+1;
                    TotalPSizeOfNeighbors=TotalPSizeOfNeighbors+Size_P(j,i+1);
                end
                %Not in Upper Board
                if Number>(LIGHT_FIELD_SCALE)
                    NumberOfNeighbors=NumberOfNeighbors+1;
                    TotalPSizeOfNeighbors=TotalPSizeOfNeighbors+Size_P(j-1,i);
                end
                %Not in Down Board
                if Number<=(TOTAL_NUM-LIGHT_FIELD_SCALE)
                    NumberOfNeighbors=NumberOfNeighbors+1;
                    TotalPSizeOfNeighbors=TotalPSizeOfNeighbors+Size_P(j+1,i);
                end

                y=p_display(g,A,l,LIGHT_FIELD_SCALE);
                walk_mode=walk_mode+P_WALK*y(j,i)*(1-q(j,i))*(TotalPSizeOfNeighbors/NumberOfNeighbors+Size_W0(j,i));
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %****************************** P frame found one hop predictor
                One_Hop_Predictor=[];
                Num_Of_One_Hop_Predictor=0;
                for p_search=1:TOTAL_NUM
                    if (S_P(Number,p_search)==1)&(Number~=p_search+1)&(Number~=p_search-1)&(Number~=p_search-LIGHT_FIELD_SCALE)&(Number~=p_search+LIGHT_FIELD_SCALE)
                        One_Hop_Predictor=[One_Hop_Predictor p_search];
                        Num_Of_One_Hop_Predictor=Num_Of_One_Hop_Predictor+1;
                    end
                end
                
%                 fprintf('=====One Hop Predictor\n');
%                 disp(One_Hop_Predictor);
                
                % get frame size of P-frame
                One_Hop_Predictor_Size=[];
                for temp_one_hop=1:Num_Of_One_Hop_Predictor
                    One_Hop_Predictor_Size=[One_Hop_Predictor_Size Size_P(Number,One_Hop_Predictor(1,temp_one_hop))];
                end
                
%                 fprintf('=====One Hop Predictor Size\n');
%                 disp(One_Hop_Predictor_Size);
%                 fprintf('=====Number of One Hop Predictors\n');                
%                 disp(Num_Of_One_Hop_Predictor);
                
                if Num_Of_One_Hop_Predictor>1                    
                    %sort          
                    for sort_i=Num_Of_One_Hop_Predictor:-1:1
                        for sort_j=1:sort_i-1
                            if One_Hop_Predictor_Size(1,sort_j)>One_Hop_Predictor_Size(1,sort_j+1)
                                
                                temp=One_Hop_Predictor_Size(1,sort_j);
                                One_Hop_Predictor_Size(1,sort_j)=One_Hop_Predictor_Size(1,sort_j+1);
                                One_Hop_Predictor_Size(1,sort_j+1)=temp;
%                                 fprintf('=====%d vs. %d\n',One_Hop_Predictor_Size(1,sort_j),One_Hop_Predictor_Size(1,sort_j+1));
                                
                                temp1=One_Hop_Predictor(1,sort_j);
                                One_Hop_Predictor(1,sort_j)=One_Hop_Predictor(1,sort_j+1);
                                One_Hop_Predictor(1,sort_j+1)=temp1;
%                                 fprintf('=====%d vs. %d\n',One_Hop_Predictor(1,sort_j),One_Hop_Predictor(1,sort_j+1));
                            end
                        end   
                    end
                end
                
%                 fprintf('=====One Hop Predictor Sorted\n');
%                 disp(One_Hop_Predictor);
%                 
%                 fprintf('=====One Hop Predictor Size Sorted\n');
%                 disp(One_Hop_Predictor_Size);
%                 
                pr=0;
% 
                no_one_hop_probability=1;
                for temp_one_hop=1:Num_Of_One_Hop_Predictor
                    the_row=ceil(One_Hop_Predictor(1,temp_one_hop)/LIGHT_FIELD_SCALE);
                    the_col=One_Hop_Predictor(1,temp_one_hop)-(ceil(One_Hop_Predictor(1,temp_one_hop)/LIGHT_FIELD_SCALE)-1)*LIGHT_FIELD_SCALE;
                    pr=pr+no_one_hop_probability*q(the_row,the_col)*(Size_P(the_row,the_col)+Size_W0(j,i));
                    
                    no_one_hop_probability=no_one_hop_probability*(1-q(the_row,the_col));
%                     fprintf('******q = %f \n',q(the_row,the_col));
%                     fprintf('======np = %f \n',no_one_hop_probability);
                end   
                 
%                 fprintf('******%d******pr before add Pro: %f \n',Number, no_one_hop_probability);
%                 disp(pr);
                
                %***************************** W1 frame found one hop predictor
                One_Hop_Predictor_W1=[];
                Num_Of_One_Hop_Predictor_W1=0;
                for w1_search=1:TOTAL_NUM
                    if (S_W1(Number,w1_search)==1)&(Number~=w1_search+1)&(Number~=w1_search-1)&(Number~=w1_search-LIGHT_FIELD_SCALE)&(Number~=w1_search+LIGHT_FIELD_SCALE)
                        One_Hop_Predictor_W1=[One_Hop_Predictor_W1 w1_search];
                        Num_Of_One_Hop_Predictor_W1=Num_Of_One_Hop_Predictor_W1+1;
                    end
                end
                
%                 fprintf('=====(%d) One Hop Predictor W1\n',Number);
%                 disp(One_Hop_Predictor_W1);          
%                 
%                 fprintf('=====Frame Size of One Hop Predictor W1\n');
%                 disp(One_Hop_Predictor_Size_W1);                
%                 
                for temp_one_hop=1:Num_Of_One_Hop_Predictor_W1
                    %get frame size of W1-frame
                    the_row=ceil(One_Hop_Predictor_W1(1,temp_one_hop)/LIGHT_FIELD_SCALE);
                    the_col=One_Hop_Predictor_W1(1,temp_one_hop)-(ceil(One_Hop_Predictor_W1(1,temp_one_hop)/LIGHT_FIELD_SCALE)-1)*LIGHT_FIELD_SCALE;
                    pr=pr+no_one_hop_probability*q(the_row,the_col)*(Size_W1_Compact(j,i)+Size_W0(j,i));
                    no_one_hop_probability=no_one_hop_probability*(1-q(the_row,the_col));
                end   
                
                % no predictor found
                np=no_one_hop_probability*(Size_I(j,i)+Size_W0(j,i));
                
%                 fprintf('******%d******np before add Pro: %f\n',Number,no_one_hop_probability);
%                 disp(np);
                
                jump_mode=jump_mode+P_JUMP*y(j,i)*(1-q(j,i))*(pr+np);
            end
        end
    end
%     fprintf('=====Walk Cost\n');
%     disp(walk_mode);
%     fprintf('=====Jump Cost\n');
%     disp(jump_mode);
%     C_S=C_S+LIFETIME_MEAN^L*exp(-LIFETIME_MEAN)/factorial(L)*(walk_mode+jump_mode);
    C_S=C_S+(walk_mode+jump_mode)/L_max;
    
end

% % % % fprintf('=====Transmission Cost Rate\n');
% % % % disp(C_S);

LagrangianCost=C_S+lambda*B_S;
%test
% % % fprintf('=====Lagrangian Cost\n');
% % % disp(LagrangianCost);

y=[B_S C_S LagrangianCost];

end
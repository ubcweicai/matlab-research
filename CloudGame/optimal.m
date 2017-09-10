function y = optimal( G,P_intra,P_inter,N,INVALID )
%OPTIMAL Summary of this function goes here
%   Detailed explanation goes here

%%%disp('Optimal Cloud Encoding...');


%frame size for optimal encoding
s_optimal=0;

temp=size(G);

%number of groups
N_G=temp(1);
%length of each group
L_G=temp(2);

%disp(G);
%disp(N_G);
%disp(L_G);

for n=1:N_G

    %frame size for group
    s_optiaml_group=INVALID*INVALID;

    for l=1:L_G
        
        P_inter_t=P_inter;
        G_t=G;
        
        G_t_line=G_t(n,:);
        
        for j = 1 : N
            for k = 1 : N
                j_f=find(G_t_line==j);
                k_f=find(G_t_line==k);
                if((isempty(j_f))||(isempty(k_f)))
                    P_inter_t(j,k)=INVALID;
                end
            end
        end
       
        
        s_optimal_group_sub(l)=0;
        
        if(G_t(n,l)~=0)
            
            %encode the selected frame into intra-video P-frame
            s_optimal_group_sub(l)=P_intra(G_t(n,l));            
            P_inter_t(G_t(n,l),:)=INVALID;
            
            %disp('intra');
            %disp(s_optimal_group_sub(l));
            %disp(P_inter_t);
            
            P_inter_not_empty=0;
            
            %test if the P_inter is empty
            for j = 1: N
                for k = 1 : N
                    if(P_inter_t(j,k)~=INVALID)
                        P_inter_not_empty=1;
                    end
                end
            end
            
            
            while(P_inter_not_empty)
                
                P_inter_not_empty=0;
                
                %find out the largest P_inter frame remaining
                MAX_P=-1;
                for j = 1: N
                    for k = 1 : N

                        if((P_inter_t(j,k)~=INVALID)&&(P_inter_t(j,k)>MAX_P))
                            MAX_P=P_inter_t(j,k);
                            MAX_J=j;
                            MAX_K=k;
                        end
                        
                    end
                end

                if(MAX_P~=-1)
                    only_dependency=1;
                    for test=1:N
                        if((P_inter_t(MAX_J,test)~=INVALID)&&(test~=MAX_K))
                            only_dependency=0;
                        end
                    end


                    if(only_dependency==0)
                        %if the largest P_inter frame is not only dependency frame
                        P_inter_t(MAX_J,MAX_K)=INVALID;
                    else
                        %if the largest P_inter frame is the only dependency frame
                        s_optimal_group_sub(l)=s_optimal_group_sub(l)+P_inter_t(MAX_J,MAX_K);
                        P_inter_t(MAX_J,MAX_K)=INVALID;
                    end
                end
                
                %test if the P_inter is empty
                for j = 1: N
                    for k = 1 : N
                        if(P_inter_t(j,k)~=INVALID)
                            P_inter_not_empty=1;
                            %fprintf('not empty because:(%d,%d)\n',j,k);
                        end
                    end
                end
                
            end
            
        end
        
        %disp(s_optimal_group_sub(l));
        
        if((s_optimal_group_sub(l)~=0)&&(s_optimal_group_sub(l)<s_optiaml_group))
            s_optiaml_group=s_optimal_group_sub(l);
        end
        
    end
    
    %disp('minimum group result');
    %disp(s_optiaml_group);
    
    s_optimal=s_optimal+s_optiaml_group;
end

%disp('optimal');
%disp(s_optimal);
y=s_optimal;

end


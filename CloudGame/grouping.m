function y = grouping( P_inter,N,INVALID )
%GROUPING Summary of this function goes here
%   Detailed explanation goes here

%Grouping Algorithm
i = 0;
%disp(P_inter_backup);

G=[];

%test if the P_inter is empty
P_inter_empty=true;
for j = 1 : N    
    for k = 1 : N
        if(P_inter(j,k)~=INVALID)
            P_inter_empty=false;
        end
    end
end
    
while(~P_inter_empty)
       
    %disp('in loop');
        
	%test if the P_inter is empty
	P_inter_empty=true;
	for j = 1 : N
            
        if(P_inter_empty==false)
            break;
        end

        for k = 1 : N
            if(P_inter(j,k)~=INVALID)
                P_inter_empty=false;

                %for the valid candiate (j,k)
                
                i=i+1;
                s=1;
                %fprintf('(%d,%d)=%f\n',j,k,P_inter(j,k));
                P_inter(j,k)=INVALID;
                G(i,s)=j;
                s=s+1;
                G(i,s)=k;

                s_compare=s;
                s=s+1;

                while(s_compare~=s)
                    s_compare=s;
                    
                    for j_n = 1 : N
                        for k_n = 1 : N
                            if(P_inter(j_n,k_n)~=INVALID)

                                temp_G=G(i,:);
                                
                                p_1=find(temp_G==j_n);
                                if(~isempty(p_1))
                                    p_12=find(temp_G==k_n);
                                    if(isempty(p_12))
                                        G(i,s)=k_n;
                                        s=s+1;
                                    end
                                    P_inter(j_n,k_n)=INVALID;
                                end
                                    
                                p_2=find(temp_G==k_n);
                                if(~isempty(p_2))
                                    p_21=find(temp_G==j_n);
                                    if(isempty(p_21))
                                        G(i,s)=j_n;
                                        s=s+1;
                                    end
                                    P_inter(j_n,k_n)=INVALID;
                                end                                
                                
                            end
                        end
                    end
                    
                    
                end
                break;
            end
        end
    end
        
end

for add = 1: N
    
    find_add=0;
    for i_t=1:i
        temp_G=G(i_t,:);
        p=find(temp_G==add);
        if(~isempty(p))
            find_add=1;
        end
        
    end
    if(find_add==0)
        i=i+1;
        G(i,1)=add;
    end
end

%disp(G);

y=G;

end


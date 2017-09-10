function y = onehop( G,P_intra,P_inter,N,INVALID )
%ONEHOP Summary of this function goes here
%   Detailed explanation goes here

%%%disp('One Hop Cloud Encoding...');

%frame size for optimal encoding
s_onehop=0;

temp=size(G);

%number of groups
N_G=temp(1);
%length of each group
L_G=temp(2);

% disp(G);
% disp(N_G);
% disp(L_G);

for n=1:N_G
    
    P_inter_t=P_inter;
    G_line=G(n,:);
    
    %get the element of according group
    for j = 1 : N
        for k = 1 : N
            j_f=find(G_line==j);
            k_f=find(G_line==k);
            if((isempty(j_f))||(isempty(k_f)))
                P_inter_t(j,k)=INVALID;
            end
        end
    end
    
    %get statics of numbers of P_inter
    for k=1:N
        stat(k)=0;
    end

    for j=1:N
        for k=1:N

            if(P_inter_t(j,k)~=INVALID)
                stat(k)=stat(k)+1;
            end       
        end
    end

    %get the maximun be depended element
    p=-1;
    max=-1;
    for j=1:N
        if((stat(j)>max)&&(stat(j)~=0))
            max=stat(j);
            p=j;
        end
    end
    
    if(p==-1)
        s_onehop = s_onehop + P_intra(G_line(1));
        %%%fprintf('%d is encoded as intra P <%.2f>\n', G_line(1), P_intra(G_line(1)));
    end

    while(p~=-1)

        target=p;

        s_onehop = s_onehop + P_intra(target);
        %%%fprintf('%d is encoded as intra P <%.2f>\n', target, P_intra(target));
        P_inter_t(target,:)=INVALID;

        for j=1:N
            if(P_inter_t(j,target) ~= INVALID)
                %%%fprintf('%d -> %d  <%.2f>\n', j, target, P_inter_t(j,target));
                s_onehop = s_onehop + P_inter_t(j,target);
                P_inter_t(j,target) = INVALID;
                P_inter_t(j,:)=INVALID;
            end
        end


        for k=1:N
            stat(k)=0;
        end

        for j=1:N
            for k=1:N
                if(P_inter_t(j,k)~=INVALID)
                    stat(k)=stat(k)+1;
                end       
            end
        end

        %get the maximun be depended element
        p=-1;
        max=-1;
        for j=1:N
            if((stat(j)>max)&&(stat(j)~=0))
                max=stat(j);
                p=j;
            end
        end
        
        %fprintf('not empty because:(%d)\n',p);
        %disp(stat);
        %disp(P_inter_t);

    end

end
    
y=s_onehop;

end


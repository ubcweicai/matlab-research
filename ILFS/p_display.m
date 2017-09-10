function y = p_display( g, A, l, scale) 

TOTAL_NUM=scale*scale;

p_row = g*(A^l);

sum=0;
for count=1:TOTAL_NUM
    k(ceil(count/scale),count-(ceil(count/scale)-1)*scale)=p_row(count);
    sum=sum+p_row(count);
end

p_r=[];
for j=1:scale
    p_Temp=[];
    for i=1:scale
        p_Temp=[p_Temp k(j,i)];
    end
    p_r=[p_r; p_Temp];
end

y = p_r;

end
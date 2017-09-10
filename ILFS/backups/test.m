clc;

LIFETIME_MEAN=40;

L=[];
y=[];
sum=0;
for x=20:1:60
    L=[L x];
    y=[y LIFETIME_MEAN.^L.*exp(-LIFETIME_MEAN)/factorial(L)];
    sum=sum+LIFETIME_MEAN.^L.*exp(-LIFETIME_MEAN)/factorial(L);
end
disp(sum);
plot(L,y);
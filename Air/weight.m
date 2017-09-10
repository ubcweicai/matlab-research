function [ w ] = weight( A )
%WEIGHT Summary of this function goes here
%   Detailed explanation goes here

   [x,y]=eig(A);
   [m m]=find(y==max(max(y)));
   w=A(:,m)/sum(A(:,m));

end


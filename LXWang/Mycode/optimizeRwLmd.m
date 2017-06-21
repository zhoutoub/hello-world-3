function [lmd, totalR]=optimizeRwLmd(DatePrice,startI,endI)
%This funtion optimizes lmd given prices and date range
%DatePrice is an array, first column is date number, 6th column is adj
%close. Others are not used.
lmd=0.8:0.005:0.98;
[m, n]=size(lmd);
R=zeros(1,n);
for i=1:n
    
    R(i)=calcRwLmd(lmd(i),DatePrice,startI,endI);   
end
ind=find(max(R)==R,1);
lmd=lmd(ind);
totalR=R(ind);

    
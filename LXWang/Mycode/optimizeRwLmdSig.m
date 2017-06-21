function [lmdResult]=optimizeRwLmdSig(DatePrice,startI,endI,avgPxN,avgMoodN,bigR)
%This funtion optimizes lmd given prices and date range
%DatePrice is an array, first column is date number, 7th column is adj
%close, 9th is std. Others are not used.
%output index: 1 lamda, 2 mood return,3 bh return,4 # of buys,5 mood r/std, 6 bh
%r/std 7 min mood R 8 min BH R 9 c
lmd=0.8:0.01:0.98;
Nsig=0.5:0.25:1.5;
n=length(lmd);
m=length(Nsig);
%calcRwLmd2 output has 7 columns
R=ones(m*n,7);
for j=1:m
    for i=1:n  
        R(n*(j-1)+i,:)=calcRwLmdSig(lmd(i),DatePrice,startI,endI,Nsig(j),avgPxN,avgMoodN,bigR);   
    end
end
ind=find(max(R(:,1))==R(:,1),1);
indSig=ceil(ind/n);
indLmd=rem(ind,n);
if indLmd==0
    indLmd=n;
end
lmd=lmd(indLmd);
Nsig=Nsig(indSig);
result=R(ind,:);
lmdResult=[lmd,result,Nsig];


    
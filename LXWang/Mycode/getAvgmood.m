function [Ymood,Tmood]=getAvgmood(lmd,DatePrice,startI,endI,c,avgPxN,avgMoodN,bigR)
%This function returns the last two avgmood, and hold status.
[m ~]=size(DatePrice);
    if((m+endI)<1)
        Ymood=0;
        Tmood=0;
    else
        rawData(:,1)=DatePrice(max(1,m+startI):max(1:m+endI),1);
        rawData(:,6)=DatePrice(max(1,m+startI):max(1:m+endI),7);
        A=3;
        B=5;
        bigR=0.1;
        if B<(A+2)
            disp('B must be at least A+2');
        end

        c=0.01;
    %     lmd=0.94;
        [m ~]=size(rawData);
        l=25;
        res=zeros(m,l);
        %1 price
        res(:,1)=rawData(:,6);
        %2 log return
        res(2:end,2)=log(rawData(2:end,6)./rawData(1:end-1,6));
        %3 avg price

        for i=A+1:m
            res(i,3)=mean(res(i-A+1:i,1));
        end
        %4 log return of new price over avg price
        res(A+1:end,4)=log(res(A+1:end,1)./res(A+1:end,3));
        %5 to 15 , c is here 
        res(A,16:19)=[10 0 0 10];
        
        %i cannot go to m
        for i=A+1:m-1
            res(i,5)=meb(res(i,4),0,c,2*c);
            res(i,6)=meb(res(i,4),c,2*c,3*c);
            res(i,7)=meb(res(i,4),2*c,3*c,3*c);
            res(i,8)=meb(res(i,4),-2*c,-c,0);
            res(i,9)=meb(res(i,4),-3*c,-2*c,-c);
            res(i,10)=meb(res(i,4),-3*c,-3*c,-2*c);
            res(i,11)=meb(res(i,4),-c,0,c);
            res(i,12)=res(i,5)+res(i,6)+res(i,7)+res(i,11);
            res(i,13)=res(i,8)+res(i,9)+res(i,10)+res(i,11);
            if res(i,12)~=0
                res(i,14)=(0.1*res(i,5)+0.2*res(i,6)+0.4*res(i,7))/res(i,12);
            end
            if res(i,13)~=0
                res(i,15)=(0.1*res(i,8)+0.2*res(i,9)+0.4*res(i,10))/res(i,13);
            end
            %21 22 K
            res(i,22:23)=([res(i-1,16:17);res(i-1,18:19)]*res(i,14:15)'/(res(i,14:15)*[res(i-1,16:17);res(i-1,18:19)]*res(i,14:15)'+lmd))';
            %20 21 a, a counts on r(t+1), so i stops at m-1
            res(i,20:21)=res(i-1,20:21)+res(i,22:23)*(res(i+1,2)-res(i,14:15)*res(i-1,20:21)');
            
            if((i+1<=m)&&(res(i+1,2)>=bigR))
               res(i,20:21)=res(i-1, 20:21);
            end
            %16 to 19 P
            tempP=[res(i-1,16:17);res(i-1,18:19)];
            tempP=([1 0;0 1]-res(i,22:23)'*res(i,14:15))*tempP/lmd;
            res(i,16:17)=tempP(1,:);
            res(i,18:19)=tempP(2,:);
            %24 mood. If mood>0, buyer exists
            res(i,24)=res(i,20)+res(i,21);   
        end
        %25 avgmood, adjust for smoother mood
        for i=B:m
            res(i,25)=mean(res(i-B+1:i,24));
        end
        Ymood=res(end-2,25);
        Tmood=res(end-1,25);
        % note, the last row has a lot of unpopulated numbers, cannot be
        % used, a1 and a2 relies on latest close price, so is mood.
    end
end
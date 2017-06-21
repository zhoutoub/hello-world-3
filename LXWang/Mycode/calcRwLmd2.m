function resultArr=calcRwLmd2(lmd,DatePrice,startI,endI,c,avgPxN,avgMoodN,bigR)
%this function takes lmd as an input, and will be used in other function to
%optimize lmd, totalR is the final R of mood;bnhR is the final R for buy
%and hold;nb is the transaction times;RoSM is the mood return over standard
%deviation; ROSBH is the buy and hold return over standard deviation
%startI and endI 指离最大指标有多远，比如过去一年就输入-251,-1

%resultArr=[totalR,bnhR,nb,RoSM,RoSBH,minMR,minBR];
    [m ~]=size(DatePrice);
    %This make sure some data will be generated, but not perfect. if no
    %data is available, should return 0
    if((m+endI)<1)
        totalR=1;
        bnhR=1;
        nb=0;
        RoSM=0;
        RoSBH=0;
        minMR=0;
        minBR=0;
    else
        rawData(:,1)=DatePrice(max(1,m+startI):max(1:m+endI),1);
        
        %%%%bad coding, shift a column
        rawData(:,6)=DatePrice(max(1,m+startI):max(1:m+endI),7);
        A=avgPxN;
        B=avgMoodN;
        %ignore big move
        %bigR=0.1;
        if B<(A+2)
            disp('B must be at least A+2');
        end

        %c=0.01;
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
            if(res(i+1,2)>=bigR)
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

        %this is to make sure the function doesnt fail if there is no buy
        %signal at all
        if max(res(1:m-1,25))<=0
            nb=0;
            totalR=1;
            RoSM=1;
            minMR=1;
        else
            %%below is execution part
            ho=0;nb=0;ns=0;
            %j also stops at m-1
            for j=B:m-1
                if res(j,25)>0 && ho==0
                    nb=nb+1;
                    %buy records the buy indication index in res, the next data is the
                    %entry point
                    buy(nb)=j+1;
                    %ho is holding position
                    ho=1;
                end;
                %when holding position and mood is negative, sell
                if res(j,25)<0 && ho==1
                    ns=ns+1;
                    %sell records the sell indication index, j+1 is the next available
                    %price for entry point
                    sel(ns)=j+1;
                    ho=0;
                end;
            end;

            if nb>ns
                sel(nb)=m;
            end;
            resRet2=ones(nb,1);
            resRet=ones(m,1);
            j=1;
            for i=B:m-1
                    if i>=buy(j)&&i<sel(j)
                        resRet(i+1)=res(i+1,1)/res(i,1)*resRet(i);
                    else
                        resRet(i+1)=resRet(i);
                    end
                    if i==sel(j)
                        j=min(j+1,nb);
                    end
            end
            for i=1:nb
                resRet2(i)=res(sel(i),1)/res(buy(i),1);
            end            
            %dates=zeros(m,1);
        %     for i=1:m
        %     dates(i)=datenum(Date{i,1},'mm/dd/yyyy');
        %     end
            totalR=resRet(end);
            RoSM=totalR/std(resRet);
            minMR=min(resRet);
        end
        bnhRet=res(:,1)./res(1,1);
        bnhR=bnhRet(end);
        RoSBH=bnhR/std(bnhRet);
        minBR=min(bnhRet);
    end
    resultArr=[totalR,bnhR,nb,RoSM,RoSBH,minMR,minBR];
end




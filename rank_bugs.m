function [d]=rank_bugs(stage,mdistpgAll,galId,pId)
% aprob=sscanf(probe, '%c', 5);
% apro=str2num(aprob);
%  for i=1:48
%     agal=sscanf(gallary{i}, '%c', 5); 
%     aga(i)=str2num(agal);
%  enda
% ag=aga';
[numGalIds y] = size(galId);
c=1; d=zeros(numGalIds*stage,1);
for i=1:stage  %%%%%%%Stage
    [minimum, I]=sort(mdistpgAll(:,i));
%     for j=1:5
%      gal{j}=gallary(I(j));   
%     end
%      l=0;
    for k=1:numGalIds   %%%%%%%Rank
        for m=1:k
            gal(m)=galId(I(m));
        end
        l=find(gal==pId);
        if(l>0)
            s=1;
            l=[];
        else
            s=0;
        end
%         l=[];
        d(c)=s;
        c=c+1;gal=[];
    end
    
end


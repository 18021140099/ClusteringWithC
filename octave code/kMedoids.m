function [Medoids,clusvector,DIST]=kMedoids(M,N)


[points,dim]=size(M);

%  disp('calculating distances');
 DIST=zeros(points, points);
    for i=1:points-1
        for j=i+1:points 
          DIST(i,j)=minkowskiDist(M(i,:),M(j,:),2);
          DIST(j,i)=DIST(i,j);
     	end
    end

%compute medoids

Medoids=[];
sumdist=sum(DIST);
[Min Medoids(1)]=min(sumdist);

for k=2:N
   notselected=setdiff([1:points],Medoids);
   Cj=zeros(points,1);
   for i=notselected             
      for j=notselected(find(notselected~=i))
     % for j=not yet selected
         Dj=min( DIST(j,Medoids) );
         dij=DIST(j,i);
         Cj(i)=Cj(i)+max([Dj-dij 0]);
      end
   end
   [Max Medoids(k)]=max(Cj); %selected ones have score zero 
end                          

%do swap
notselected=setdiff([1:points],Medoids);
ns=points-N;  %=length(notselected);

minT=-1;
T=zeros(N,ns);
iter=0;
 sumD=[];
while (minT<0 && iter<=20)
   
for i=Medoids 
   for h=notselected
      Cjih=0;
      for j=union(notselected,i)    %All the notselected objects IF the swap is carried out+the gain that the newly selected object has
         Dj=min( DIST(j,Medoids) );
         dij=DIST(j,i);
         dhj=DIST(j,h);
         if Dj==dij
            Ej=min( DIST(j,Medoids(find(Medoids~=i)) ));
            if dhj<Ej
               Cjih=Cjih + dhj-dij;
            else 
               Cjih=Cjih + Ej-Dj;
            end
         elseif Dj>dhj
            Cjih=Cjih + dhj-Dj;
         end
      end
      T(find(Medoids==i),find(notselected==h))=Cjih;
   end
end
[minT,Ind]=min(T(:));
if minT<0
   colh=ceil(Ind/N);
   rowi=Ind-(colh-1)*N;
   i=Medoids(rowi);
   Medoids(rowi)=notselected(colh);
   notselected(colh)=i;
end
iter=iter+1;
 sumiter=0;

 for j=notselected
    sumiter =sumiter+min( DIST(j,Medoids) );
 end

 sumD=[sumD sumiter];
end

clusvector=zeros(points,1);

for i=Medoids
   clusvector(i,1)=find(Medoids==i);
end
for j=notselected
   [Dj Ind]=min( DIST(j,Medoids) );
   clusvector(j,1)=Ind;
end

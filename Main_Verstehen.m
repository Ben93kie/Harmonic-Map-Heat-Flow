clear all

%[c4n,n4e,Db,Nb] = triang_cube(2); c4n = c4n-.5;
[a,b,c,d]=Gebietsdefiniton([0,0],1);
%b=c4n;
old=a;
gold=b;
   for j = 1:6
       [a,b,c,d] = red_refine(a,b,c,d);
   end
  
 [c4n1,n4e1]=Verfeinerung(old,gold,1/4);
 %[Q,M]=MatrixAssembly2DBenni(b,n4e);
% [Q1,M1]=MatrixAssembly2DBenni(c4n1,n4e1);
 [eins,zwei,~,~]=fe_matrices(a,b);
Haha=Steifigkeitsmatrix(c4n1,n4e1);
Zaza=Massematrix(c4n1,n4e1);


 
         
 [ois,zwoi,~,~]=fe_matrices(c4n1,n4e1);
 A=full(ois);
 B=full(eins);
[L,U]=lu(A);
erstens=sum(A(:));
 zweitens=sum(B(:));
 
 
 
% [one,two,~,~]=fe_matrices(c4n1,n4e1);
% A=full(eins);
% B=full(one);
% [a,b,c,d]=triang_cube(2);
% [u,i,ll,kkk]=Gebietsdefinition([-1,-1],1);
% 
% 
% [ert,zt]=Verfeinerung(u,i,2^-5);
% 
% 
%  [v,y,n,m]=red_refine(a,b,c,d);
%  
%  [oo,s,f,g]=red_refine(v,y,n,m);
%  [o,l,j,p]=red_refine(oo,s,f,g);
%  [q,s,w,d]=red_refine(o,l,j,p);
% %[a,b,c,d]=Gebietsdefiniton([0.5,0.5],1);
% [e,f,g,h]=red_refine(q,s,w,d);
% 
% % % 
%  mesh(c4n1(:,1),c4n1(:,2),ones(length(c4n1)))
%  
%   hold on
%   mesh(b(:,1),b(:,2),zeros(length(b)))
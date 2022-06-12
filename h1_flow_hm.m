function [zaehler,norm1,r,u]= h1_flow_hm(d,red)
[c4n,n4e,Db,Nb] = triang_cube(d); Db = [Db;Nb]; c4n = c4n-.5;
zaehler=0;
norm1=0;
for j = 1:red
    [c4n,n4e,Db,Nb,~,~] = red_refine(c4n,n4e,Db,Nb);
end
theta = 1; tau = 2^(-red); eps_stop = tau; nC = size(c4n,1); 
dNodes = unique(Db); fNodes = setdiff(1:nC,dNodes);
FNodes = [3*fNodes-2,3*fNodes-1,3*fNodes-0];
nDb = size(dNodes,1); nF = size(fNodes,2);
[s,~,~,~] = fe_matrices(c4n,n4e); SSS = sparse(3*nC,3*nC);
for k = 1:3  
    idx = k:3:3*nC; SSS(idx,idx) = s; 
end
u = zeros(3*nC,1);
for j = 1:nC
    u(3*j-[2,1,0]) = u_0(c4n(j,:));
end
for j = 1:nDb
    u(3*dNodes(j)-[2,1,0]) = u_D(c4n(dNodes(j),:));
end
Flist = [FNodes,3*nC+fNodes];
norm_corr = 1;
while norm_corr > eps_stop
    norm1=0;
    B = sparse(nC,3*nC); 
    for j = 1:nC
        B(j,3*j-[2,1,0]) = u(3*j-[2,1,0])';
    end
    X = [SSS,B';B,sparse(nC,nC)];
    b = [-(1+theta*tau)^(-1)*SSS*u;zeros(nC,1)];
    x = X(Flist,Flist)\b(Flist);
    v = zeros(3*nC,1);
    v(FNodes) = x(1:3*nF); tu = u+tau*v;
    norm_corr = sqrt(v'*SSS*v);
    for j = 1:nC
        u(3*j-[2,1,0]) = tu(3*j-[2,1,0]);%/norm(tu(3*j-[2,1,0]));
        
    end
    r=u;
     u = tu;
     
    
     
    %show_p1_field(c4n,u); axis square; view(30,30); drawnow;
end
for j=1:length(n4e)
norm1=norm1+(tau^2)/2*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
end
function val = u_D(x)
val = [x/norm(x),zeros(1,3-size(x,2))];

function val = u_0(x)
val_tmp = rand(1,3)-.5;
val = val_tmp/norm(val_tmp);

function show_p1_field(c4n,u)
[nC,d] = size(c4n); X = [c4n,zeros(nC,3-d)];
quiver3(X(:,1),X(:,2),X(:,3),u(1:3:3*nC),u(2:3:3*nC),u(3:3:3*nC));

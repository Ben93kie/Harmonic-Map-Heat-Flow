function [norm2,n4e,losung,s,m,zweinorm,einsnorm] = wave_maps_Original(d,red)
[c4n,n4e,Db,Nb] = triang_cube1(d); c4n = c4n-.5;
T = 1;

tau = 2^(-red); K = ceil(T/tau);
norm2=zeros(K+1,1);


for j = 1:red
    [c4n,n4e,Db,Nb] = red_refine(c4n,n4e,Db,Nb);
    
end
nC = size(c4n,1);
losung=zeros(3*nC,K);
[s,m,~,~] = fe_matrices(c4n,n4e);
SSS = sparse(3*nC,3*nC); MMM = sparse(3*nC,3*nC); 
for k = 1 : 3  
    idx = k:3:3*nC; SSS(idx,idx) = s; MMM(idx,idx) = m;
end
u = zeros(3*nC,1); v = zeros(3*nC,1);
for j = 1:nC
    u(3*j-[2,1,0]) = u_0(c4n(j,:));
    v(3*j-[2,1,0]) = v_0(c4n(j,:));
end

 for j=1:length(n4e)
 norm2(1)=norm2(1)+(tau^2)/4*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                         +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                         +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
 end
 
 
unorm=zeros(nC,1);
zweinorm=zeros(K+1,1);
for j=1:length(u)/3
    unorm(j)=norm(u(3*j-[2,1,0]))^2-1;
end
zweinorm(1)=unorm'*m*unorm;
einsnorm(1)=ones(nC,1)'*m*abs(unorm);
zweinorm(1)=sqrt(zweinorm(1));


for k = 1:K
    B = sparse(nC,3*nC);
    for j = 1:nC
        B(j,3*j-[2,1,0]) = u(3*j-[2,1,0]);
    end
    X = [MMM+tau^2*SSS,B';B,sparse(nC,nC)];
    b = [MMM*v-tau*SSS*u;zeros(nC,1)];
    x = X\b;
    v = x(1:3*nC); 
    tu = u+tau*v;
    for j = 1:nC
        u(3*j-[2,1,0]) = tu(3*j-[2,1,0]);%/norm(tu(3*j-[2,1,0]));
    end
%      show_p1_field(c4n,u); axis(.5*[-1,1,-1,1,-1,1]); 
%      view(30,18); drawnow; pause(.05)

 for j=1:length(n4e)
 norm2(k+1)=norm2(k+1)+(1/2)*(tau^2)*(1/3)*(abs(norm(tu(3*n4e(j,1)-[2,1,0]))^2-1)...
                                         +abs(norm(tu(3*n4e(j,2)-[2,1,0]))^2-1)...
                                         +abs(norm(tu(3*n4e(j,3)-[2,1,0]))^2-1));
 end
 
 for j=1:nC
    unorm(j)=norm(u(3*j-[2,1,0]))^2-1;
end
zweinorm(k+1)=unorm'*m*unorm;
einsnorm(k+1)=ones(nC,1)'*m*abs(unorm);
zweinorm(k+1)=sqrt(zweinorm(k+1));
     

    
    
end

function val = u_0(x)
d = size(x,2);
x = [x,zeros(1,3-d)];
r = norm(x); a = max(0,1-2*r)^4;
val = [2*a*x(1:2),a^2-r^2 ]/(a^2+r^2);


function val = v_0(x)
val = [0,0,0];

function [u,neuenorm,c4n,n4e,s,m,SSS,MMM,zweinorm,unorm,einsnorm]= WaermeleitungTest(d,red)
[c4n,n4e,Db,Nb] = triang_cube1(d); c4n = c4n-.5;
T = 1;


tau = 2^(-red); K = ceil(T/tau);
Schrittweite=2^(-6);
neuenorm=zeros(K+1,1);
%    for j = 1:red
%        [c4n,n4e,Db,Nb] = red_refine(c4n,n4e,Db,Nb);
%    end
for j = 1:red
    [c4n,n4e,Db,Nb] = red_refine(c4n,n4e,Db,Nb);
    
end

nC = size(c4n,1);
%[s,m,~,~] = fe_matrices(c4n,n4e);
[s,m,~,~] = fe_matrices(c4n,n4e);
SSS = sparse(3*nC,3*nC); MMM = sparse(3*nC,3*nC); 
for k = 1 : 3  
    idx = k:3:3*nC; SSS(idx,idx) = s; MMM(idx,idx) = m;
end

u = zeros(3*nC,1); 

for j = 1:nC
    u(3*j-[2,1,0]) = u_0(c4n(j,:));
end


for j=1:length(n4e)
neuenorm(1)=neuenorm(1)+(1/2)*(Schrittweite^2)*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
end
unorm=zeros(nC,1);
zweinorm=zeros(K+1,1);
for j=1:length(u)/3
    unorm(j)=norm(u(3*j-[2,1,0]))-1;
end
zweinorm(1)=unorm'*m*unorm;
zweinorm(1)=sqrt(zweinorm(1));
einsnorm(1)=ones(nC,1)'*m*abs(unorm);
for k = 1:K
    B = sparse(nC,3*nC);
    for j = 1:nC
        B(j,3*j-[2,1,0]) = u(3*j-[2,1,0]);
    end
    X = [MMM+tau*SSS,B';B,sparse(nC,nC)];
    b = [-SSS*u;zeros(nC,1)];
    x = X\b;
    v = x(1:3*nC); 
    u = u+tau*v;
%     for j = 1:nC
%         u(3*j-[2,1,0]) = tu(3*j-[2,1,0]);%/norm(tu(3*j-[2,1,0]));
%        
%     end
%     show_p1_field(c4n,u); axis(.5*[-1,1,-1,1,-0.05,0.05]); 
%     view(30,18); drawnow; pause(.0005)
    
  
    for j=1:length(n4e)
   neuenorm(k+1)=neuenorm(k+1)+(Schrittweite^2)/2*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
                                 
    end
    
    for j=1:nC
    unorm(j)=norm(u(3*j-[2,1,0]))-1;
end
zweinorm(k+1)=unorm'*m*unorm;
zweinorm(k+1)=sqrt(zweinorm(k+1));
einsnorm(k+1)=ones(nC,1)'*m*abs(unorm);

    
end

function val = u_0(x)
if x==0
    val=[0,0,1];
else
d = size(x,2);
x = [x,zeros(1,3-d)];
r = norm(x); phi = (3*pi/2)*min(4*r^2,1);

%val = [sin(phi)*x(1:2),cos(phi)*r]/(r);
% function val =u_0(x)
val=(1/r)*[x(1)*sin(phi),x(2)*sin(phi),r*cos(phi)]';
end
% 
% function val = v_0(x)
% val = [0,0,0];

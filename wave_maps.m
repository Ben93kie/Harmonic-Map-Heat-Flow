function [u,norm1,r,norm2,tu,norm3,neuenorm,c4n,n4e,Db,Nb]= wave_maps(d,red)
[c4n,n4e,Db,Nb] = triang_cube1(d); c4n = c4n-.5;
T = 1;


tau = 2^(-red); K = ceil(T/tau);
norm1=zeros(K+1,1);
norm2=zeros(K,1);
norm3=zeros(K,1);
neuenorm=zeros(K+1,1);
for j = 1:red
    [c4n,n4e,Db,Nb] = red_refine1(c4n,n4e,Db,Nb);
end

nC = size(c4n,1);
[s,m,~,~] = fe_matrices(c4n,n4e);
SSS = sparse(3*nC,3*nC); MMM = sparse(3*nC,3*nC); 
for k = 1 : 3  
    idx = k:3:3*nC; SSS(idx,idx) = s; MMM(idx,idx) = m;
end
u = zeros(3*nC,1); v = zeros(3*nC,1);
r = zeros(3*nC,1);
for j = 1:nC
    u(3*j-[2,1,0]) = u_0(c4n(j,:));
 %   v(3*j-[2,1,0]) = v_0(c4n(j,:));
    
end

r=u;
for j=1:length(n4e)
neuenorm(1)=neuenorm(1)+(1/2)*(tau^2)*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
end
% for j=1:length(n4e)
%     norm1(1)=norm1(1)+tau^2/2*1/3*(abs(u(3*n4e(j,1)-2)^2+u(3*n4e(j,1)-1)^2+u(3*n4e(j,1))^2-1)...
%                                   +abs(u(3*n4e(j,2)-2)^2+u(3*n4e(j,2)-1)^2+u(3*n4e(j,2))^2-1)...
%                                   +abs(u(3*n4e(j,3)-2)^2+u(3*n4e(j,3)-1)^2+u(3*n4e(j,3))^2-1));
% end
for k = 1:K
    B = sparse(nC,3*nC);
    for j = 1:nC
        B(j,3*j-[2,1,0]) = u(3*j-[2,1,0]);
    end
    X = [MMM+tau*SSS,B';B,sparse(nC,nC)];
    b = [-SSS*u;zeros(nC,1)];
    x = X\b;
    v = x(1:3*nC); 
    tu = u+tau*v;
    for j = 1:nC
        u(3*j-[2,1,0]) = tu(3*j-[2,1,0]);%/norm(tu(3*j-[2,1,0]));
       % r(3*j-[2,1,0]) = u(3*j-[2,1,0]);
    end
    %show_p1_field(c4n,u); axis(.5*[-1,1,-1,1,-1,1]); 
    %view(30,18); drawnow; %pause(.0005)
    
%     for p=1:nC
%     %norm1(k)=norm1(k)+tau*abs(norm(u(3*p-[2,1,0]))^2-1);
%     norm2(k)=norm2(k)+tau^2*abs(norm(tu(3*p-[2,1,0]))^2-1);
%     norm3(k)=norm3(k)+tau^2*norm(tu(3*p-[2,1,0]))^2;
%     end
%     norm3(k)=norm3(k)-1;
  
    for j=1:length(n4e)
   neuenorm(k+1)=neuenorm(k+1)+(tau^2)/2*(1/3)*(abs(norm(u(3*n4e(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*n4e(j,3)-[2,1,0]))^2-1));
                                 % tu(3*n4e(j,1)-[2,1,0])
    end
%     for j=1:nC
%     norm1(k+1)=norm1(k+1)+tau^2/2*abs(norm(tu(3*j-[2,1,0]))^2-1);
% 
% %     +tau^2/2*1/3*(abs(tu(3*n4e(j,1)-2)^2+tu(3*n4e(j,1)-1)^2+tu(3*n4e(j,1))^2-1)...
% %                                   +abs(tu(3*n4e(j,2)-2)^2+tu(3*n4e(j,2)-1)^2+tu(3*n4e(j,2))^2-1)...
% %                                   +abs(tu(3*n4e(j,3)-2)^2+tu(3*n4e(j,3)-1)^2+tu(3*n4e(j,3))^2-1));
% end
    
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

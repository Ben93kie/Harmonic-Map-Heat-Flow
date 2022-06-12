function [u,neuenorm,Knoten,Elemente]= Waermeleitung(h,T)
[Knoten,Elemente] = Gebietsdefinition([0,0],1); 



tau = 2^(-h); K = ceil(T/tau);
Schrittweite=2^(-4);
neuenorm=zeros(K+1,1);

[Knoten,Elemente]=Verfeinerung(Knoten,Elemente,Schrittweite);

nC = size(Knoten,1);


s=Steifigkeitsmatrix(Knoten,Elemente);
m=Massematrix(Knoten,Elemente);
SSS = sparse(3*nC,3*nC); MMM = sparse(3*nC,3*nC); 
for k = 1 : 3  
    idx = k:3:3*nC; SSS(idx,idx) = s; MMM(idx,idx) = m;
end

u = zeros(3*nC,1); 

for j = 1:nC
    u(3*j-[2,1,0]) = u_0(Knoten(j,:));
end


for j=1:length(Elemente)
neuenorm(1)=neuenorm(1)+(1/2)*(Schrittweite^2)*(1/3)*(abs(norm(u(3*Elemente(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,3)-[2,1,0]))^2-1));
end

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

  
    for j=1:length(Elemente)
   neuenorm(k+1)=neuenorm(k+1)+(abs(norm(u(3*Elemente(j,1)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,2)-[2,1,0]))^2-1)...
                                        +abs(norm(u(3*Elemente(j,3)-[2,1,0]))^2-1));
                                 
    end
    neuenorm(k+1)=neuenorm(k+1)*(Schrittweite^2)/2*(1/3);
    
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

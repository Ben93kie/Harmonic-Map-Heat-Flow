function p1_theta_heat(d,red)
T = 10; theta = 1/2; alpha = 1;
[c4n,n4e,Db,Nb] = triang_cube(d); 
for j = 1:red
    [c4n,n4e,Db,Nb,Pr0,Pr1] = red_refine(c4n,n4e,Db,Nb);
end
nC = size(c4n,1); 
dNodes = unique(Db); fNodes = setdiff(1:nC,dNodes);
h = 2^(-red); tau = h^alpha/4; K = floor(T/tau);
u_old = u_0(c4n)-u_D(0,c4n); u_new = zeros(nC,1);
[s,m,m_lumped,vol_T] = fe_matrices(c4n,n4e);
[m_Nb,m_Nb_lumped] = fe_matrices_bdy(c4n,Nb);
for k = 1:K
    t_k = k*tau; t_k_theta = (k-1+theta)*tau;
    dt_u_D = (1/tau)*(u_D(t_k,c4n)-u_D(t_k-tau,c4n));
    u_D_k_theta = theta*u_D(t_k,c4n)+(1-theta)*u_D(t_k-tau,c4n);
    b = (1/tau)*m*u_old-m*dt_u_D...
        -s*u_D_k_theta-(1-theta)*s*u_old...
        +m*f(t_k_theta,c4n)+m_Nb*g(t_k_theta,c4n);
    X = (1/tau)*m+theta*s;    
    u_new(fNodes) = X(fNodes,fNodes)\b(fNodes);
    show_p1(c4n,n4e,Db,Nb,u_new+u_D(t_k,c4n)); drawnow;
    u_old = u_new;
end

function val = f(t,x); val = ones(size(x,1),1);
function val = u_0(x); val = sin(2*pi*x(:,1)); 
function val = u_D(t,x); val = min(t,.2)*sin(2*pi*x(:,1));
function val = g(t,x); val = zeros(size(x,1),1);
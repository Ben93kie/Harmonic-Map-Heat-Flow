function [m_bdy,m_lumped_bdy] = fe_matrices_bdy(c4n,bdy)
[nC,d] = size(c4n); n_bdy = size(bdy,1);
M_loc_bdy = (eye(d)+ones(d,d))/((d+1)*d);    
ctr = 0; ctr_max = d^2*n_bdy;
I = zeros(ctr_max,1); J = zeros(ctr_max,1); 
X_m_bdy = zeros(ctr_max,1); 
m_lumped_bdy_diag = zeros(nC,1);
for j = 1:n_bdy
    if d == 1
        vol_S = 1;
    elseif d == 2
        vol_S = sqrt(sum((c4n(bdy(j,2),:)-c4n(bdy(j,1),:)).^2,2));
    elseif d == 3
        vol_S = sqrt(sum(cross(c4n(bdy(j,3),:)-c4n(bdy(j,1),:),...
            c4n(bdy(j,2),:)-c4n(bdy(j,1),:)).^2,2))/2;
    end
    for m = 1:d
        for n = 1:d
            ctr = ctr+1; I(ctr) = bdy(j,m); J(ctr) = bdy(j,n);
            X_m_bdy(ctr) = vol_S*M_loc_bdy(m,n);
         end
         m_lumped_bdy_diag(bdy(j,m)) = ...
             m_lumped_bdy_diag(bdy(j,m))+vol_S/d;
    end
end
m_bdy = sparse(I,J,X_m_bdy,nC,nC); 
m_lumped_bdy = diag(m_lumped_bdy_diag);

function show_p1_field(c4n,u)
[nC,d] = size(c4n); 
X = [c4n,zeros(nC,3-d)];
quiver3(X(:,1),X(:,2),X(:,3),u(1:3:3*nC),u(2:3:3*nC),u(3:3:3*nC));
drawnow;
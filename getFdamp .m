function [Fdamp,Jdamp] = getFdamp(u,nv)
%%
global   voronoiRefLen

for c=1:nv-1
    L_k(4*(c-1)+1,1)=voronoiRefLen(c);
    L_k(4*(c-1)+2,1)=voronoiRefLen(c);
    L_k(4*(c-1)+3,1)=voronoiRefLen(c);
    L_k(4*(c-1)+4,1)=voronoiRefLen(c);
end
    c=nv;
    L_k(4*(c-1)+1,1)=voronoiRefLen(c);
    L_k(4*(c-1)+2,1)=voronoiRefLen(c);
    L_k(4*(c-1)+3,1)=voronoiRefLen(c);
Fdamp = -L_k.*u;
Jdamp = -diag(L_k);

end

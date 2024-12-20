function [Jdamp] = getJdamp(u)
%%
global  nv ne voronoiRefLen

for c=1:ne
    lens(4*(c-1)+1,1)=voronoiRefLen(c);
    lens(4*(c-1)+2,1)=voronoiRefLen(c);
    lens(4*(c-1)+3,1)=voronoiRefLen(c);
    lens(4*(c-1)+4,1)=0;%voronoiRefLen(c);
end
    lens(4*(nv-1)+1,1)=voronoiRefLen(end);
    lens(4*(nv-1)+2,1)=voronoiRefLen(end);
    lens(4*(nv-1)+3,1)=voronoiRefLen(end);
%length(lens);
Jdamp = -eye(length(lens),length(lens));

end

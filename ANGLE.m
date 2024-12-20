function [data, y] = ANGLE(prob, data, u)


cs=[0 0 1]*u;
cs=cs/norm(u);

y=acos(cs)*180/pi;

end
    
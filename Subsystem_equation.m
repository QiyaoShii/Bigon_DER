function [F,m1,m2,refTIter] = Subsystem_equation( S, d1, pre_S0, refT, refLen, voronoiRefLen, kappaBar, ne,EA,EI1,EI2,GJ)  

%% equation
   
    % Update directors & get reference twist
    tangent = computeTangent(S);
    [d1Iter, d2Iter] = computeTimeParallel(d1, pre_S0, S);
    refTIter = getRefTwist(d1Iter, tangent, refT); 
    theta = S(4:4:end);
    [m1, m2] = computeMaterialDirectors(d1Iter, d2Iter, theta);

    % Get forces
    Es= Es_Grad_Hess(ne,refLen, EA);
    Fs = GetFs(Es,S);
    
    Et = Et_Grad_Hess(ne,voronoiRefLen,GJ);
    Ft = GetFt(Et,S,refTIter);

    Eb=Eb_Grad_Hess(ne,voronoiRefLen, kappaBar ,EI1,EI2);
    Fb = GetFb(Eb,S, m1, m2);
    
    F = Fs + Ft + Fb;

end


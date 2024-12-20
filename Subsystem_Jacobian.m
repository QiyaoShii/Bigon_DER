function Jacobian = Subsystem_Jacobian( S, m1, m2, refTIter, refLen, voronoiRefLen, kappaBar, ne,EA, EI1, EI2,GJ)  

%% equation
 % Get Jacobian
    Es= Es_Grad_Hess(ne,refLen, EA);
    Js = GetJs(Es,S);

    Et = Et_Grad_Hess(ne,voronoiRefLen,GJ);
    Jt = GetJt(Et,S,refTIter);

    E_b=Eb_Grad_Hess(ne,voronoiRefLen, kappaBar ,EI1,EI2);
    Jb = GetJb(E_b,S, m1, m2);
    
    Jacobian = Js + Jt + Jb;
    
end
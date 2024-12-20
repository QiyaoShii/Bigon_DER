function DOF=Bigon_Initial_Solution(N_Seg)

    natR=1/pi;
 
    
    nv=N_Seg+1+1;
    Nodes = cell(2,1);

for i= 1:2
    Nodes{i} = zeros(N_Seg+1+1,3);
end

UPcircle_Nodes =zeros(N_Seg+1 + 1,3);
for c=1:N_Seg+1 + 1

    dTheta = 1 / N_Seg / natR;
    
    UPcircle_Nodes(c, 1) =  natR * sin( pi+dTheta - (c-1) * dTheta );
    UPcircle_Nodes(c, 3) =  natR * cos( pi+dTheta - (c-1) * dTheta ) + 1/pi;
    
end
Nodes{1}=UPcircle_Nodes;
    
Lowcircle_Nodes = zeros(N_Seg+1 + 1,3);
for c=1:N_Seg+1 + 1

    dTheta = 1 / N_Seg / natR;

    Lowcircle_Nodes(c, 1) = natR * sin( dTheta-(c-1) * dTheta ) ; 
    Lowcircle_Nodes(c, 3) = natR * cos( dTheta-(c-1) * dTheta ) + 1/pi;
    
end
Nodes{2}=Lowcircle_Nodes;

DOF=cell(2,1); 
for i=1:1:2
    DOF{i} = zeros(4*nv-1,1);
    for c=1:nv
        DOF{i}( 4 * (c-1) + 1) = Nodes{i}(c,1);
        DOF{i}( 4 * (c-1) + 2) = Nodes{i}(c,2);
        DOF{i}( 4 * (c-1) + 3) = Nodes{i}(c,3);
    end
    DOF{i}(4:4:end) = 0;
end

end
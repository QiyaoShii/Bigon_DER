function [Nodes,JNodes]=Initial_shape(N_Seg)

Nodes = cell(2,1);
for i= 1:2
    Nodes{i} = zeros(N_Seg+1+1,3);
end
%%%%%
    natR=1/pi;

UPcircle_Nodes =zeros(N_Seg+1 + 1,3);
for c=1:N_Seg+1 + 1

    dTheta = 1 / N_Seg / natR;
    
    UPcircle_Nodes(c, 1) =  natR * sin( pi - (c-1) * dTheta );
    UPcircle_Nodes(c, 3) =  natR * cos( pi - (c-1) * dTheta ) + 1/pi;
    
end
UPcircle_Nodes(N_Seg+1+1,1) = - 1/N_Seg ;
UPcircle_Nodes(N_Seg+1+1,3) = 2/pi;
Nodes{1}=UPcircle_Nodes;
    
Lowcircle_Nodes = zeros(N_Seg+1 + 1,3);
for c=1:N_Seg+1 + 1

    dTheta = 1 / N_Seg / natR;

    Lowcircle_Nodes(c, 1) = natR * sin( dTheta-(c-1) * dTheta ) ; 
    Lowcircle_Nodes(c, 3) = natR * cos( dTheta-(c-1) * dTheta ) + 1/pi;
    
end
Lowcircle_Nodes(1,1) = 1/N_Seg ;
Lowcircle_Nodes(1,3) = 2/pi;
Nodes{2}=Lowcircle_Nodes;


%%%%%


JNodes = cell(1,1);
JNodes{1} = [Nodes{2}(1,:);Nodes{1}(end-1:end,:)];

% %%test joints
% NodesX=[JNodes{1}(:,1)];
% NodesY=[JNodes{1}(:,2)];
% NodesZ=[JNodes{1}(:,3)];
% plot3(NodesX,NodesY,NodesZ)
% axis equal
% view([0,1,0])
% 
% %%test strip1
% NodesX=Nodes{1}(:,1);
% NodesY=Nodes{1}(:,2);
% NodesZ=Nodes{1}(:,3);
% plot3(NodesX,NodesY,NodesZ)
% axis equal
% view([0,1,0])
% grid on
% hold on
% %%test strip 2
% i=2;
% NodesX=[Nodes{i}(:,1)];
% NodesY=[Nodes{i}(:,2)];
% NodesZ=[Nodes{i}(:,3)];
% 
% 
% plot3(NodesX,NodesY,NodesZ)
% axis equal
% % view([1,0,0])
% view([0,-1,0])
% grid on

end
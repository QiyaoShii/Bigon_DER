%clc;clear all
%load('D:\OneDrive\Desktop\DER_Stability_Test\Srptin_NC2\data\V2_antisysmetry\sol7.mat', 'data')
global NC 
NC = 3;
f=figure('units','normalized','position',[.1 .1 .6 .6]);

Segments = data{3,2}.Segments;
%initialize x
for i = 1:4*NC+1
    for j = 1: (size(Segments{i}.DOF,1)+1)/4
    Segments{i}.Nodes(j,1) = Segments{i}.DOF(4*(j-1)+1);
    Segments{i}.Nodes(j,2) = Segments{i}.DOF(4*(j-1)+2);
    Segments{i}.Nodes(j,3) = Segments{i}.DOF(4*(j-1)+3);
    end
end
%%FirstSegments
i = 1;
for j = 1:size(Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=Segments{i}.Nodes(j,1) +2.*k.*1/250.*Segments{i}.m1(j,1);
        Ry(j,k+5)=Segments{i}.Nodes(j,2) +2.*k.*1/250.*Segments{i}.m1(j,2);
        Rz(j,k+5)=Segments{i}.Nodes(j,3) +2.*k.*1/250.*Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on 


%%MidSegments
for i = 2:4*NC
    clear Rx Ry Rz
    for j = 2:size(Segments{i}.Nodes,1)-1
        for k=-4:1:4
            Rx(j-1,k+5)=Segments{i}.Nodes(j,1) +2.*k.*1/250.*Segments{i}.m1(j-1,1);
            Ry(j-1,k+5)=Segments{i}.Nodes(j,2) +2.*k.*1/250.*Segments{i}.m1(j-1,2);
            Rz(j-1,k+5)=Segments{i}.Nodes(j,3) +2.*k.*1/250.*Segments{i}.m1(j-1,3);
        end
    end
    surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on 

end
%%LastSegments
i =4*NC+1;
clear Rx Ry Rz
for j = 2:size(Segments{i}.Nodes,1)
    for k=-4:1:4
        Rx(j-1,k+5)=Segments{i}.Nodes(j,1) +2.*k.*1/250.*Segments{i}.m1(j-1,1);
        Ry(j-1,k+5)=Segments{i}.Nodes(j,2) +2.*k.*1/250.*Segments{i}.m1(j-1,2);
        Rz(j-1,k+5)=Segments{i}.Nodes(j,3) +2.*k.*1/250.*Segments{i}.m1(j-1,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on 

%view([-1,-1,1])
%axis([-1,3,-2,2,-2,2])
axis equal
axis on
hold on
%% center lime
% Nodes = Segments{1}.Nodes;
% for i = 2:9
%     Nodes = [Nodes;Segments{i}.Nodes];
% end
% plot3(Nodes(:,1),Nodes(:,2),Nodes(:,3))

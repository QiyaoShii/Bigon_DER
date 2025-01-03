clear all

%% Render
%% planer configuration 30 degree
sol=coco_read_solution('Basic_30',42);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');

axis equal
view([0,1,0])

%% planer configuration 150 degree

sol=coco_read_solution('Basic_30',9);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor',[0.65,0.65,0.65],'EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor',[0.65,0.65,0.65],'EdgeColor','none');

axis equal


%% Branch1 configuration 90 degree Red

sol=coco_read_solution('Branch 1_30',6);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','r','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','r','EdgeColor','none');hold on

axis equal;grid off
hold on
view([1,1,-1])

%% Branch1 configuration 90 degree Blue

sol=coco_read_solution('Branch 1_30',17);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on

axis equal;grid off
hold on
view([1,1,-5])


%% Branch2 configuration 120 degree Blue

sol=coco_read_solution('Branch 2_30',8);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rx,Ry,Rz,'FaceColor','b','EdgeColor','none');hold on

axis equal;grid off
hold on
view([1,1,-5])

%% Branch2 configuration 120 degree Blue

sol=coco_read_solution('Branch 2_30',27);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Rx,Ry,'FaceColor','b','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*1/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Rx,Ry,'FaceColor','b','EdgeColor','none');hold on

axis equal;grid off
hold on
view([1,1,-5])
%%
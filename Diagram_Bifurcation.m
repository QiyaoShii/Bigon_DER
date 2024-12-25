clear all; clc;
%% 2.37 bifurcation diagram

figure('units','norm','position',[.5 .5 .255 .4]);
axis off
ax = gca;               % get the current axis
ax.Clipping = 'off';
%% Basic solution
ax1=axes('position',[0.1 0.15 0.85 0.8]);
[m,BP,Mo,Num_BP,Stability_Sign] = read_BP_data('Basic_30');

%%%graphics
normX=180-cell2mat(m(Num_BP(3):Num_BP(4),8)).*180./pi*2;disY=cell2mat(m(Num_BP(3):Num_BP(4),12));
plot(normX,disY,'-','Color','k','LineWidth',2)
hold on

normX=180-cell2mat(m(2:Num_BP(3),8)).*180./pi*2;disY=cell2mat(m(2:Num_BP(3),12));
plot(normX,disY,'-','Color','[0.65 0.65 0.65]','LineWidth',2)
hold on


%%%Legend
plot(180-BP(3)*180/pi*2,Mo(3),'o','MarkerSize',5.0,'MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
text('Position',[180-BP(3)*180/pi*2+3,Mo(1)+4],'string','$B_1$','Interpreter','latex','FontSize',18)
hold on
plot(180-BP(2)*180/pi*2,Mo(2),'o','MarkerSize',5.0,'MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
text('Position',[180-BP(2)*180/pi*2+3,Mo(2)+4],'string','$B_2$','Interpreter','latex','FontSize',18)
hold on

%% Branch 1

[m,BP,Mo,Num_BP,Stability_Sign] = read_BP_data('Branch 1_30');

%%%graphics
normX=180-cell2mat(m(2:end,8)).*180./pi*2;disY=cell2mat(m(2:end,12));
plot(normX,disY,'-','Color','k','LineWidth',2)
hold on

%% Branch 2
[m,BP,Mo,Num_BP,Stability_Sign] = read_BP_data('Branch 2_30');

%%%graphics
normX=180-cell2mat(m(2:end,8)).*180./pi*2;disY=cell2mat(m(2:end,12));
plot(normX,disY,'-','Color','[0.65 0.65 0.65]','LineWidth',2)
hold on

%%
axis([0,180,-90,90])

set(gca,'FontSize',15,'linewidth',1,'XTick',[0 60 120 180], 'XTickLabel', {'0','60','120' '180'},'TickLength',[0.010, 0.03])
set(gca,'YTick',[-90 -45 0 45 90], 'YTickLabel', {'-90', '-45', '0','45', '90'})
xtick= get(gca,'xlabel');
set(xtick,'Units','Normalized','Position', [0.5, -0.05, 0],'string','$\gamma (\circ)$','Interpreter','latex','FontSize',20)
ytick= get(gca,'ylabel');
set(ytick,'Units','Normalized','Position', [-0.04, 0.5, 0],'string','$\alpha (\circ)$','Interpreter','latex','FontSize',20)
%% render 
%% planer configuration 30 degree
ax2=axes('position',[0.1 0.55 0.2 0.25 ]);
box on
sol=coco_read_solution('Basic_30',42);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');

axis equal
axis off
view([0,-1,0])

%% planer configuration 150 degree
ax3=axes('position',[0.75 0.55 0.18 0.25 ]);

sol=coco_read_solution('Basic_30',9);
i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor',[0.65,0.65,0.65],'EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor',[0.65,0.65,0.65],'EdgeColor','none');

axis equal
axis off
view([0,-1,0])

%% Branch1 configuration 90 degree
ax2=axes('position',[0.3 0.7 0.2 0.25]);
box on
sol=coco_read_solution('Branch 1_30',6);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');

axis equal
axis off
view(10,-45)
%% Branch1 configuration 90 degree
ax2=axes('position',[0.3 0.15 0.2 0.25]);
box on
sol=coco_read_solution('Branch 1_30',17);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');

axis equal
axis off
view(-10,-45)
%% Branch1 configuration 90 degree
ax2=axes('position',[0.3 0.15 0.2 0.25]);
box on
sol=coco_read_solution('Branch 1_30',17);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','k','EdgeColor','none');

axis equal
axis off
view(-10,-45)
%% Branch1 configuration 90 degree
ax2=axes('position',[0.6 0.55 0.2 0.25]);

box on
sol=coco_read_solution('Branch 2_30',8);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','[0.65,0.65,0.65]','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','[0.65,0.65,0.65]','EdgeColor','none');

axis equal
axis off
view(10,-45)
%% Branch1 configuration 90 degree
ax2=axes('position',[0.6 0.3 0.2 0.25]);
box on
sol=coco_read_solution('Branch 2_30',27);

i=1;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','[0.65,0.65,0.65]','EdgeColor','none');hold on

i=2;
for j = 1:size(sol{3,2}.Segments{i}.Nodes,1)-1
    for k=-4:1:4
        Rx(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,1) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,1);
        Ry(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,2) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,2);
        Rz(j,k+5)=sol{3,2}.Segments{i}.Nodes(j+1,3) +k.*3/250.*sol{3,2}.Segments{i}.m1(j,3);
    end
end
surf(Rz,Ry,Rx,'FaceColor','[0.65,0.65,0.65]','EdgeColor','none');

axis equal
axis off
view(-10,-45)
global BCx0 BCx1 BCx2 BCu0 BCu1 BCu2 natR
%% centerline and nodes
%x=[BC(1:7);chart.x(1:3*nv+ne-7)];
% x=[BCx0; chart.x(1:3*(nv-2)+(ne-1)-6);BCx1; chart.x(3*(nv-2)+(ne-1)-5);BCx2];
% x=[BCx0; chart.x(1:3*(nv-2)+(ne-1)-6);BCx1; chart.x(3*(nv-2)+(ne-1)-5);BCx2];
% x=[BC(1:7);chart.x(1:192);BC(8:14);chart.x(193:384)];
p=0.044;
%x=[0;0;0;0;0;0;0.095;chart.x(1:1589);1.27323954473516+p;0;-0.00954929658551368;0;1.27323954473516+p;0;0];
x = [BCx0; chart.x(1:3*(nv-2)+(ne-1)-7);4*natR+p*4*natR;0;-1.5*natR/15;0;4*natR+p*4*natR;0;0]; 
x1 = x(1:4:end);
x2 = x(2:4:end);
x3 = x(3:4:end);
plot3(x1,x2,x3, 'ko-');
axis([0, 0.2, -0.03, 0.03,-0.2, 0.2])

%% Figure of ribben
for i=1:1:199
    for j=-5:1:5
    Rx(i,j+6)=x1(i+1) +2.*j.*1/250.*m2(i,1);%(q1(i).*q3(i)+q2(i).*q4(i));
    Ry(i,j+6)=x2(i+1)+2.*j.*1/250.*m2(i,2);%(q4(i).*q3(i)-q1(i).*q2(i));
    Rz(i,j+6)=x3(i+1)+2.*j.*1/250.*m2(i,3);%(q4(i).^2+q1(i).^2-0.5);
    end
end
surf(Rx,Ry,Rz,'FaceColor','r','EdgeColor','none');hold on

%axis equal
for i=1:1:4
plot3([-0.04 -0.0],[0 0],[(-0.2+(i-1)*0.08) (-0.2+(i-1)*0.08)+0.08],'color',[0.65 0.65 0.65],'LineWidth',2.0)
hold on
end
plot3([0 0],[0 0],[-0.15 0.15],'color',[0.65 0.65 0.65],'LineWidth',2.0)
hold on
mArrow3([x1(end)+0.2 x2(end) x3(end)],[x1(end) x2(end) x3(end)],'color','k','stemWidth',0.003,'tipWidth',0.015); 
hold on
view([0,-1,0.1])
%axis([-0.1, 1.05,-0.01,0.01,-0.5,0.5])
axis off
hold on
%% bifurcation Diagram
theme = struct('special',{{'BP'}});
coco_plot_bd(theme,'Serpentine1','gar', 'zend');
hold on
theme = struct('special',{{'SN' 'HB'}});
coco_plot_bd(theme,'2Canti_DL3','gar', 'zend');
hold on
theme = struct('special',{{'SN' 'HB'}});
coco_plot_bd(theme,'2Canti_DL3bp','gar', 'zend');
hold on
theme = struct('special',{{'SN' 'HB'}});
coco_plot_bd(theme,'2Canti_DL3bp1','gar', 'zend');
theme = struct('special',{{'SN' 'HB'}});
coco_plot_bd(theme,'Serpentine1bp','gar', 'zend');
hold on
axis([-3,0,-0.7,0.7])
% axis off
% ax = gca;               % get the current axis
% ax.Clipping = 'off';
set(gca,'FontSize',15,'linewidth',1,'XTick',[-3 -1.5 -0], 'XTickLabel', {'-3','-1.5','-0'},'TickLength',[0.010, 0.03])
set(gca,'YTick',[-0.7  0.7], 'YTickLabel', {'-0.7' '0.7'})
xtick= get(gca,'xlabel');
set(xtick,'Units','Normalized','Position', [0.43, -0.05, 0],'string','$F$','Interpreter','latex','FontSize',16)
ytick= get(gca,'ylabel');
set(ytick,'Units','Normalized','Position', [-0.04, 0.5, 0],'string','$y_0$','Interpreter','latex','FontSize',20)
